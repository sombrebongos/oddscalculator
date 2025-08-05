#!/bin/bash
#sombrebongos, 5 August 2025

HIJAU='\033[0;32m'
MERAH='\033[0;31m'
NC='\033[0m'

while true; do
    clear
    echo -e "
 ####  ###### #####   ##        #  ####  #####
#    # #        #    #  #       # #    # #    #
#      #####    #   #    #      # #    # #####
#  ### #        #   ######      # #    # #    #
#    # #        #   #    # #    # #    # #    #
 ####  ######   #   #    #  ####   ####  #####
        coded by ${MERAH}github.com/sombrebongos${NC}
"
    echo "Menu:"
    echo "1. Single Bet"
    echo "2. Parlay"
    echo "0. Keluar"

    read -p "> " mode

    if [ "$mode" == "0" ]; then
        echo "See ya, gambler! :D"
        break
    elif [ "$mode" == "1" ]; then
        clear
        echo -e "
 #####                                   ######               
#     # # #    #  ####  #      ######    #     # ###### ##### 
#       # ##   # #    # #      #         #     # #        #   
 #####  # # #  # #      #      #####     ######  #####    #   
      # # #  # # #  ### #      #         #     # #        #   
#     # # #   ## #    # #      #         #     # #        #   
 #####  # #    #  ####  ###### ######    ######  ######   #
"
        read -p "Masukkan odds (contoh: 1.95): " odds
        read -p "Masukkan nominal bet: " stake

        menang_full=$(echo "$stake * $odds" | bc -l)
        profit_full=$(echo "$menang_full - $stake" | bc -l)

        menang_separuh=$(echo "($stake / 2 * $odds) + ($stake / 2)" | bc -l)
        profit_separuh=$(echo "$menang_separuh - $stake" | bc -l)

        kalah_separuh=$(echo "$stake / 2" | bc -l)

        echo -e "\n===== HASIL ====="
        printf "${HIJAU}Menang full     : Dapat %.2f (Profit: %.2f)${NC}\n" "$menang_full" "$profit_full"
        printf "${HIJAU}Menang separuh  : Dapat %.2f (Profit: %.2f)${NC}\n" "$menang_separuh" "$profit_separuh"
        printf "${MERAH}Kalah separuh   : Rugi -%.2f${NC}\n" "$kalah_separuh"
        printf "${MERAH}Kalah full      : Rugi -%.2f${NC}\n\n" "$stake"

        read -p "Tekan ENTER untuk lanjut..." _

    elif [ "$mode" == "2" ]; then
        clear
        echo -e "
######     #    ######  #          #    #     # 
#     #   # #   #     # #         # #    #   #  
#     #  #   #  #     # #        #   #    # #   
######  #     # ######  #       #     #    #    
#       ####### #   #   #       #######    #    
#       #     # #    #  #       #     #    #    
#       #     # #     # ####### #     #    #    
"
        read -p "Berapa banyak match di parlay? " n

        total_odds=1
        for ((i=1; i<=n; i++)); do
            read -p "Masukkan odds match ke-$i: " o
            total_odds=$(echo "$total_odds * $o" | bc -l)
        done

        read -p "Masukkan nominal bet: " stake

        menang_full=$(echo "$stake * $total_odds" | bc -l)
        profit_full=$(echo "$menang_full - $stake" | bc -l)

        echo -e "\n===== HASIL PARLAY ====="
        printf "Total odds      : %.2f\n" "$total_odds"
        printf "${HIJAU}Menang full     : Dapat %.2f (Profit: %.2f)${NC}\n" "$menang_full" "$profit_full"
        printf "${MERAH}Kalah full      : Rugi -%.2f${NC}\n\n" "$stake"

        read -p "Tekan ENTER untuk lanjut..." _
    else
        echo "Pilihan tidak valid!"
        sleep 1.5
    fi
done
