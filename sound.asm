; sound 
; no where near done

		xdef seq_1, speaker
		XREF SendsChr,PlayTone
		XREF number_in_sound_seq, repeats
		XREF flag,sound_flag
		XREF did_play, to_play
		
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
		


		seq_1: dc.b	D3F,255,E4,255,E4,E4,255,E4,255,E4,E4,255,E4,G4,C4,D4,E4,E4
		seq_2: dc.b	20,20,20,27,24,24,27,255,16,16,18,18,20
		seq_3: dc.b	20,20,20,27,24,24,27,255,16,16,18,18,20
		seq_4: dc.b	20,20,20,27,24,24,27,255,16,16,18,18,20
		 
speaker:
	 ldaa did_play
	 cmpa #1
	 beq skip
	 
	 movb #5,flag
	 ;bra skip
	 ldaa	number_in_sound_seq
	 
	 ldab to_play ; tell what seq needs to be loaded
	 cmpb #1
	 bne compare_2
	 ldx	#seq_1
	 bra cont
compare_2: cmpb #2
	 bne compare_3
	 ldx seq_2
	 bra cont
compare_3: cmpb #3
	 bne compare_4
	 ldx seq_3
	 bra cont
compare_4: cmpb #4
	 bne skip
	 ldx seq_4

cont:	 
  	 movb #0, number_in_sound_seq
  	  
  	 loop: ldaa number_in_sound_seq	 
  	  movb #5,flag
      ldab a,x
 	  movb #1, sound_flag 
 	   pshx
 	   psha
 	   pshb
 	   jsr SendsChr
 	   jsr PlayTone
 	   pulb
 	   pula
 	   pulx
 	    
 	   ldaa number_in_sound_seq
 	   cmpa	#12
 	   BLO	loop			;length of song
 	   movb #0, number_in_sound_seq
 	   movb #1, did_play
 skip: rts


;--------------------- JUNK CODE ------------------------------------------
	
	;	pshx
	;	pshy
	;	pshd	 
;	   movb #5, flag
	   
;reload: ldx #seq_1 
		movb #0, number_in_sound_seq
		
;play_sound: ;ldaa number_in_sound_seq
;			ldaa D3F;a,x
;	   		psha
;	   		jsr SendsChr
;	   		pula
;	   		jsr PlayTone
	   		;cmpa #12 	   ;loads the value of number_in_sound_seq and then compares it to 12
	   		;bne play_sound 
	   		;inc repeats
	   		;ldaa repeats
	   		;ldaa #4 
	   		;bne reload
	   		;movb #99, flag
	   		
	   ;	puld
		;puly
		;pulx 
;		rts	 
	   
;------------------------- crap code --------------------------
 ;      ldab sound_flag
;	   cmpb #1
;	   beq load_it
;	   ldx #seq_1
;	   movw #0,number_in_sound_seq
;	   movb #1, sound_flag
	   
   
;load_it:ldd number_in_sound_seq
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
	   ;ldd number_in_sound_seq
	   ;addd #1
	   ;std number_in_sound_seq
	   ;jsr PlayTone	   
	   ;cpd #19
	   ;bne TIME_DONE
 	   
 	   ;movw #0,number_in_sound_seq
 	   
	   


