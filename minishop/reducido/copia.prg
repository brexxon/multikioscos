
close database all 

**SI NO EXISTE, CREO EL DIRECTORIO 

c_backup_directory = "c:\multikioscos\copia" 



c_backup_filename=alltrim("c:\multikioscos\copia\multi"+strtran(dtoc(date()),"/","")) 
*c_winzip_filepath="c:\multikioscos" 

*if file(c_winzip_filepath) 
c_data_source =" c:\multikioscos"+"\*.*" 
run /n "c:\multikioscos\winzip.exe" -min -a &c_backup_filename &c_data_source 
*!*	else 
*!*	messagebox("Necesita Instalar Winzip para ejecutar esta opción",48,_screen.caption) 
*!*	Endif	
*!*	Clos data
*!*		ON SHUTDOWN
*!*		Clear EVENTS
*!*		CLOSE ALL
*!*		QUIT

