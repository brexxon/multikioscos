*** 
*** ReFox X  #UK933629  MANRIQUE ORELLANA  MANSOFT SYSTEMS [VFP80]
***
DO abrir
PUBLIC fechi
fechi = DATE()
SELECT clientes
GOTO TOP
LOCATE FOR clientes.codigo =  ;
       ncodcli
IF clientes.grupo = "ESPECIAL"
     WAIT WINDOW NOWAIT  ;
          "NO SE PUEDE GENERAR INTERES POR SER UN CLIENTE ESPECIAL"
ELSE
     SELECT cuentacn
     SET FILTER TO ncodcli = cuentacn.codcli;
.AND. ptotal > 0
     SELECT remitos
     SET FILTER TO ncodcli = remitos.cliente;
.AND. VAL(estado) = 0;
.AND. remitos.saldo > 0
     GOTO TOP
     DO WHILE  .NOT. EOF()
          DO CASE
               CASE (DATE() -  ;
                    remitos.fecha) <=  ;
                    60
                    REPLACE remitos.interes  ;
                            WITH  ;
                            0
                    = TABLEUPDATE(.T.)
               CASE (DATE() -  ;
                    remitos.fecha) >  ;
                    60 .AND.  ;
                    (DATE() -  ;
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
              remitos.interes >  ;
              0
               APPEND BLANK
               REPLACE descripcio  ;
                       WITH  ;
                       "INTERES POR MORA",  ;
                       ptotal  ;
                       WITH  ;
                       remitos.interes,  ;
                       fpago WITH  ;
                       DATE(),  ;
                       fecha WITH  ;
                       fechi,  ;
                       codcli  ;
                       WITH  ;
                       ncodcli,  ;
                       cuentacn.remito  ;
                       WITH  ;
                       remitos.numero
          ELSE
               REPLACE ptotal  ;
                       WITH  ;
                       remitos.interes,  ;
                       fpago WITH  ;
                       DATE(),  ;
                       fecha WITH  ;
                       fechi
          ENDIF
          = TABLEUPDATE(.T.)
          SELECT remitos
          SKIP
     ENDDO
     SUM remitos.saldo TO sumare 
     SUM remitos.interes TO  ;
         numasal 
     saldi = sumare + numasal
ENDIF
thisform.refresh
ENDPROC
**
*** 
*** ReFox - retrace your steps ... 
***
