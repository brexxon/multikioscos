*SET DEFAULT TO d:\rafa
*SET PATH TO "C:\Program Files\WinRAR" additive
SET PATH TO "WinRAR" additive
# define SW_SHOW_HIDDEN 0
gcComando = "winrar a -ep1 -m5  c:\multikioscos\copia\"+"multibackup"+SUBSTR(TIME(),7,2) + "   c:\multikioscos\*"

oShell =CreateObject("WScript.Shell")
oShell.Run(gcComando, SW_SHOW_HIDDEN, .T.)