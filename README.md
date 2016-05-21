# multihost daily maintenance

run.sh script will execute remote_command.sh scipt on remote host. So you can open and change remote_command.sh script as you wish.
run.sh will use hosts.info file to get ip|user|pasword

protocol will use ssh and sftp


example:
1.   modify hosts.info file according your system config
  
2.   optional: modify add some command or function to remote_command.sh command;  you can extend command list cmdlist ( ; separated )
3.   chmod +x run.sh
4.   dos2unix *
4.   ./run.sh
5.   it will create log folder and indisde log folder will create txt output for each host.
