*Space usage PRD

- Masuk user Prod dengan putty
- df -gI untuk melihat space keseluruhan
- cd /app/oracle/weblogic/middleware/user_projects/domains/PRDMCB/servers/ untuk pindah ke spesifik direktori space usage server production
- ls -ltr untuk melihat semua isi server pada production
- cd server pilihan di production
- du -sk *|sort -n|tail untuk melihat log data yang terisi pada masing - masing server
- lalu perintahkan divisi IT DCSM untuk menghapus log data server terkecuali log seminggu yang terbaru