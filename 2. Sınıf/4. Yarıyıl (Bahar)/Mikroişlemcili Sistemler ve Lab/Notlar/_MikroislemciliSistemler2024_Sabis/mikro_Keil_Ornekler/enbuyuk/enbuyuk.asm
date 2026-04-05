;20h ile 39h arasindaki verilerden 
;a. en büyügünü bulan 41h adresine 
;b. en büyügünün tekrarlama sayisini 42h adresine 
;c1. en büyügün adresini 43h adresine
;c2. bu en büyük elemanin bulundugu adresleri de 
;50h adresinden itibaren yeni bir diziye yazan program
org 0000h
	sjmp basla
org 0030h
basla:
	MOV 20H,#90H
	MOV 21H,#06H
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
	MOV 35H,#08H
	MOV 36H,#08H
	MOV 37H,#08H
	MOV 38H,#06H
	MOV 39H,#05H

	mov 41h,20h	;dizinin ilk elemani en buyuk kabul edildi
	mov 43h,#20h ;dizinin ilk elamanin adresi
	mov r0,#21h ;ikinci elemanin adresi
	mov r1,#51h ;en büyük elemanin adreslerinin dizisi
	mov 42h,#01h ;tekrar sayisini resetledim
	mov 50h,#20h ;dizinin ilk elemaninin adresi
tekrar:	
	mov a,@r0	  ;diziden okuma yap
	cjne a,41h,esitdegil
	;esitbolgesi
	inc 42h ;tekrar sayisini artir
	mov 43h, R0
	mov @r1,00h	 ;r0 yerine 00h direk adresi kullandým
	inc r1
	sjmp yenisayikucuk 
esitdegil:
	jc yenisayikucuk
	;yeni sayi buyuk bolgesi
	mov 41h,a	;veya	mov 41h,@r0
	mov 42h,#01h ;tekrar sayisi resetlendi
	mov 43h, R0 ;dizinin indisini yaz
	mov r1,#50h
	mov @r1,00h  ;r0 yerine 00h direk adresi kullandým
	;veya mov 50h,r0
	inc r1
yenisayikucuk:	  ;dongu kontrol
	inc r0									
	cjne r0,#40h,tekrar
	end



