;20h-39h aralýðýnda (ilk ve son dahil) yerleþtirilmiþ olan bir dizide, 
;verileri tek tek kontrol edip;
;a.	Çift ise, verinin yarýsýný 40h adresinden itibaren yeni diziye yerleþtiren, 
;þartý saðlayanlarýn sayýsýný da 60h adresine yazan,
;b.	Tek olanlarýn en büyüðünü 61h adresine, bulunan en büyüðün 
;(ilk veya son bulunan en büyük tercihi size aittir) adresini de 
;62h adresine yazan programý 8051 komut seti ile yazýnýz.

	org 0000h
	sjmp basla
	org 0030h
basla:

	MOV 20H,#00H
	MOV 21H,#02H
	MOV 22H,#05H
	MOV 23H,#06H
	MOV 24H,#25H
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

 	mov r0, #20h ;kaynak dizinin baslangici
	mov 61h,#01h ;en büyük kabulu
	mov r1, #40h ;çift dizisi indisi
	mov 60h, #00h ;sayaç sifirla

 yenielemanoku:
	MOV A,@R0 ;dizinin elemanini oku
	JB ACC.0,sayitek
	//sayi çift bölgesi
	MOV B,#02H
	DIV AB
	MOV @R1,A  ;yeni diziye yükle
	INC R1	  ;yeni dizi indisi artir
	INC 60H  ;sarti saglayanlarin sayaci 1 artir
	LJMP dongukontrol
sayitek:
	CJNE A,61H,esitdegil
	MOV 62H,R0
	LJMP dongukontrol
esitdegil:
	JC dongukontrol
	;yeni sayi büyük
	MOV 61H,A
	MOV 62H,R0
dongukontrol:
	INC R0
	CJNE R0,#3AH,yenielemanoku

	END
