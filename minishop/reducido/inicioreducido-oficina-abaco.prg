*** 
*** ReFox X  #UK933629  MANRIQUE ORELLANA  MANSOFT SYSTEMS [VFP80]
***
SET MULTILOCKS ON
SET SYSMENU TO
DO hdnserie
PUBLIC va, ca, vnoaa, toro, kant
kant = 0
toro = 0
vnoaa = ""
va = " "
ca = " "
PUBLIC venti, diez, siva, noe,  ;
       vatipo, frm
PUBLIC hoy, hoyh, elca, elsal, nu,  ;
       ret, toin, toeg, ecaja, v
PUBLIC unc, cincoc, diezc,  ;
       veinticincoc, cincuentac,  ;
       unp, dosp, cincop, diezp,  ;
       veintep, cincuentap, cienp,  ;
       efete
PUBLIC primera, segunda, ncan,  ;
       imp
primera = ""
segunda = ""
ncan = 0
imp = 0
v = ""
frm = ""
PUBLIC tc, td, ch, vl, tic, toar,  ;
       ladife
toar = 0
ladife = 0
tc = 0
td = 0
ch = 0
vl = 0
tic = 0
efete = 000000.00 
unc = 0
cincoc = 0
diezc = 0
veinticincoc = 0
cincuentac = 0
unp = 0
dosp = 0
cincop = 0
diezp = 0
veintep = 0
cincuentap = 0
cienp = 0
vatipo = ""
noe = .F.
siva = 0
venti = 0
diez = 0
PUBLIC ultimo, esdemo
esdemo = .F.
PUBLIC demow, clabase, vautoriza,  ;
       capitan, negativo
capitan = ""
vautoriza = .F.
demow = ""
PUBLIC conte
conte = 0
clabase = "datos"
SET DEFAULT TO SYS(2003)
DO abrir
USE SHARED CONFIG
PUBLIC tentacion
tentacion = ALLTRIM(config.local)
negativo = ALLTRIM(config.fax)
DO noabre2vc
MODIFY WINDOW screen TITLE  ;
       'SISTEMA GESTION COMERCIAL' +  ;
       " " + tentacion
SELECT config
USE
IF  .NOT. FILE("fprun.dll")
     MESSAGEBOX( ;
               "ERROR,COMUNIQUESE,03717-15604793/3717-15311786,br_exxon@hotmail.com",  ;
               16, "ATENCION")
     CLEAR EVENTS
     QUIT
ENDIF
SET STATUS BAR OFF
SET CONSOLE OFF
USE fprun.Dll
PUBLIC maquina
maquina = SUBSTR(SYS(0), 1, 10)
SELECT fprun
GOTO TOP
LOCATE FOR ALLTRIM(fprun.nombre) =  ;
       maquina
IF FOUND()
     IF lpvolnumber <> fprun.dia
          lacu = 21 - fprun.campo
          DO FORM registro
          esdemo = .T.
          IF campo >= 21
               MESSAGEBOX( ;
                         "ERROR,COMUNIQUESE,370-4604793/370-5479477,br_exxon@hotmail.com",  ;
                         16,  ;
                         "ATENCION")
               DO FORM registro
               CLEAR EVENTS
               QUIT
          ELSE
               LOCAL trae
               trae = 0
               trae = fprun.campo
               REPLACE fprun.campo  ;
                       WITH trae +  ;
                       1
          ENDIF
     ENDIF
ELSE
     SELECT fprun
     APPEND BLANK
     REPLACE fprun.nombre WITH  ;
             maquina
     IF lpvolnumber <> fprun.dia
          lacu = 21 - fprun.campo
          DO FORM registro
          esdemo = .T.
          IF campo >= 21
               MESSAGEBOX( ;
                         "ERROR,COMUNIQUESE,370-4604793/370-5479477,br_exxon@hotmail.com,",  ;
                         16,  ;
                         "ATENCION")
               CLEAR EVENTS
               QUIT
          ELSE
               LOCAL trae
               trae = 0
               trae = fprun.campo
               REPLACE fprun.campo  ;
                       WITH trae +  ;
                       1
          ENDIF
     ENDIF
ENDIF
SET DATE TO Dmy
SET ENGINEBEHAVIOR 70
PUBLIC variable, pctexto, redir
redir = ""
pctexto = ""
variable = 0
PUBLIC lugar
PUBLIC acceso, desdeh, hastah
desdeh = 0
hastah = 0
acceso = .T.
SET PROCEDURE TO procs
SET RESOURCE OFF
SET COLLATE TO 'SPANISH'
SET STATUS BAR ON
SET CENTURY ON
SET CURSOR ON
SET SCOREBOARD OFF
SET BELL OFF
SET SAFETY OFF
SET CONFIRM OFF
SET DELETED ON
SET ESCAPE OFF
SET TALK OFF
SET CLOCK OFF
SET DATE TO Dmy
SET TYPEAHEAD TO 1
SET HOURS TO 24
SET MESSAGE TO 24 CENTER
RELEASE WINDOW 'estándar'
SET EXCLUSIVE OFF
SET MULTILOCKS ON
SET READBORDER OFF
SET SYSMENU TO
SET STATUS BAR ON
PUBLIC archi, cualera, yata, c
c = ""
yata = 0
cualera = ""
archi = 0
ON KEY LABEL CTRL+Enter ARCHI=1
ON KEY LABEL F12 ARCHI=0
_SCREEN.windowstate = 2
_SCREEN.closable = .F.
ON ERROR DO MESAERRO WITH  ERROR(), PROGRAM(),;
LINENO(), MESSAGE()
ON SHUTDOWN DO SALIDA
IF _login(1)
     IF SUBSTR(SYS(0), 1, 9) =  ;
        "mostrador"
          DO FORM venta22
     ELSE
          DO FORM venta2r
     ENDIF
     READ EVENTS
ELSE
     CLOSE ALL
     CLEAR EVENTS
     SET SYSMENU TO DEFAULT
ENDIF
IF SUBSTR(SYS(0), 1, 9) <>  ;
   "mostrador"
     IF USED("pedidos")
          SELECT pedidos
          CURSORSETPROP("Buffering",  ;
                       5,  ;
                       "pedidos")
     ELSE
          SELECT 0
          USE 'pedidos'
          CURSORSETPROP("Buffering",  ;
                       5,  ;
                       "pedidos")
     ENDIF
     GOTO TOP
     DELETE ALL FOR  ;
            EMPTY(detalle)
     = TABLEUPDATE(.T.)
     SET DELETED ON
ENDIF
CLOSE DATABASES ALL
ENDPROC
**
PROCEDURE SALIDA
IF 6 = MESSAGEBOX("¿Desea salir?",  ;
   036, "Salir")
     CLOSE DATABASES
     ON SHUTDOWN
     CLEAR EVENTS
     CLOSE ALL
     QUIT
ENDIF
RETURN
ENDPROC
**
*** 
*** ReFox - retrace your steps ... 
***
