;30h ile 50h adresleri arasýndaki verilerden en büyük olaný
;bulup 60 adresine yazan program
;en büyüðün indisini (adresini) 61H a yazsin
;en büyügün frekansini da 62h adresine yazsin

	MOV 31H,#0A6H   ; buradaki adres deðerleri
	MOV 32H,#08H   ; çalýþma sirasinda sonuç
	MOV 33H,#48H   ; gormek icindir
	MOV 34H,#0F6H
	MOV 35H,#08H
	MOV 36H,#08H
	MOV 37H,#08H
	MOV 38H,#0F6H
	MOV 39H,#0F6H
	MOV 50H,#0F6H

	MOV 60H, 30H  ;dizinin ilk elemanini en büyük kabul ettim
	MOV 62H,#01H  ;frekans sayisi
	MOV R1, #31H  ;dizinin indisi
tekrar:
	MOV A,@R1    ;diziden yeni elemani oku
	CJNE A,60H,esitdegil
	;esit bolgesi
	MOV 61H,R1
	INC 62H
	LJMP dongukontrol
esitdegil:
	JC dongukontrol
	;yeni sayi büyük bölgesi
	MOV 60H,A
	MOV 61H,R1 ;en büyük indisini atadim
	MOV 62H,#01H ;yeni en büyükte frekansý resetledim
dongukontrol:
	INC R1
	CJNE R1,#51H,tekrar


	END




