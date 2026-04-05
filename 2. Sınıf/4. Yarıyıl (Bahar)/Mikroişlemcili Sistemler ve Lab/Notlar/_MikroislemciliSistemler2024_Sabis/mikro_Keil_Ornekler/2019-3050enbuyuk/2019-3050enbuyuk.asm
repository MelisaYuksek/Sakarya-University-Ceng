;30h ile 50h adresleri arasýndaki verilerin en büyüðünü 
;bularak 60h adresine yazan programý tasarlayýnýz.
;dizinin adresini de 61h adresine yazsin


	mov 30h,#01h
	mov 31h,#0F8h
	mov 37h,#0F8h
	mov 3ah,#92h
	mov 3fh,#0F4h
	
	MOV 61H,#01H ;frekans sayisi resetleme
	MOV 60H,30H ;dizinin ilk elemani en büyük
	MOV R0,#31H ;dizinin indisi
tekrar:
	MOV A,@R0 ;dizi okuma
	CJNE A,60H,esitdegil
	;esit bölgesi
	INC 61H ;frekansi bir artir
	SJMP dongukontrol
esitdegil:
	JC yenisayikucuk
	;yeni sayi büyük bölgesi
	MOV 60H,A  ;yeni en büyük aktardim
	MOV 61H,#01H; frekansi resetledim
yenisayikucuk:
dongukontrol:
	INC R0
	CJNE R0,#51H,tekrar

	END




