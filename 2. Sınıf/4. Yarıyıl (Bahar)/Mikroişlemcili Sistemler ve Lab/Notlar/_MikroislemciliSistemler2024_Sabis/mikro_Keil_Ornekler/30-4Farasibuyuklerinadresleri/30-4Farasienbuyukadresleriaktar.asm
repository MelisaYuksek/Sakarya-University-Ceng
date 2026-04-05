;30h ile 4Fh adresleri arasýndaki verilerin en büyügünü bulan
;ve 50h adresine yazan program, sayisini da 51h adresine yazan
;ve adreslerini de 60h adresinden itibaren yazan

	MOV 30H,#0D1H
	MOV 31H,#0F9H
	MOV 32H,#21H
	MOV 33H,#0F9H
	MOV 34H,#0F9H
	MOV 3AH,#0E7H
	MOV 3CH,#0FFH
	MOV 44H,#0F9H

	MOV 50H,30H ;en büyük
	MOV 51H,#01H ;sayac
	MOV 60H,#30H ;adres indisini yaz
	MOV R0,#31H
	MOV R1,#61H
 tekrar:
	MOV A,@R0
	CJNE A,50H,esitdegil
	;esit bolgesi
	INC 51H
	MOV 20H,R0
	MOV @R1,20H
	INC R1
	SJMP yenisayikucuk	  
esitdegil:
	JC yenisayikucuk
	;yeni sayi büyük bölgesi
	MOV 50H,A
	MOV 51H,#01H
	MOV 60H,R0

yenisayikucuk:
	INC R0
	CJNE R0,#50H,tekrar

	END