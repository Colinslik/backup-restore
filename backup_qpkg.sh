#!/bin/bash

work_tree=/etc/config

local=`pwd`

if [ -z "$1" ]; then
  QPKG_Name="HybridBackup"
else
  QPKG_Name="$1"
fi

if [ -z "$2" ]; then
   input_path=$work_tree/qpkg.conf
else
   input_path=$2
fi

output_file="$QPKG_Name.conf"

if [ -z "$3" ]; then
   output_path=$local/$output_file
else
   output_path=$3
fi

Start=$(sed -n "/\\[$QPKG_Name]/=" $input_path)

array=($(sed -n '/\[.*]/=' $input_path))

for i in "${!array[@]}"
    do
          if [ "${array[$i]}" = "$Start" ]; then
            first=${array[$i]}
            
            if [ -z "${array[$((i+1))]}" ]; then
               last=\$
            else
               last=$((${array[$((i+1))]}-1))
            fi

            sed -n "${first},${last}"p $input_path > $output_path
          else
            echo  $i 1>/dev/null 2>/dev/null
          fi
    done
