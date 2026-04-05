;30h ile 4Fh adresleri arasýndaki verilerden 3’ün katlarý olanlarý 
;50h adresinden itibaren kopyalayan ve yeni oluþan dizinin 
;en büyük elemanýnýn 3’ün kaç katý olduðunu 70h adresine kaydeden programý yazýnýz.
;3 e bölünenlerin sayisi 71h da olsun
	mov 30h,#03h
	mov 31h,#02h
	mov 37h,#09h
	mov 3ah,#09h
	mov 3fh,#04h
	MOV R0,#30H ;kaynak dizinin indisini atadim
	MOV R1,#50H ;hedef dizinin indisi
	MOV 71H,#00H ;3 kati frekansi
tekrar:
	MOV A,@R0 ;kaynaktan okuma
	CJNE A,#00H,atla ;0 ise alma
	LJMP ucunkatidegil
atla:
	MOV B,#03H ;3 bolunecek
	DIV AB 
	MOV A,B
	CJNE A,#00H,ucunkatidegil
	;3 ün kati bölgesi
	MOV A,@R0 ;yeniden oku
	MOV @R1,A ;yeni diziye aktar
	INC 71H
	INC R1
ucunkatidegil:
	INC R0
	CJNE R0,#50H,tekrar
	
	MOV R5,50H
	MOV R1,#51H
tekrar2:
	MOV A,@R1
	CJNE A,70H,esitdegil
	LJMP dongukontrol
esitdegil:
	JC dongukontrol
	;yeni sayi büyük
	MOV R5,A
	MOV B,#03H
	DIV AB
	MOV 70H,A
dongukontrol:
	INC R1
	DJNZ 71H,tekrar2

	END




