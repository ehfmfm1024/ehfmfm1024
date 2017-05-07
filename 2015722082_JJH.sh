#!/bin/bash
echo "===print file information ==="
echo "current directory : `pwd`"
echo -n "the number of elements : `du -s`"
echo -e "\n"

find -type d | sort > list_dir
num=1

while read dir
do	
	name=`readlink -e "$dir"`
	name=`basename $name`
	echo [$num] $name
	echo -------------------------------INFOMATION-------------------------------
	echo "[34m"file type : `stat -c %F $dir`
	echo "[30m"file size : `stat -c %s $dir`
	stat -c "modify time : %y" $dir
	stat -c "permission : %a" $dir
	echo  absolute path : `readlink -e "$dir"`
	echo  relative path : $dir
	echo "------------------------------------------------------------------------"

#file
	find $dir -maxdepth 1 -type f | sort > list_file
	f_num=1
	while read file
	do

		name=`basename $file`
		echo [$f_num] $name
		echo -------------------------------INFOMATION-------------------------------
		echo file type : `stat -c %F $file`
		echo file size : `stat -c %s $file`
		stat -c "modify time : %y" $file
		stat -c "permission : %a" $file
		echo  absolute path : `readlink -e "$file"` 
		echo  relative path : $file
		echo "------------------------------------------------------------------------"
		f_num=`expr $f_num + 1`
	done < list_file

#fifo
	find $dir -maxdepth 1 -type p | sort > list_fifo
	p_num=1
	while read fifo
	do
		name=`basename $fifo`
		echo [$p_num] $name
		echo -------------------------------INFOMATION-------------------------------
		echo "[32m"file type : `stat -c %F $fifo`
		echo "[30m"file size : `stat -c %s $fifo`
		stat -c "modify time : %y" $fifo
		stat -c "permission : %a" $fifo
		echo  absolute path : `readlink -e "$fifo"`
		echo  relative path : $fifo
		echo "------------------------------------------------------------------------"
		p_num=`expr $p_num + 1`
	done < list_fifo
	
	num=`expr $num + 1`
done < list_dir
