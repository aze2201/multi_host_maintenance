#!/bin/bash
cmdlist="mpstat -P ALL; free -t -m; fdisk -l; df -h; ll /dev/disk/by-id;  pvdisplay; vgdisplay; lvdisplay; ifconfig"


host=`hostname`
curr=`pwd`



run_cmd()
{
countt=`echo $cmdlist| tr ';' '\n'| wc -l`
for ((i=1; i <=$countt; i++))
do
cmd=`echo $cmdlist| tr ';' '\n'| head -${i}| tail -n 1`
echo -e "$host # $curr > "
echo -e "$host # $curr > "
echo -e "$host # $curr > $cmd"
eval $cmd
echo -e "$host # $curr > "
done
}

main()
{
run_cmd
}
main
