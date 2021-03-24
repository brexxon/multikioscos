*** 
*** ReFox X  #UK933629  MANRIQUE ORELLANA  MANSOFT SYSTEMS [VFP80]
***
DO abrir
IF USED("clientes")
     SELECT clientes
     CURSORSETPROP("Buffering", 5,  ;
                  "clientes")
ELSE
     SELECT 0
     USE 'clientes'
     CURSORSETPROP("Buffering", 5,  ;
                  "clientes")
ENDIF
IF USED("cUENTACN")
     SELECT cuentacn
     CURSORSETPROP("Buffering", 5,  ;
                  "cUENTACN")
ELSE
     SELECT 0
     USE 'cUENTACN'
     CURSORSETPROP("Buffering", 5,  ;
                  "cUENTACN")
ENDIF
IF USED("REMITOS")
     SELECT remitos
     CURSORSETPROP("Buffering", 5,  ;
                  "REMITOS")
ELSE
     SELECT 0
     USE 'REMITOS'
     CURSORSETPROP("Buffering", 5,  ;
                  "REMITOS")
ENDIF
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
PUBLIC fechi
fechi = DATE()
SELECT clientes
GOTO TOP
SELECT cuentacn
SET FILTER TO clientes.codigo = cuentacn.codcli;
.AND. ptotal > 0
SELECT remitos
SET FILTER TO clientes.codigo = remitos.cliente;
.AND. VAL(estado) = 0;
.AND. remitos.saldo > 0
GOTO TOP
SELECT clientes
DO WHILE  .NOT. EOF()
     DO CASE
          CASE (DATE() -  ;
               remitos.fecha) <=  ;
               60
               REPLACE remitos.interes  ;
                       WITH 0
               = TABLEUPDATE(.T.)
          CASE (DATE() -  ;
               remitos.fecha) >  ;
               60 .AND. (DATE() -  ;
               remitos.fecha) <=  ;
               120
               REPLACE remitos.interes  ;
                       WITH  ;
                       remitos.saldo *  ;
                       (((DATE() -  ;
                       remitos.fecha) *  ;
                       inte.diario) /  ;
                       100)
               = TABLEUPDATE(.T.)
          CASE (DATE() -  ;
               remitos.fecha) >  ;
               120
               REPLACE remitos.interes  ;
                       WITH  ;
                       remitos.saldo *  ;
                       (((DATE() -  ;
                       remitos.fecha) *  ;
                       inte.diario) /  ;
                       100)
               = TABLEUPDATE(.T.)
     ENDCASE
     fechi = remitos.fecha
     SELECT cuentacn
     LOCATE FOR descripcio =  ;
            "INTERES POR MORA"  ;
            .AND.  ;
            VAL(remitos.numero) =  ;
            VAL(cuentacn.remito)
     IF  .NOT. FOUND() .AND.  ;
         remitos.interes > 0
          APPEND BLANK
          REPLACE descripcio WITH  ;
                  "INTERES POR MORA",  ;
                  ptotal WITH  ;
                  remitos.interes,  ;
                  fpago WITH  ;
                  DATE(), fecha  ;
                  WITH fechi,  ;
                  codcli WITH  ;
                  clientes.codigo,  ;
                  cuentacn.remito  ;
                  WITH  ;
                  remitos.numero
     ELSE
          REPLACE ptotal WITH  ;
                  remitos.interes,  ;
                  fpago WITH  ;
                  DATE(), fecha  ;
                  WITH fechi
     ENDIF
     SELECT clientes
     SKIP
ENDDO
SELECT cuentacn
= TABLEUPDATE(.T.)
ENDPROC
**
*** 
*** ReFox - retrace your steps ... 
***
