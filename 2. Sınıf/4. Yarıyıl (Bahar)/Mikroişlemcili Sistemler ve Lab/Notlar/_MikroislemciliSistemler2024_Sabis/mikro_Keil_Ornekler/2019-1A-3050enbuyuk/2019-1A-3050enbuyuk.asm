;30h ile 50h adresleri arasýndaki verilerin en büyüðünü 
;bularak 60h adresine yazan programý tasarlayýnýz.
;dizinin adresini de 61h adresine yazsin


	mov 30h,#01h
	mov 31h,#0F8h
	mov 37h,#0F8h
	mov 3ah,#92h
	mov 3fh,#0F9h
	
	MOV 60H, 30H ;dizinin ilk elemanini en büyük kabul ettim
	MOV R0,#31H ;dizinin indisini atadim
tekrar:
	MOV A,@R0 ;dizinin yeni elemani A da
	CJNE A, 60H, esitdegil
	;esit bölgesi
	MOV 61H,R0 ;esitlik durumunda en son bulunan en büyük kabul edilirse
	SJMP dongukontrol
esitdegil:
	JC dongukontrol ;yenisayikucuk
	;yenisayi büyüktür ve degisim yapilmalidir bölgesi
	MOV 60H,A	;yeni en büyügü atadim
	MOV 61H,R0 ;yeni en büyügün dizi indisi R0 dadir
dongukontrol:
	INC R0
	CJNE R0,#51H,tekrar
	END
	