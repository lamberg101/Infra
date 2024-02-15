

password asmsnmp exa62A, 62B, TBS, IMC, BSD = welcome1
cara reset password asmsnmp
$ . .grid_profile
$ asmcmd -p
ASMCMD [+] > lspwusr
        Username sysdba sysoper sysasm 
             SYS   TRUE    TRUE   TRUE 
         ASMSNMP   TRUE   FALSE  FALSE 
CRSUSER__ASM_001   TRUE   FALSE   TRUE 

*** pastikan ada user ASMSNMP dgn sysdba "TRUE"
ASMCMD [+] > orapwusr --modify ASMSNMP
Enter password: