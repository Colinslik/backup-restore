#!/bin/bash

work_tree=/etc/config

local=`pwd`

if [ -z "$1" ]; then
  QPKG_Name="HybridBackup"
else
  QPKG_Name="$1"
fi

input_file="$QPKG_Name.conf"

if [ -z "$2" ]; then
   input_path=$local/$input_file
else
   input_path=$2
fi

output_file="qpkg.conf"

if [ -z "$3" ]; then
   output_path=$work_tree/$output_file
else
   output_path=$3
fi

sed -n '1,$p' $input_path >> $output_path


#setcfg $QPKG_Name Enable FALSE -f $output_path

#sleep 3

#setcfg $QPKG_Name Enable TRUE -f $output_path

Script_path=`getcfg $QPKG_Name Shell -f $output_path`

$Script_path restart
