*** 
*** ReFox X  #UK933629  MANRIQUE ORELLANA  MANSOFT SYSTEMS [VFP80]
***
PUBLIC adelante, atras, une
STORE "" TO adelante, atras, une
SELECT fiscal
LOCATE FOR '�' $ UPPER(detalle)
DO WHILE FOUND()
     LOCATE FOR '�' $  ;
            UPPER(detalle)
     atras = SUBSTR(detalle,  ;
             AT(UPPER("�"),  ;
             fiscal.detalle, 1) +  ;
             1)
     adelante = LEFT(detalle,  ;
                AT(UPPER("�"),  ;
                fiscal.detalle,  ;
                1) - 1)
     une = adelante + "�" + atras
     REPLACE fiscal.detalle WITH  ;
             une
     CONTINUE
ENDDO
SELECT fiscal
GOTO TOP
LOCATE FOR '�' $ UPPER(detalle)
DO WHILE FOUND()
     LOCATE FOR '�' $  ;
            UPPER(detalle)
     atras = SUBSTR(detalle,  ;
             AT("�",  ;
             fiscal.detalle, 1) +  ;
             1)
     adelante = LEFT(detalle,  ;
                AT("�",  ;
                fiscal.detalle,  ;
                1) - 1)
     une = adelante + "�" + atras
     REPLACE fiscal.detalle WITH  ;
             une
     CONTINUE
ENDDO
RETURN
ENDPROC
**
*** 
*** ReFox - retrace your steps ... 
***
