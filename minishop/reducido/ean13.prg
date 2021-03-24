*** 
*** ReFox X  #UK933629  MANRIQUE ORELLANA  MANSOFT SYSTEMS [VFP80]
***
PUBLIC tcstring
tcstring = ""
SELECT table1
GOTO TOP
SCAN
     tcstring = ALLTRIM(barr)
     ? _strtoean13(tcstring)
     REPLACE bar WITH lccod
ENDSCAN
REPORT FORM report1 PREVIEW TO  ;
       PRINTER PROMPT
ENDPROC
**
FUNCTION _StrToEan13
LPARAMETERS tcstring, tlcheckd
PUBLIC lclat, lcmed, lcret,  ;
       lcjuego, lcini, lcresto,  ;
       lccod, lni, lnchecksum,  ;
       lnaux, lajuego(10), lnpri
lcret = ALLTRIM(tcstring)
IF LEN(lcret) <> 12
     = MESSAGEBOX("Error")
     RETURN ""
ENDIF
lnchecksum = 0
FOR lni = 1 TO 12
     IF MOD(lni, 2) = 0
          lnchecksum = lnchecksum +  ;
                       VAL(SUBSTR(lcret,  ;
                       lni, 1)) *  ;
                       3
     ELSE
          lnchecksum = lnchecksum +  ;
                       VAL(SUBSTR(lcret,  ;
                       lni, 1)) *  ;
                       1
     ENDIF
ENDFOR
lnaux = MOD(lnchecksum, 10)
lcret = lcret +  ;
        ALLTRIM(STR(IIF(lnaux = 0,  ;
        0, 10 - lnaux)))
IF tlcheckd
     RETURN lcret
ENDIF
lnpri = VAL(LEFT(lcret, 1))
lajuego(1) = "AAAAAACCCCCC"
lajuego(2) = "AABABBCCCCCC"
lajuego(3) = "AABBABCCCCCC"
lajuego(4) = "AABBBACCCCCC"
lajuego(5) = "ABAABBCCCCCC"
lajuego(6) = "ABBAABCCCCCC"
lajuego(7) = "ABBBAACCCCCC"
lajuego(8) = "ABABABCCCCCC"
lajuego(9) = "ABABBACCCCCC"
lajuego(10) = "ABBABACCCCCC"
lcini = CHR(lnpri + 35)
lclat = CHR(33)
lcmed = CHR(45)
lcresto = SUBSTR(lcret, 2, 12)
FOR lni = 1 TO 12
     lcjuego = SUBSTR(lajuego(lnpri +  ;
               1), lni, 1)
     DO CASE
          CASE lcjuego = "A"
               lcresto = STUFF(lcresto,  ;
                         lni, 1,  ;
                         CHR(VAL(SUBSTR(lcresto,  ;
                         lni, 1)) +  ;
                         48))
          CASE lcjuego = "B"
               lcresto = STUFF(lcresto,  ;
                         lni, 1,  ;
                         CHR(VAL(SUBSTR(lcresto,  ;
                         lni, 1)) +  ;
                         65))
          CASE lcjuego = "C"
               lcresto = STUFF(lcresto,  ;
                         lni, 1,  ;
                         CHR(VAL(SUBSTR(lcresto,  ;
                         lni, 1)) +  ;
                         97))
     ENDCASE
ENDFOR
lccod = lcini + lclat +  ;
        SUBSTR(lcresto, 1, 6) +  ;
        lcmed + SUBSTR(lcresto, 7,  ;
        6) + lclat
RETURN lccod
ENDFUNC
**
*** 
*** ReFox - retrace your steps ... 
***
