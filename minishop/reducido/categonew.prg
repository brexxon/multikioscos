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
SET DELETED ON
WAIT WINDOW AT 20, 20 NOWAIT  ;
     "Por favor espere,Categorizando clientes..."
SET DELETED ON
SET ESCAPE OFF
PUBLIC intev, res
PUBLIC doi
PUBLIC sedebe, sehaber
sedebe = 0
sehaber = 0
SELECT clientes
GOTO TOP
SELECT cuentacn
GOTO TOP
SELECT clientes
DO WHILE  .NOT. EOF()
     SELECT cuentacn
     PUBLIC vf
     SET FILTER TO cuentacn.codcli = clientes.codigo
     GOTO TOP
     vf = cuentacn.fecha
     SUM cuentacn.ptotal TO  ;
         sedebe 
     SUM cuentacn.haber TO  ;
         sehaber 
     SELECT clientes
     REPLACE clientes.saldo WITH  ;
             sedebe - sehaber
     doi = clientes.codigo
     = TABLEUPDATE(.T.)
     SELECT cuentacn.codigo,  ;
            SUM(cuentacn.haber)  ;
            AS haber,  ;
            cuentacn.fpago AS ult,  ;
            nro_fact FROM  ;
            CUENTACN WHERE doi =  ;
            cuentacn.codcli AND  ;
            cuentacn.haber > 0  ;
            GROUP BY ult ORDER BY  ;
            ult INTO CURSOR tmp
     SELECT tmp
     GOTO BOTTOM
     PUBLIC ttr
     ttr = tmp.haber
     SELECT clientes
     REPLACE clientes.importeup  ;
             WITH tmp.haber
     IF ttr > 0
          REPLACE clientes.ultimopago  ;
                  WITH tmp.ult
     ELSE
          REPLACE clientes.ultimopago  ;
                  WITH vf
     ENDIF
     WAIT WINDOW AT 20, 20 NOWAIT  ;
          "CLIENTE:" +  ;
          clientes.nombre
     SELECT clientes
     DO CASE
          CASE (DATE() -  ;
               clientes.ultimopago) <=  ;
               60 .AND. saldo >  ;
               0
               IF ALLTRIM(clientes.grupo) <>  ;
                  "ESPECIAL"
                    REPLACE clientes.tipcli  ;
                            WITH  ;
                            "BUENO"
               ENDIF
          CASE (DATE() -  ;
               clientes.ultimopago) >  ;
               60 .AND. (DATE() -  ;
               clientes.ultimopago) <=  ;
               120 .AND. saldo >  ;
               0
               IF ALLTRIM(clientes.grupo) <>  ;
                  "ESPECIAL"
                    REPLACE clientes.tipcli  ;
                            WITH  ;
                            "REGUL"
                    SELECT clientes
                    = TABLEUPDATE(.T.)
               ENDIF
               res = 0
          CASE (DATE() -  ;
               clientes.ultimopago) >  ;
               120 .AND. saldo >  ;
               0
               IF ALLTRIM(clientes.grupo) <>  ;
                  "ESPECIAL"
                    REPLACE clientes.tipcli  ;
                            WITH  ;
                            "MALO"
               ENDIF
               = TABLEUPDATE(.T.)
     ENDCASE
     SELECT clientes
     = TABLEUPDATE(.T.)
     SET FILTER TO
     SKIP
ENDDO
SELECT clientes
SCAN FOR ALLTRIM(clientes.grupo) =  ;
     "ESPECIAL"
     REPLACE clientes.tipcli WITH  ;
             "BUENO"
ENDSCAN
SCAN
     DO CASE
          CASE ALLTRIM(clientes.tipcli) =  ;
               "BUENO"
               REPLACE estado  ;
                       WITH  ;
                       "HABILITADO"
          CASE ALLTRIM(clientes.tipcli) =  ;
               "REGUL"
               REPLACE estado  ;
                       WITH  ;
                       "CONSULTAR"
          CASE ALLTRIM(clientes.tipcli) =  ;
               "MALO"
               REPLACE estado  ;
                       WITH  ;
                       "DESABILITADO"
          CASE ALLTRIM(clientes.grupo) =  ;
               "ESPECIAL"
               REPLACE estado  ;
                       WITH  ;
                       "HABILITADO"
     ENDCASE
ENDSCAN
= TABLEUPDATE(.T.)
WAIT WINDOW AT 20, 20 NOWAIT  ;
     "La categorización de clientes ha terminado..."
CLOSE DATABASES
DO saldoremi
ENDPROC
**
*** 
*** ReFox - retrace your steps ... 
***
