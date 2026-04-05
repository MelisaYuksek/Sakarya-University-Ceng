;30h ile 50h adresleri arasýndaki verilerin en büyüðünü bularak 
;60h adresine yazan programý tasarlayýnýz.

org 0000h
sjmp basla
org 0030h
basla:
	mov A, #00h
	mov 60h,30h  ;dizinin ilk elemani en büyük kabul edildi
	mov R0,#31h  ;dizi indisi ikinciden baslandi
tekrar:
	mov A,@R0   ;diziden yeni eleman okundu ve Akü de tutuldu
	cjne A,60h,esitdegil  ;yeni eleman ile 60h daki (en büyük) deger karsilastirildi
	;esit bolgesi. burada yapilacak islem yoksa döngü kontrole atlanmali
	sjmp kontrol
esitdegil:
	;esitdegil ise ya buyuktur ya da kucuk bunu Carry(borç) ile kontrol ederiz
	JC kontrol  ;C varsa yeni deger küçüktür ki C (borç) olusmustur
	;elde yok bölgesi. yeni okunan deger büyük. 
	mov 60h,A  ;yeni bulunan büyügü 60h adresine kopyaladim

kontrol: ;bir sonraki eleman için hazirlik ve döngü sonu kontrolü
	inc R0
	cjne R0,#51h,tekrar
	end
