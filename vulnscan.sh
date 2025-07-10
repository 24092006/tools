#!/bin/bash
echo "🅰🆉🅸🆉 🆂🅲🅰🅽"
echo " IP manzilni kirit:"
read target_ip

echo "[*] Skaner boshlangan: $(date)" > results.txt
echo " NISHON: $target_ip" >> results.txt
echo "===============================" >> results.txt

# NMAP asosiy skan
echo "[+] Nmap bilan portlar va servislar tekshirilmoqda..." | tee -a results.txt
nmap -sC -sV -Pn "$target_ip" >> results.txt

# NMAP zaiflik skaneri
echo -e "\n[+] Nmap (vuln script) bilan zaifliklar aniqlanmoqda..." | tee -a results.txt
nmap --script vuln "$target_ip" >> results.txt

# Nikto bilan HTTP zaifliklarni tekshirish
echo -e "\n[+] Nikto bilan web server tahlil qilinmoqda..." | tee -a results.txt
nikto -h "http://$target_ip" >> results.txt

# WhatWeb bilan texnologiyalarni aniqlash
echo -e "\n[+] WhatWeb orqali web texnologiyalar aniqlanmoqda..." | tee -a results.txt
whatweb "$target_ip" >> results.txt

# Nuclei skan (faqat HTTP uchun)
echo -e "\n[+] Nuclei bilan zaifliklar tekshirilmoqda..." | tee -a results.txt
nuclei -u "http://$target_ip" -silent >> results.txt

echo -e "\n Tekshiruv tugadi! Natijalar 'results.txt' faylida saqlandi."
