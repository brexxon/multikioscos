*** 
*** ReFox X  #UK933629  MANRIQUE ORELLANA  MANSOFT SYSTEMS [VFP80]
***
SET EXCLUSIVE OFF
SET MULTILOCKS ON
SET DEFAULT TO SYS(2003)
IF USED("inte")
     SELECT inte
     CURSORSETPROP("Buffering", 5,  ;
                  "inte")
ELSE
     SELECT 0
     USE 'inte'
     CURSORSETPROP("Buffering", 5,  ;
                  "inte")
ENDIF
IF USED("errores")
     SELECT errores
     CURSORSETPROP("Buffering", 5,  ;
                  "errores")
ELSE
     SELECT 0
     USE 'errores'
     CURSORSETPROP("Buffering", 5,  ;
                  "errores")
ENDIF
IF USED("MERCA")
     SELECT merca
     CURSORSETPROP("Buffering", 5,  ;
                  "MERCA")
ELSE
     SELECT 0
     USE 'MERCA'
     CURSORSETPROP("Buffering", 5,  ;
                  "MERCA")
ENDIF
IF USED("moneda")
     SELECT moneda
     CURSORSETPROP("Buffering", 5,  ;
                  "moneda")
ELSE
     SELECT 0
     USE 'moneda'
     CURSORSETPROP("Buffering", 5,  ;
                  "moneda")
ENDIF
ENDPROC
**
*** 
*** ReFox - retrace your steps ... 
***
