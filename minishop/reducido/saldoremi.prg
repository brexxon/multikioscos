*** 
*** ReFox X  #UK933629  MANRIQUE ORELLANA  MANSOFT SYSTEMS [VFP80]
***
CLOSE DATABASES
PUBLIC minte, misal
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
SELECT clientes
SET FILTER TO clientes.grupo <> "ESPECIAL"
GOTO TOP
SET DELETED ON
WAIT WINDOW NOWAIT  ;
     "Por favor espere,actualizando saldos por remito..."
SET DELETED ON
SET ESCAPE OFF
DO WHILE  .NOT. EOF()
     SELECT remitos
     GOTO TOP
     SUM interes TO minte FOR  ;
         remitos.cliente =  ;
         clientes.codigo
     SUM saldo TO misal FOR  ;
         remitos.cliente =  ;
         clientes.codigo
     SELECT clientes
     REPLACE saldo WITH misal,  ;
             interes WITH minte
     = TABLEUPDATE(.T.)
     SKIP
ENDDO
WAIT WINDOW NOWAIT  ;
     "La actualización de saldos terminó"
ENDPROC
**
*** 
*** ReFox - retrace your steps ... 
***
