#!/bin/bash
#Simple script for VirtuaBox memory extraction
# Usage: vboxmemdump.sh <VM name>
echo "Type your VM name, followed by [ENTER]:"
read VMname

VBoxManage debugvm $VMname dumpvmcore --filename=$VMname.elf
rm $VMname.raw
echo "------- The first starting section is -------"
objdump -h $VMname.elf|egrep -w "(Idx|load1)"
echo "Type size set value, followed by [ENTER] :"
read size1
#size=0x${(objdump -h $VMname.elf|egrep -w "(Idx|load1)" | tr -s " " |  cut -d " " -f 4)}
size=0x$size1
echo "Type off set value with remove fist number 0 [example : 00000720 just type 720], followed by [ENTER] :"
read off1
off=0x$off1

#off1=objdump -h $VMname.elf|egrep -w load1 | tr -s " " |  cut -d " " -f 7 | tr /a-z/ /A-Z/
#off=0x${(10#$off1)}

head -c $(($size+$off)) $VMname.elf|tail -c +$(($off+1)) > $VMname.raw

echo "You file RAW is created..."

rm $VMname.elf
