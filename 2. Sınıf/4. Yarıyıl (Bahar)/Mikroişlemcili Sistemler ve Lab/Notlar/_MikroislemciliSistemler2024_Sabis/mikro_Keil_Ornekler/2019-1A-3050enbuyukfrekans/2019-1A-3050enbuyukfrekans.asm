;30h ile 50h adresleri arasýndaki verilerin en büyüðünü 
;bularak 60h adresine ve en büyügün frekansini da
;61h adresine yazan prog.


	mov 30h,#01h
	mov 31h,#0F8h
	mov 37h,#0F8h
	mov 3ah,#92h
	mov 3fh,#0F4h
	

	MOV 61h,#01H 	;frekansi tutan adres
	MOV 60h,30h ;ilk elemani en buyuk kabul ettim
	MOV R0,#31H ;dizinin indisini atadim (2. den)
tekrar:
	MOV A,@R0 ;diziden okuma yaptim
	CJNE A,60h, esitdegil
	;esit bolgesi
	INC 61h ;frekansi bir artirdim
	SJMP dongukontrol
esitdegil:
	JC yenisayikucuk	
	;yenisayi büyük bölgesi
	MOV 60H,A	;yeni büyügü atama
	MOV 61H,#01h	;yeni büyügün frekansini 1 yaptim
yenisayikucuk:
dongukontrol:
	INC R0
	CJNE R0,#51H,tekrar
	END
	