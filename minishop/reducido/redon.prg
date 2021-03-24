*** 
*** ReFox X  #UK933629  MANRIQUE ORELLANA  MANSOFT SYSTEMS [VFP80]
***
tnpos = 0.8 
tnnro = 157.13 
? redondearmas(tnnro, tnpos)
ENDPROC
**
FUNCTION redondearmas
LPARAMETERS tnnro, tnos
RETURN CEILING(tnnro / 10 ^  ;
       tnpos) * 10 ^ tnpos
ENDFUNC
**
*** 
*** ReFox - retrace your steps ... 
***
