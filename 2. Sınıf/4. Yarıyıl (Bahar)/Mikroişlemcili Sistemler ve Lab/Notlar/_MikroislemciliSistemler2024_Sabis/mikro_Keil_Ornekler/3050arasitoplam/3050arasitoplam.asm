;30h ile 50h adresleri arasýndaki verilerin toplamýný bulan programý:
;a. elde oluþmadýðý düþünerek, sonucunu 60h adresine,
;b. elde oluþtuðunu düþünerek, sonucun yüksek baytýný 60h adresine, 
;   düþük baytýný 61h adresine yazacak þekilde tasarlayýnýz.

;a secenegi
//org 0000h
//sjmp basla
//org 0030h
//basla:
//	mov R0,#30h  ;dizinin ilk elemaninin indisini yükledim
//	mov A, #00h ; toplami akümülatörde tutacagim icin resetledim
//topla:
//	add A,@R0 ;ilk elemani akü ile topladim
//	inc R0	  ;bir sonraki eleman icin indisi 1 artirdim
//	cjne R0,#51h,topla	; dizinin son elemani 50h oldugu icin 51h ile karsilastirdim
//	mov 60h, A	 ; aküyü 60h adresine kopyaladim
//end


;b secenegi
org 0000h
sjmp basla
org 0030h
basla:
	mov R0,#30h  ;dizinin ilk elemaninin indisini yükledim
	mov A, #00h ; toplami akümülatörde tutacagim icin resetledim
	mov 60h,#00h ;yüksek byte sifirlandi
topla:
	add A,@R0 ;ilk elemani akü ile topladim
	jnc eldeyok
	inc 60h   ; elde varsa 60h bir artirilir, yoksa artirmadan asagiya gecer
eldeyok:
	inc R0    ;bir sonraki eleman icin indisi 1 artirdim
	cjne R0,#51h,topla  ; dizinin son elemani 50h oldugu icin 51h ile karsilastirdim
	mov 61h, A   ; aküyü 61h adresine kopyaladim
end