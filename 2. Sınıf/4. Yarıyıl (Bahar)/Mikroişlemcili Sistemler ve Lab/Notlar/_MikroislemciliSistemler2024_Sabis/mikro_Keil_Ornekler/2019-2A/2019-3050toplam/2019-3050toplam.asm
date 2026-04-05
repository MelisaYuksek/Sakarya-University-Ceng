;30h ile 50h adresleri arasýndaki verilerin toplamýný bulan programý:
;a. elde oluþmadýðý düþünerek, sonucunu 60h adresine,
;b. elde oluþtuðunu düþünerek, sonucun yüksek baytýný 60h adresine, 
;düþük baytýný 61h adresine yazacak þekilde tasarlayýnýz.
org 0000h
sjmp basla
org 0030h
basla:
	mov 30h,#01h
	mov 31h,#02h
	mov 37h,#08h
	mov 3ah,#02h
	mov 3fh,#04h

	MOV R0,#30H ;dizinin indisini atadim
	MOV A,#00H ;aküyü sifirladim
	MOV 60H,#00H ;toplamin yüksek byte sifirladim
topla:	
	ADD A,@R0 ;diziden okuma ve toplama
	JNC eldeyok
	;elde var
	INC 60H
eldeyok:
	INC R0
	CJNE R0,#51H,topla ;döngü kontrolü
	MOV 61H,A ;toplamin düsük byte i 61h a aktar
	END






