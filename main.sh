#! /bin/bash

#konfigurasi TPUT jika ada atau tidak ada pada system
if command -v tput &> /dev/null; then
  #variabel warna
  RED=$(tput setaf 1)
  CYAN=$(tput setaf 6)
  GREEN=$(tput setaf 2)
  BLUE=$(tput setaf 4)
   #gunakan untuk mengembalikan ke Dfaultt(warna|format)
  RESET=$(tput sgr0)
  #format text
  BOLD=$(tput bold)
else
  #jika tidak di temukan maka koongkan variabel agar tidak terjadi error
  RED=""
  CYAN=""
  GREEN=""
  BLUE=""

  BOLD=""
  RESET=""
fi

#function untuk menghandle data yang akan di simpan ke folder
handleBackup (){
  while true; do
    current_date=$(date +"%y-%m-%d")  

    #cek jika waktu sekarang sama dengan yang di berikan
    if [[ "$3" == "$current_date" ]]; then  
        #cek apaah di system tersedia rsync
       if command -v rsync &> /dev/null; then
          rsync -av --progress "$2" "$1"
          echo" "
          echo "${BLUE}file dan folder berhasil di salin${BOLD} [ rsync ]${RESET}" 
       else
       #salin semua data dari path $p-2
        cp -r --no-preserve=mode "$2"* "$1" # --no-preserve =lewati yg tidak bisa di sali
        echo " "
        echo "${BLUE}berhasil di salin${BOLD} [ cp ]${RESET}"
       fi     
    fi
    echo " "
    echo "${CYAN}masih menunggu...${RESET}"
    
    #jika parameter tidak ada atau kosong
    if [[  -z "$4"  ]];then
      sleep 1800 # default 30 menit 
    else   
      sleep $4
    fi
  done
 }

#variable key-value untuk menampung data_handle
declare -A data_handle

#-----[ main commad ]-------
echo " "
echo "${GREEN}pilih folder tempat backup datanya:${RESET}"
read path_to_folder

#cek apakah input adalah folder
if [[ ! -d "$path_to_folder" ]]; then
  echo " "
  echo "${RED}this's not folder${RESET}"
  exit 1 #keluar 
else
  data_handle[path_to_folder]="$path_to_folder"
fi

echo " "
echo "${GREEN}masukan path dari folder yang akan di backup"
echo "gunakan perintah 'init' untuk inisialisai folder saat ini${RESET} "
read current_path

#cek apakah input adalah folder
if [[ ! -d "$current_path" && "$current_path" != "init"  ]]; then
  echo " "
  echo "${RED}this's not folder${RESET}"
  exit 1
  #cek apakah perintah adalah init
elif [[ "$current_path" == "init" ]]; then
  path="$PWD"
  #simpan path yang di dapat
  data_handle[current_path]="$path"
else
  data_handle[current_path]="$current_path"
fi

if [[ "${data_handle[path_to_folder]}" == "${data_handle[current_path]}" ]]; then
  echo "${RED}path nya sama ... ini tidak benar coba jalankan ulang${RESET}"
  unset $data_handle #hapus semua key
  exit 1
fi

echo " "
echo  "${GREEN} tetapkan jeda waktu bakup (format => yy-mm-dd ,example=> 25-03-12 ) atau kosongkan untuk waktu sekarang${RESET}" 
read time
#jika inputah kosong gunakan waktu saat ini
if [[ -z "$time" ]]; then
  time_now=$(date +"%y-%m-%d")
  data_handle[time]="$time_now"
else
  data_handle[time]="$time"
fi

echo " "
echo "${GREEN}masukan berapa lama waktu tunggu dalam angka detik (default=1800 (30 menit)) ${RESET}"
read times_seccond
data_handle[times_seccond]="$times_seccond"

#--- tampilakn waktu dengan format----#
#hitung jumlah jam dalam bentuk decimal menggunakan awk
total_hours=$(awk "BEGIN {print $times_seccond / 3600}")
#hitung jam dalam format bulat 
#hours=$(echo "$total_hours" | cut -d. -f1)
#ambil sebelum titik decimal
hours=$(total_hours%.*)

#hitung sisa menit
remaining_minutes=$(( (total_hours % 3600 ) / 60))
if [[ $remaining_minutes -eq 0 ]]; then
  echo "$times_seccond = $hours jam" #jika pas dalam jam
elif [[ $remaining_minutes -ge 30 ]]; then
  #jika lebih dari setengah jam
  echo "$times_seccond = $hours.5 jam"
else
  total_hours=$(( total_hours / 60 ))
  #total menit jika kurang dari setengah jam
  echo "$times_seccond  = $total_hours menit"
fi
echo " data  ${data_handle[time]}"
#lakukan operasi untuk menampilakan waktu yang akan di jalanakna dalamformat jam

#jalankan fungsi ( p-1 = path tujuan, p-2 = path yang akan di backup)
handleBackup "${data_handle[path_to_folder]}" "${data_handle[current_path]}" "${data_handle[time]}" "${data_handle[times_seccond]}"
