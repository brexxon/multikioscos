*** 
*** ReFox X  #UK933629  MANRIQUE ORELLANA  MANSOFT SYSTEMS [VFP80]
***
PUBLIC impcom, resufi, tifaes
impcom = 0
resufi = ""
tifaes = ""
DO inimp
ENDPROC
**
PROCEDURE INIMP
ON KEY
nn = 0
sx = 0
IF FILE("PFISOUT.TXT") = .T.
     DELETE FILE ("PFISOUT.TXT")
ENDIF
SELECT fiscal
COPY TO PFISIN.TXT TYPE SDF
RUN /N2 PFBATCH /C:1
CREATE CURSOR RES_FIS (detalle C  ;
       (254))
SELECT res_fis
APPEND FROM PFISOUT.txt TYPE SDF
SELECT res_fis
GOTO TOP
zznn = INT(VAL(SUBSTR(res_fis.detalle,  ;
       70, 5)))
SELECT res_fis
GOTO BOTTOM
nn = INT(VAL(SUBSTR(res_fis.detalle,  ;
     47, 8)))
sx = 2
resufi = SUBSTR(res_fis.detalle,  ;
         31, 5)
tifaes = SUBSTR(res_fis.detalle,  ;
         12, 11)
WAIT WINDOW tifaes
IF RECCOUNT() = 0
     WAIT WINDOW  ;
          "VERIFIQUE LA CONEXION DE LA IMPRESORA" +  ;
          CHR(13) +  ;
          "[Esc.] CANCELA - [Otra tecla] CONTINUA"
     IF LASTKEY() = 27
          impcom = 1
          KEYBOARD "{ESCAPE}"
          RETURN
     ELSE
          DO inimp
     ENDIF
ENDIF
IF UPPER(ALLTRIM(tifaes)) =  ;
   "FACTCIERRA" .OR.  ;
   UPPER(ALLTRIM(tifaes)) =  ;
   "TIQUECIERRA"
     IF RECCOUNT() = 0
          WAIT WINDOW  ;
               "VERIFIQUE LA CONEXION DE LA IMPRESORA" +  ;
               CHR(13) +  ;
               "[Esc.] CANCELA - [Otra tecla] CONTINUA"
          IF LASTKEY() = 27
               impcom = 1
               KEYBOARD "{ESCAPE}"
               RETURN
          ELSE
               DO inimp
          ENDIF
     ENDIF
     DO tierror
ELSE
     IF LASTKEY() <> 27
          IF tipoeje = 1
               impcom = 0
               errorimp = 0
          ELSE
               IF tipoeje = 2
                    impcom = 0
                    errorimp = 1
               ELSE
                    impcom = 1
                    errorimp = 1
               ENDIF
          ENDIF
     ELSE
          impcom = 1
          errorimp = 1
     ENDIF
     RETURN
ENDIF
RETURN
ENDPROC
**
PROCEDURE TIERROR
PUBLIC lierror, err_imp, err_fis,  ;
       errimp, errocodi, errfis,  ;
       estimp, estfis, estafis
STORE "" TO lierror, err_imp,  ;
      err_fis, estimp, estfis
errorimp = 0
errimp = 0
errfis = 0
estafis = 0
errocodi = 0
errozeta = 0
SELECT res_fis
GOTO TOP
LOCATE FOR 'ESTADO' $  ;
       UPPER(detalle)
estimp = SUBSTR(res_fis.detalle,  ;
         37, 4)
estfis = SUBSTR(res_fis.detalle,  ;
         42, 4)
IF estfis = "0A00"
     errfis = 1
     estafis = 1
     WAIT WINDOW  ;
          "DEBE REALIZAR UN CIERRE (Z)" +  ;
          CHR(13) +  ;
          "PRESIONE UNA TECLA PARA CONTINUAR"
     errozeta = 1
     impcom = 1
     errorimp = 1
     KEYBOARD "{ESCAPE}"
ELSE
     IF estfis <> "0600"
          errfis = 1
          estafis = 1
          WAIT WINDOW  ;
               " ERROR EN ESTADO FISCAL EL PROCEDIMIENTO SE CANCELA" +  ;
               CHR(13) +  ;
               "PRESIONE UNA TECLA PARA CONTINUAR"
          errorimp = 1
          RETURN
     ELSE
          errimp = 0
          SELECT res_fis
          LOCATE FOR 'ERROR' $  ;
                 UPPER(detalle)
          IF FOUND() = .T.
               lierror = SUBSTR(res_fis.detalle,  ;
                         AT(UPPER("ERROR"),  ;
                         res_fis.detalle,  ;
                         1))
               err_imp = SUBSTR(lierror,  ;
                         7, 4)
               err_fis = SUBSTR(lierror,  ;
                         12, 4)
               errimp = 0
               IF err_imp <>  ;
                  "0080"
                    errocodi = 0
                    errimp = 1
                    errorimp = 0
                    IF err_imp =  ;
                       "80B0"
                         errocodi =  ;
                          1
                         WAIT WINDOW  ;
                              "AGREGE PAPEL Y PRESIONE UNA TECLA PARA CONTINUAR" +  ;
                              CHR(13) +  ;
                              "PRESIONE [ESC] CANCELA - [OTRA TECLA] CONTINUA"
                         IF LASTKEY() =  ;
                            27
                              impcom =  ;
                               1
                              errorimp =  ;
                               1
                              RETURN
                         ELSE
                              DO inimp
                         ENDIF
                    ENDIF
                    IF err_imp =  ;
                       "0000"
                         errocodi =  ;
                          1
                         WAIT WINDOW  ;
                              "IMPRESORA FUERA DE LINEA, VERIFIQUE " +  ;
                              CHR(13) +  ;
                              "SI ESTA ENCENDIDA, CONEXIONES, CIERRE DE LA TAPA, Y" +  ;
                              CHR(13) +  ;
                              "PRESIONE [ESC] CANCELA - [OTRA TECLA] CONTINUA"
                         IF LASTKEY() =  ;
                            27
                              impcom =  ;
                               1
                              errorimp =  ;
                               1
                              RETURN
                         ELSE
                              DO inimp
                         ENDIF
                    ENDIF
               ELSE
                    IF err_fis <>  ;
                       "0600"
                         WAIT WINDOW  ;
                              "ERROR EN ESTADO FISCAL EL PROCEDIMIENTO SE CANCELA" +  ;
                              CHR(13) +  ;
                              "PRESIONE UNA TECLA PARA CONTINUAR"
                         errorimp =  ;
                          1
                         KEYBOARD  ;
                          "{ESCAPE}"
                         RETURN
                    ENDIF
               ENDIF
          ENDIF
     ENDIF
ENDIF
RETURN
RETURN
ENDPROC
**
*** 
*** ReFox - retrace your steps ... 
***
