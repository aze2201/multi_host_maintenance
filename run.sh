#!/bin/sh

command_file="remote_command.sh"
host_info_file="hosts.info"
curr=`pwd`
log_folder=$curr/log


sftp_f()
{
HOSTNAME=$1
USER=$2
PSWD=$3
COMMAND=$4
if [[ $@ ]]; then
/usr/bin/expect<<EOF
spawn sftp $USER@$HOSTNAME
expect {
")?" { send "yes\r"; exp_continue }
"assword" { send "$PSWD\r"}
}
expect "sftp>" 	{send "$COMMAND\r"}
expect "sftp>" 	{send bye\r}
expect eof
EOF
else
echo "HELP : sftp <remote ip> <remote user> <remote password> '<remote command>'"
fi
}


remote_command()
{
HOSTNAME=$1
USER=$2
PSWD=$3
COMMAND=$4
if [[ $@ ]]; then
/usr/bin/expect<<EOF
set timeout -1
spawn ssh $USER@$HOSTNAME
expect {
")?" { send "yes\r"; exp_continue}
"assword" { send "$PSWD\r"}
}
expect "#" {send "$COMMAND\r"}
expect "#" {send exit\r}
expect eof
EOF
else
echo "HELP : remote_command <remote ip> <remote user> <remote password> '<remote command>'"
fi
}

run_ftp()
{
while read lineee
do
ip=`echo $lineee| awk -v FS='|' '{print $1}'`
user=`echo $lineee| awk -v FS='|' '{print $2}'`
pass=`echo $lineee| awk -v FS='|' '{print $3}'`
upload="sftp_f $ip $user $pass 'mput $command_file'"
eval $upload
done < $host_info_file
}

run_ssh()
{
while read lineee
do
ip=`echo $lineee| awk -v FS='|' '{print $1}'`
user=`echo $lineee| awk -v FS='|' '{print $2}'`
pass=`echo $lineee| awk -v FS='|' '{print $3}'`
run="remote_command $ip $user $pass 'chmod +x $command_file;./$command_file'" 
eval $run > $log_folder/$ip.txt
done < $host_info_file
}


main()
{
if [ ! -d log_folder ]
then
mkdir $log_folder
fi
run_ftp
run_ssh
}
main
