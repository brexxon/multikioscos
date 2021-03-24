*** 
*** ReFox X  #UK933629  MANRIQUE ORELLANA  MANSOFT SYSTEMS [VFP80]
***
IF USED("abrek")
     SELECT abrek
     CURSORSETPROP("Buffering", 5,  ;
                  "abrek")
ELSE
     SELECT 0
     USE 'abrek'
     CURSORSETPROP("Buffering", 5,  ;
                  "abrek")
ENDIF
GOTO BOTTOM
IF ALLTRIM(abrek.estado) =  ;
   "ABIERTO"
     DO FORM movi
ELSE
     MESSAGEBOX( ;
               "NO HAY UNA CAJA ABIERTA...debe abrir una caja primero en el menu FACTURACION",  ;
               48, "ATENCION")
ENDIF
ENDPROC
**
*** 
*** ReFox - retrace your steps ... 
***
