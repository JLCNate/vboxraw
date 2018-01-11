#!/bin/bash
#Simple script for VirtuaBox memory extraction
# Usage: vboxmemdump.sh <VM name>
echo "Ketikkan nama Mesin Virtual, lalu tekan [ENTER]:"
read VMname

VBoxManage debugvm $VMname dumpvmcore --filename=$VMname.elf
rm $VMname.raw
echo "------- Hasil pengecekan yang pertama diload -------"
objdump -h $VMname.elf|egrep -w "(Idx|load1)"
echo "Masukkan nilai dari size, lalu tekan [ENTER] :"
read size1
#size=0x${(objdump -h $VMname.elf|egrep -w "(Idx|load1)" | tr -s " " |  cut -d " " -f 4)}
size=0x$size1
echo "Masukkan nila File oof dengan menghilangkan semua angka 0 diawal [contohnya : 00000720 maka cukup ketikkan 720], lalu tekan [ENTER] :"
read off1
off=0x$off1

#off1=objdump -h $VMname.elf|egrep -w load1 | tr -s " " |  cut -d " " -f 7 | tr /a-z/ /A-Z/
#off=0x${(10#$off1)}

head -c $(($size+$off)) $VMname.elf|tail -c +$(($off+1)) > $VMname.raw

echo "Dump memori RAW berhasil di buat..."

rm $VMname.elf
