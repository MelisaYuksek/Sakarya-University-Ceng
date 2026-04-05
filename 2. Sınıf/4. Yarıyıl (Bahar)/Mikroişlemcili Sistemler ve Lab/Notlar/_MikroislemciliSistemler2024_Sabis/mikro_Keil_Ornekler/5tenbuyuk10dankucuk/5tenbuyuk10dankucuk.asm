;20h ile 39h arasindaki verilerden 
;05h dan büyük ve 10h'dan küçük olanlarin sayisini 40h a yazan,

org 0000h
	sjmp basla
org 0030h
basla:
	MOV 20H,#00H
	MOV 21H,#02H
	MOV 22H,#05H
	MOV 23H,#06H
	MOV 24H,#05H
	MOV 25H,#06H
	MOV 26H,#06H
	MOV 27H,#05H
	MOV 28H,#06H
	MOV 31H,#06H
	MOV 32H,#08H
	MOV 33H,#08H
	MOV 34H,#05H
	MOV 35H,#18H
	MOV 36H,#08H
	MOV 37H,#18H
	MOV 38H,#06H
	MOV 39H,#25H

	mov r0,#20h ;dizinin ilk indisi
	mov 40h,#00h ;sayaci sifirladim
tekrar:
	cjne @r0,#05h, beseesitdegil
	sjmp dongukontrol
beseesitdegil:
	jnc bestenbuyuk
	;5 ten kucuk bölgesi
	sjmp dongukontrol 
bestenbuyuk:   
	;sayinin 5 ile karsilastirmasi bitti 10h ile karsilastir
	cjne @r0,#10h,onaesitdegil
	sjmp dongukontrol
onaesitdegil:
	jnc dongukontrol
	; 05h<x<10h bölgesi
	inc 40h	  ;sarti saglayanlar icin sayaci 1 artir
dongukontrol:
	inc r0	
	cjne r0,#40h,tekrar
	end