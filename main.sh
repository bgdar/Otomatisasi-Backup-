#! /bin/bash

#function untuk menghandle data    yang di simpan ke folder
#handleBackup (){
  
#}

echo "pilih folder yang akan di backup :"
echo "gunakan perintah 'init' untuk inisialisai folder saat ini \n "
read path_folder

#cek apakah input adalah folder
if [[ ! -d "$path_folder" && "$path_folder" != "init"  ]]; then
  echo "not is folder"
  #cek apakah perintah adalah init
elif [[ "$path_folder" == "init" ]]; then
  path="$PWD"
  echo "path saat ini  => ,$path user $USER"
else
  echo "arah , $path_folder"
fi


