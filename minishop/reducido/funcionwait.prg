*** 
*** ReFox X  #UK933629  MANRIQUE ORELLANA  MANSOFT SYSTEMS [VFP80]
***
LPARAMETERS pctexto, pntimeout
IF  .NOT. _SCREEN.visible
     _SCREEN.visible = .T.
ENDIF
LOCAL lnyy, lnxx
pctexto = "Por favor espere...Procesando archivos"
pctexto = CHRTRAN("|" + pctexto +  ;
          "|", "|", CHR(13))
lnxx = 1
FOR lnyy = 1 TO MEMLINES(pctexto)
     lnxx = MAX(lnxx,  ;
            LEN(ALLTRIM(MLINE(pctexto,  ;
            lnxx))))
ENDFOR
lnyy = (SROWS() / 2) - (lnyy / 2)
lnxx = (SCOLS() / 2) - (lnxx / 2)
CLEAR TYPEAHEAD
WAIT CLEAR
IF TYPE("pnTimeOut") <> "N"
     WAIT WINDOW AT lnyy, lnxx -  ;
          5 NOWAIT pctexto
ELSE
     WAIT WINDOW AT lnyy, lnxx -  ;
          5 TIMEOUT pntimeout  ;
          pctexto
ENDIF
RETURN
ENDPROC
**
*** 
*** ReFox - retrace your steps ... 
***
