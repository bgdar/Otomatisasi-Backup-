#! /bin/bash

#function untuk menghandle data    yang di simpan ke folder
handleBackup (){
  echo "hasil dari = $1"
}

echo "pilih folder yang akan di backup :"
echo "gunakan perintah 'init' untuk inisialisai folder saat ini \n "
read path_folder

#cek apakah input adalah folder
if [[ ! -d "$path_folder" && "$path_folder" != "init"  ]]; then
  echo "not is folder"

  #cek apakah perintah adalah init
elif [[ "$path_folder" == "init" ]]; then
  path="$PWD"
  handleBackup $path
  
else
  echo "arah , $path_folder"
  handleBackup $path_folder
fi


