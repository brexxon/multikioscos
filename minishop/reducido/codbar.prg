*------------------------------------------------------
* PROG. : CodBar.prg
* FECHA : 2000/04/25
* U.ACT : 2002/08/10
* AUTOR : Luis Mar�a Guay�n
*------------------------------------------------------
* Estas funciones convierten una cadena de caracteres
* a los siguientes formatos de C�digos de Barras:
*   Codigo 39 : _StrTo39()
*   Codigo 128-A : _StrTo128A()
*   Codigo 128-B : _StrTo128B()
*   Codigo 128-C : _StrTo128C()
*   Codigo EAN-13 : _StrToEan13()
*   Codigo EAN-8 : _StrToEan8()
*   Interleaved 2 of 5 : _StrToI2of5()
*
* Las fuentes True Type utilizadas son:
*   Codigo 39 : "PF Barcode 39"
*   Codigo 128-A : "PF Barcode 128"
*   Codigo 128-B : "PF Barcode 128"
*   Codigo 128-C : "PF Barcode 128"
*   Codigo EAN-13 : "PF EAN P36" � "PF EAN P72"
*   Codigo EAN-8 : "PF EAN P36" � "PF EAN P72"
*   Interleaved 2 of 5 : "PF Interleaved 2 of 5" � "PF Interleaved 2 of 5 Wide"
*
*------------------------------------------------------
* FUNCTION _StrTo39(tcString) * CODIGO 39
*------------------------------------------------------
* Convierte un string para ser impreso con
* fuente True Type "PF Barcode 39"
* USO: _StrTo39('Codigo 39')
* RETORNA: Caracter
*------------------------------------------------------
FUNCTION _StrTo39(tcString)
  LOCAL lcRet
  lcRet = '*' + tcString + '*'
  RETURN lcRet
ENDFUNC

*------------------------------------------------------
* FUNCTION _StrTo128A(tcString) * CODIGO 128A
*------------------------------------------------------
* Convierte un string para ser impreso con
* fuente True Type "PF Barcode 128"
* Caracteres num�ricos y alfabeticos (solo may�sculas)
* Si un caracter es no v�lido lo remplaza por espacio
* USO: _StrTo128A('CODIGO 128 A')
* RETORNA: Caracter
*------------------------------------------------------
FUNCTION _StrTo128A(tcString)
  LOCAL lcStart, lcStop, lcRet, lcCheck, ;
    lnLong, lnI, lnCheckSum, lnAsc
  lcStart = CHR(103 + 32)
  lcStop = CHR(106 + 32)
  lnCheckSum = ASC(lcStart) - 32
  lcRet = tcString
  lnLong = LEN(lcRet)
  FOR lnI = 1 TO lnLong
    lnAsc = ASC(SUBS(lcRet,lnI,1)) - 32
    IF NOT BETWEEN(lnAsc,0,64)
      lcRet = STUFF(lcRet,lnI,1,CHR(32))
      lnAsc = ASC(SUBS(lcRet,lnI,1)) - 32
    ENDIF
    lnCheckSum = lnCheckSum + (lnAsc * lnI)
  ENDFOR
  lcCheck = CHR(MOD(lnCheckSum,103) + 32)
  lcRet = lcStart + lcRet + lcCheck + lcStop
  *--- Esto es para cambiar los espacios y caracteres invalidos
  lcRet = STRTRAN(lcRet,CHR(32),CHR(232))
  lcRet = STRTRAN(lcRet,CHR(127),CHR(192))
  lcRet = STRTRAN(lcRet,CHR(128),CHR(193))
  RETURN lcRet
ENDFUNC

*------------------------------------------------------
* FUNCTION _StrTo128B(tcString) * CODIGO 128B
*------------------------------------------------------
* Convierte un string para ser impreso con
* fuente True Type "PF Barcode 128"
* Caracteres num�ricos y alfabeticos (may�sculas y min�sculas)
* Si un caracter es no v�lido lo remplaza por espacio
* USO: _StrTo128B('Codigo 128 B')
* RETORNA: Caracter
*------------------------------------------------------
FUNCTION _StrTo128B(tcString)
  LOCAL lcStart, lcStop, lcRet, lcCheck, ;
    lnLong, lnI, lnCheckSum, lnAsc
  lcStart = CHR(104 + 32)
  lcStop = CHR(106 + 32)
  lnCheckSum = ASC(lcStart) - 32
  lcRet = tcString
  lnLong = LEN(lcRet)
  FOR lnI = 1 TO lnLong
    lnAsc = ASC(SUBS(lcRet,lnI,1)) - 32
    IF NOT BETWEEN(lnAsc,0,99)
      lcRet = STUFF(lcRet,lnI,1,CHR(32))
      lnAsc = ASC(SUBS(lcRet,lnI,1)) - 32
    ENDIF
    lnCheckSum = lnCheckSum + (lnAsc * lnI)
  ENDFOR
  lcCheck = CHR(MOD(lnCheckSum,103) + 32)
  lcRet = lcStart + lcRet + lcCheck + lcStop
  *--- Esto es para cambiar los espacios y caracteres invalidos
  lcRet = STRTRAN(lcRet,CHR(32),CHR(232))
  lcRet = STRTRAN(lcRet,CHR(127),CHR(192))
  lcRet = STRTRAN(lcRet,CHR(128),CHR(193))
  RETURN lcRet
ENDFUNC

*------------------------------------------------------
* FUNCTION _StrTo128C(tcString) * CODIGO 128C
*------------------------------------------------------
* Convierte un string para ser impreso con
* fuente True Type "PF Barcode 128"
* Solo caracteres num�ricos
* USO: _StrTo128C('1234567890')
* RETORNA: Caracter
*------------------------------------------------------
FUNCTION _StrTo128C(tcString)
  LOCAL lcStart, lcStop, lcRet, lcCheck, lcCar, ;
    lnLong, lnI, lnCheckSum, lnAsc
  lcStart = CHR(105 + 32)
  lcStop = CHR(106 + 32)
  lnCheckSum = ASC(lcStart) - 32
  lcRet = ALLTRIM(tcString)
  lnLong = LEN(lcRet)
  *--- La longitud debe ser par
  IF MOD(lnLong,2) # 0
    lcRet = '0' + lcRet
    lnLong = LEN(lcRet)
  ENDIF
  *--- Convierto los pares a caracteres
  lcCar = ''
  FOR lnI = 1 TO lnLong STEP 2
    lcCar = lcCar + CHR(VAL(SUBS(lcRet,lnI,2)) + 32)
  ENDFOR
  lcRet = lcCar
  lnLong = LEN(lcRet)
  FOR lnI = 1 TO lnLong
    lnAsc = ASC(SUBS(lcRet,lnI,1)) - 32
    lnCheckSum = lnCheckSum + (lnAsc * lnI)
  ENDFOR
  lcCheck = CHR(MOD(lnCheckSum,103) + 32)
  lcRet = lcStart + lcRet + lcCheck + lcStop
  *--- Esto es para cambiar los espacios y caracteres invalidos
  lcRet = STRTRAN(lcRet,CHR(32),CHR(232))
  lcRet = STRTRAN(lcRet,CHR(127),CHR(192))
  lcRet = STRTRAN(lcRet,CHR(128),CHR(193))
  RETURN lcRet
ENDFUNC

*------------------------------------------------------
* FUNCTION _StrToEan13(tcString,.T.) * CODIGO EAN-13
*------------------------------------------------------
* Convierte un string para ser impreso con
* fuente True Type "PF EAN P36" � "PF EAN P72"
* PARAMETROS:
*   tcString: Caracter de 12 d�gitos (0..9)
*   tlCheckD: .T. Solo genera el d�gito de control
*             .F. Genera d�gito y caracteres a imprimir
* USO: _StrToEan13('123456789012')
* RETORNA: Caracter
*------------------------------------------------------
FUNCTION _StrToEan13(tcString,tlCheckD)
  LOCAL lcLat, lcMed, lcRet, lcJuego, ;
    lcIni, lcResto, lcCod, lnI, ;
    lnCheckSum, lnAux, laJuego(10), lnPri
  lcRet = ALLTRIM(tcString)
  IF LEN(lcRet) # 12
    *--- Error en par�metro
    *--- debe tener un largo = 12
    RETURN ''
  ENDIF
  *--- Genero d�gito de control
  lnCheckSum = 0
  FOR lnI = 1 TO 12
    IF MOD(lnI,2) = 0
      lnCheckSum = lnCheckSum + VAL(SUBS(lcRet,lnI,1)) * 3
    ELSE
      lnCheckSum = lnCheckSum + VAL(SUBS(lcRet,lnI,1)) * 1
    ENDIF
  ENDFOR
  lnAux = MOD(lnCheckSum,10)
  lcRet = lcRet + ALLTRIM(STR(IIF(lnAux = 0,0,10-lnAux)))
  IF tlCheckD
    *--- Si solo genero d�gito de control
    RETURN lcRet
  ENDIF
  *--- Para imprimir con fuente True Type PF_EAN_PXX
  *--- 1er. d�gito (lnPri)
  lnPri = VAL(LEFT(lcRet,1))
  *--- Tabla de Juegos de Caracteres
  *--- seg�n 'lnPri' (�NO CAMBIAR!)
  laJuego(1) = 'AAAAAACCCCCC'   && 0
  laJuego(2) = 'AABABBCCCCCC'   && 1
  laJuego(3) = 'AABBABCCCCCC'   && 2
  laJuego(4) = 'AABBBACCCCCC'   && 3
  laJuego(5) = 'ABAABBCCCCCC'   && 4
  laJuego(6) = 'ABBAABCCCCCC'   && 5
  laJuego(7) = 'ABBBAACCCCCC'   && 6
  laJuego(8) = 'ABABABCCCCCC'   && 7
  laJuego(9) = 'ABABBACCCCCC'   && 8
  laJuego(10) = 'ABBABACCCCCC'   && 9
  *--- Caracter inicial (fuera del c�digo)
  lcIni = CHR(lnPri + 35)
  *--- Caracteres lateral y central
  lcLat = CHR(33)
  lcMed = CHR(45)
  *--- Resto de los caracteres
  lcResto = SUBS(lcRet,2,12)
  FOR lnI = 1 TO 12
    lcJuego = SUBS(laJuego(lnPri + 1),lnI,1)
    DO CASE
      CASE lcJuego = 'A'
        lcResto = STUFF(lcResto,lnI,1,CHR(VAL(SUBS(lcResto,lnI,1)) + 48))
      CASE lcJuego = 'B'
        lcResto = STUFF(lcResto,lnI,1,CHR(VAL(SUBS(lcResto,lnI,1)) + 65))
      CASE lcJuego = 'C'
        lcResto = STUFF(lcResto,lnI,1,CHR(VAL(SUBS(lcResto,lnI,1)) + 97))
    ENDCASE
  ENDFOR
  *--- Armo c�digo
  lcCod = lcIni + lcLat + SUBS(lcResto,1,6) + lcMed + ;
    SUBS(lcResto,7,6) + lcLat
  RETURN lcCod
ENDFUNC

*------------------------------------------------------
* FUNCTION _StrToEan8(tcString,.T.) * CODIGO EAN-8
*------------------------------------------------------
* Convierte un string para ser impreso con
* fuente True Type "PF EAN P36" � "PF EAN P72"
* PARAMETROS:
*   tcString: Caracter de 7 d�gitos (0..9)
*   tlCheckD: .T. Solo genera el d�gito de control
*             .F. Genera d�gito y caracteres a imprimir
* USO: _StrToEan8('1234567')
* RETORNA: Caracter
*------------------------------------------------------
FUNCTION _StrToEan8(tcString,tlCheckD)
  LOCAL lcLat, lcMed, lcRet, ;
    lcIni, lcCod, lnI, ;
    lnCheckSum, lnAux
  lcRet = ALLTRIM(tcString)
  IF LEN(lcRet) # 7
    *--- Error en par�metro
    *--- debe tener un largo = 7
    RETURN ''
  ENDIF
  *--- Genero d�gito de control
  lnCheckSum = 0
  FOR lnI = 1 TO 7
    IF MOD(lnI,2) = 0
      lnCheckSum = lnCheckSum + VAL(SUBS(lcRet,lnI,1)) * 3
    ELSE
      lnCheckSum = lnCheckSum + VAL(SUBS(lcRet,lnI,1)) * 1
    ENDIF
  ENDFOR
  lnAux = MOD(lnCheckSum,10)
  lcRet = lcRet + ALLTRIM(STR(IIF(lnAux = 0,0,10-lnAux)))
  IF tlCheckD
    *--- Si solo genero d�gito de control
    RETURN lcRet
  ENDIF
  *--- Para imprimir con fuente True Type PF_EAN_PXX
  *--- Caracteres lateral y central
  lcLat = CHR(33)
  lcMed = CHR(45)
  *--- Caracteres
  FOR lnI = 1 TO 8
    IF lnI <= 4
      lcRet = STUFF(lcRet,lnI,1,CHR(VAL(SUBS(lcRet,lnI,1)) + 48))
    ELSE
      lcRet = STUFF(lcRet,lnI,1,CHR(VAL(SUBS(lcRet,lnI,1)) + 97))
    ENDIF
  ENDFOR
  *--- Armo c�digo
  lcCod = lcLat + SUBS(lcRet,1,4) + lcMed + SUBS(lcRet,5,4) + lcLat
  RETURN lcCod
ENDFUNC

*------------------------------------------------------
* FUNCTION _StrToI2of5(tcString) * INTERLEAVED 2 OF 5
*------------------------------------------------------
* Convierte un string para ser impreso con
* fuente True Type "PF Interleaved 2 of 5" � "PF Interleaved 2 of 5 Wide"
* Solo caracteres num�ricos
* USO: _StrToI2of5('1234567890')
* RETORNA: Caracter
*------------------------------------------------------
FUNCTION _StrToI2of5(tcString)
  LOCAL lcStart, lcStop, lcRet, lcCheck, ;
    lcCar, lnLong, lnI, lnSum, lnAux
  lcStart = CHR(40)
  lcStop = CHR(41)
  lcRet = ALLTRIM(tcString)
  *--- Genero d�gito de control
  lnLong = LEN(lcRet)
  lnSum = 0
  lnCount = 1
  FOR lnI = lnLong TO 1 STEP -1
    lnSum = lnSum + VAL(SUBSTR(lcRet,lnI,1)) * ;
      IIF(MOD(lnCount,2) = 0,1,3)
    lnCount = lnCount + 1
  ENDFOR
  lnAux = MOD(lnSum,10)
  lcRet = lcRet + ALLTRIM(STR(IIF(lnAux = 0,0,10 - lnAux)))
  lnLong = LEN(lcRet)
  *--- La longitud debe ser par
  IF MOD(lnLong,2) # 0
    lcRet = '0' + lcRet
    lnLong = LEN(lcRet)
  ENDIF
  *--- Convierto los pares a caracteres
  lcCar = ''
  FOR lnI = 1 TO lnLong STEP 2
    IF VAL(SUBS(lcRet,lnI,2)) < 50
      lcCar = lcCar + CHR(VAL(SUBS(lcRet,lnI,2)) + 48)
    ELSE
      lcCar = lcCar + CHR(VAL(SUBS(lcRet,lnI,2)) + 142)
    ENDIF
  ENDFOR
  *--- Armo c�digo
  lcRet = lcStart + lcCar + lcStop
  RETURN lcRet
ENDFUNC

*------------------------------------------------------
* FIN CodBar.prg
*------------------------------------------------------
