; sound 
; no where near done

		xdef sound_arr
		XREF SendsChar,PlayTone
		XREF number_in_sound_seq, repeats
		XREF flag, 
			; musical notes
		A3: equ 37
		B3: equ 33
		C3: equ 63
		D3: equ 56
		E3: equ 50
		F3: equ 47
		G3: equ 42
		C4: equ 31
		D4: equ 28
		E4: equ 25
		F4: equ 24
		G4: equ 21
		A4: equ 19
		A5: equ 9
		B5: equ 8
		B4: equ 17
		C5: equ 16
		D5: equ 14
		E5: equ 12
		F5: equ 11
		G5: equ 10
		A3F: equ 40
		B3F: equ 35
		D3F: equ 59
		E3F: equ 53
		G3F: equ 44
		A5F: equ 10
		B5F: equ 9
		D5F: equ 15
		E5F: equ 13
		G5F: equ 11
		


		;sound_arr: dc.b	D3F,255,E4,255,E4,E4,255,E4,255,E4,E4,255,E4,G4,C4,D4,E4,E4,$FE
		 sound_arr: dc.b	59,59,59,27,24,24,27,255,16,16,18,18,20
		 
speaker:	
		pshx
		pshy
		pshd	 
	   movb #5, flag
	   
reload: ldx #sound_arr 
		movb #0, number_in_sound_seq
		
play_sound: ldaa number_in_sound_seq
			ldab a,x
	   		psha
	   		pshx
	   		pshb
	   		jsr SendsChar
	   		jsr PlayTone
	   		pulb
	   		pula
	   		cmpa #12 	   ;loads the value of number_in_sound_seq and then compares it to 12
	   		bne play_sound 
	   		inc repeats
	   		ldaa repeats
	   		ldaa #4 
	   		bne reload
	   		movb #99, flag
	   		
	   	puld
		puly
		pulx 
		rts	 
	   
;------------------------- crap code --------------------------
 ;      ldab sound_flag
;	   cmpb #1
;	   beq load_it
;	   ldx #sound_arr
;	   movw #0,sound_delay
;	   movb #1, sound_flag
	   
   
;load_it:ldd sound_delay
;		cpd #0
;		 bne keeping_going ;play_note
;	   ldaa 1,x+
;	   staa sent_sound
;	   cmpa #$FE
;	   bne keeping_going
;	   movb #0, sound_flag
	   

; ldaa sent_sound
	  ; psha
	  ; jsr SendsChr
	   ;pula
;play_note:
	   ;ldd sound_delay
	   ;addd #1
	   ;std sound_delay
	   ;jsr PlayTone	   
	   ;cpd #19
	   ;bne TIME_DONE
 	   
 	   ;movw #0,sound_delay



