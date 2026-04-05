;20h ile 39h arasindaki verilerden 
;05h dan büyük ve 10h'dan küçük olanlarin sayisini 40h a yazan,
; ve bu sayilari 50h adresinden itibaren aktararak
; yeni dizi olusturan programi yaziniz
; yeni dizinin elemanlari toplamini 41H adresine yazan

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


	MOV R0,#20H ;kaynak dizinin indisi
	MOV R1,#50H ;hedef dizinin indisi
	MOV 40H,#00H ;sayaci sifiriladik

 tekrar:
	MOV A,@R0
	CJNE A,#05H,esitdegilbes
	;CJNE @R0,#05H,esitdegilbes   ;BU KOD DA OLABILIRDI
	LJMP dongukontrol
esitdegilbes:
	JC dongukontrol
	;5 ten büyük bölgesi
	CJNE A,#10h,esitdegilon
	LJMP dongukontrol
esitdegilon:
	JNC dongukontrol
	;5 ten büyük 10 dan küçük bölgesi
	INC 40H ;sayaci artir
	MOV @R1,A ;yeni diziye aktar
	INC R1
dongukontrol:
	INC R0
	CJNE R0,#3AH,tekrar

;TOPLAMI BULMA BLOGU
	MOV A,#00H
	MOV R1,#50H
	MOV R7,40H ;dizinin eleman sayisini R7 ye aldim
 topla:
	ADD A,@R1
	INC R1
	DJNZ R7,topla
	MOV 41H,A

	END