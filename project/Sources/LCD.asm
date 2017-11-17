		XDEF LCD, TIME, DATE
		XREF WAIT, CARRY, keypad, pressed
    XREF init_LCD, displayscreen
    
A_USER: ds.b 7
A_PASS: ds.b 7   
TIME: ds.b 6
DATE: ds.b 8

MY_VAR: SECTION
LCD_CUR: ds.b 1  ;Holds the current LCD display value
LCD_VAL: ds.b 1  ;Holds The value for flash on and off
NUM: ds.b 1
disp: ds.b 33	  ;values to display the LCD
WEL: ds.b 1	  ;Welcome Subroutine value
INPUT_BLOCK: ds.b 1


LCD:
 
		jsr init_LCD
		JSR WELCOME
		
		BEG_LCD:
		
		JSR DT-TI


;----------------------------------------------------------------------
		
WELCOME:
		    movb #40, WAIT		  ;Loads in value for interrupt
			
		   	movb #'W',disp
       	 	movb #'e',disp+1
       	    movb #'l',disp+2
        	movb #'c',disp+3
        	movb #'o',disp+4
        	movb #'m',disp+5
        	movb #'e',disp+6
        	movb #' ',disp+7
        	movb #' ',disp+8
        	movb #'T',disp+9
        	movb #'o',disp+10
        	movb #' ',disp+11
        	movb #' ',disp+12
        	movb #'T',disp+13
        	movb #'h',disp+14
        	movb #'e',disp+15
        	movb #' ',disp+16
        	movb #' ',disp+17
        	movb #' ',disp+18
        	movb #' ',disp+19
        	movb #' ',disp+20
        	movb #'E',disp+21
        	movb #'l',disp+22
        	movb #'e',disp+23
        	movb #'v',disp+24
        	movb #'a',disp+25
        	movb #'t',disp+26
        	movb #'o',disp+27
        	movb #'r',disp+28
        	movb #' ',disp+29
        	movb #' ',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32
        	
        	ldx #disp
        	jsr display_string
        	
            ldaa #CARRY				;checks and sees if wait is done
            cmpa #1
            BNE WELCOME
            movb #0, CARRY
            movb #1, WEL			;turns off welcome loop
		RTS
		
;------------------------------------------------------------------------

DT-TI:
			    movb #0, LCD_CUR
			
			    movb #15, WAIT
			    movb #'>', LCD_VAL
			    movb #0, NUM
			
		    	movb #'>',disp
       	 	movb #'D',disp+1
       	    movb #'A',disp+2
        	movb #'T',disp+3
        	movb #'E',disp+4
        	movb #':',disp+5
        	movb #' ',disp+6
        	movb #' ',disp+7
        	movb #'/',disp+8
        	movb #' ',disp+9
        	movb #' ',disp+10
        	movb #'/',disp+11
        	movb #' ',disp+12
        	movb #' ',disp+13
        	movb #' ',disp+14
        	movb #' ',disp+15
        	movb #' ',disp+16
        	movb #'T',disp+17
        	movb #'I',disp+18
        	movb #'M',disp+19
        	movb #'E',disp+20
        	movb #':',disp+21
        	movb #' ',disp+22
        	movb #' ',disp+23
        	movb #':',disp+24
        	movb #' ',disp+25
        	movb #' ',disp+26
        	movb #' ',disp+27
        	movb #'A',disp+28
        	movb #'M',disp+29
        	movb #'P',disp+30
        	movb #'M',disp+31
        	movb #0,disp+32
        	
        	ENTER_DT:
        	  movb #$11, INPUT_BLOCK
        	  ldx #disp
        	  jsr display_string
        	  
        	  JSR keypad                   ;jumps to keypad
        	  ldaa #pressed                ;loads value of keypad into A
        	  JSR input                    ;checks move value
        	  cmpa #0                      
        	  BNE ENTER_DT_C               ;branch 
        	  JSR FLASH                    ;sees if nothing is pressed if not then go to flash
        	  bra ENTER_DT
        	  
        	ENTER_DT_C:
        	  cpx #0                     ;sees if date was selected
        	  BEQ DT
        	  cpx #16                    ;sees if time was selected
            BEQ TI
            BRA ENTER_DT  

               
            TI:
              movb #$22, INPUT_BLOCK
              ldx #disp
        	  jsr display_string
              JSR keypad               ;goes to keypad
              JSR INPUT                ;checks input
              cmpa #21                 ;compare to see if LCD_CUR has moved or not
              BLE  TI_1                ;if not then branch else move LCD_CUR and continue
              movb #22, LCD_CUR        ;moves LCD back to LCD_CUR
              bra TI_C
          TI_1:                         ;checks and sees if it is on value of :
              cmpa #24
              BNE  TI_C                 ;if so then change val of LCD_CUR else branch
              movb #25, LCD_CUR
          TI_C:
              movb #pressed, TIME+NUM     ;saves into time
              ldab NUM                    ;loads in array value
              addb #1
              stab NUM
              ldab disp
              addb #LCD_CUR     
              movb #pressed, disp    ;changes value of LCD display 
              adda #1                        ;moves over one
              staa LCD_CUR
              cmpa #32                       ;see if out of LCD display
              BNE TI                         ;if not branch to TI 
              cpy #1                         ;see if date is changed yet or not
              BEQ END_DT                     ;if so then exit
              ldy #1                         ;else load in 1 to say TIME has changed
              bra DT
          
            DT:
              movb #$22, INPUT_BLOCK
              ldx #disp                 ;display LCD
        	  jsr display_string        
              JSR keypad                ;get value for keypad
              JSR INPUT                 ;Sees if it is a moving input
              ldaa #LCD_CUR            ;loads in LCD_CUR
              cmpa #5                  ;compare to see if LCD_CUR has moved or not
              BLE  DT_1                 ;if not then branch else move LCD_CUR and continue
              movb #6, LCD_CUR
              bra DT_C
          DT_1:                         ;checks and sees if it is on value of /
              cmpa #8
              BNE  DT_2                 ;if so then change val of LCD_CUR else branch
              movb #9, LCD_CUR
              bra DT_C
          DT_2:                         ;checks and sees if it is on value of /
              cmpa #11
              BNE DT_C                  ;if so then change val of LCD_CUR else branch
              movb #12, LCD_CUR   
          DT_C:
              movb #pressed, TIME+NUM   ;moves value into TIME
              ldab NUM
              addb #1
              stab NUM     
              ldab disp
              addb #LCD_CUR     
              movb #pressed, disp
              adda #1
              staa LCD_CUR
              cmpa #16
              BNE DT
              cpy #1
              BEQ END_DT
              ldy #1
              bra TI
        
          END_DT:
              movb #0, CARRY
              movb #1, DT
              movb #$
              RTS

;------------------------------------------------------------------------
        
ADMIN:
    			movb #8, LCD_CUR
			
			    movb #15, WAIT
			    movb #0, LCD_VAL
			    movb #0, NUM
			
		    	movb #'U',disp
       	 	movb #'S',disp+1
       	  movb #'E',disp+2
        	movb #'R',disp+3
        	movb #'N',disp+4
        	movb #'A',disp+5
        	movb #'M',disp+6
        	movb #'E',disp+7
        	movb #':',disp+8
        	movb #' ',disp+9
        	movb #' ',disp+10
        	movb #' ',disp+11
        	movb #' ',disp+12
        	movb #' ',disp+13
        	movb #' ',disp+14
        	movb #' ',disp+15
        	movb #'P',disp+16
        	movb #'A',disp+17
        	movb #'S',disp+18
        	movb #'S',disp+19
        	movb #'W',disp+20
        	movb #'O',disp+21
        	movb #'R',disp+22
        	movb #'D',disp+23
        	movb #':',disp+24
        	movb #' ',disp+25
        	movb #' ',disp+26
        	movb #' ',disp+27
        	movb #' ',disp+28
        	movb #' ',disp+29
        	movb #' ',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32      
        
          A_USERNAME:
           ldab #LCD_CUR
           addb #1
           
          A_MOVE1: 
           JSR keypad
           JSR INPUT
           cpx #LCD_CUR
           BEQ A_PASSWORD
           cmpb #LCD_CUR
           BEQ A_MOVE1
           ldaa #pressed  
           cmpb #16
           BLE A_U1
           movb #8, LCD_CUR
           bra A_USERNAME
           
          A_U1:
           cmpb #8
           BGT A_UC
           movb #8, LCD_CUR
           bra A_USERNAME 
        
          A_UC:
           
           movb #pressed, A_USER+NUM
           ldab #NUM
           addb #1
           stab NUM
           ldab disp
           addb #LCD_CUR     
           movb #pressed, disp
           
           ldaa #LCD_CUR
           adda #1
           cmpa #16
           BEQ A_PASSWORD
           bra A_USERNAME
           
          A_PASSWORD: 
           clrx
           ldab #0
           stab NUM
          A_PASSWORD_1: 
           ldab #LCD_CUR
           addb #1
           
          A_MOVE2: 
           JSR keypad
           JSR INPUT
           cpx #LCD_CUR
           BEQ A_EXIT
           cmpb #LCD_CUR
           BEQ A_MOVE2
           ldaa #pressed  
           cmpb #15
           BGT A_P1
           movb #25, LCD_CUR
           bra A_PASSWORD1
           
          A_P1:
           cmpb #24
           BGT A_UC
           movb #25, LCD_CUR
           bra A_PASSWORD1 
        
          A_UC:
           movb #pressed, A_PASS+NUM
           ldab #NUM
           addb #1
           stab NUM
           movb #pressed, disp+LCD_CUR
           
           ldaa #LCD_CUR
           adda #1
           cmpa #32
           BEQ A_END
           bra A_PASSWORD1
        
          A_END:
           movb #0, CARRY
           movb #1, ADM
           
;----------------------------------------------------------------           

  SECRET:
  	      	movb #10, LCD_CUR
			
		    movb #15, WAIT
		    movb #0, NUM 
		    
		    movb #'S',disp
       	 	movb #'E',disp+1
       	    movb #'C',disp+2
        	movb #'R',disp+3
        	movb #'E',disp+4
        	movb #'T',disp+5
        	movb #' ',disp+6
        	movb #'I',disp+7
        	movb #'D',disp+8
        	movb #':',disp+9
        	movb #' ',disp+10
        	movb #' ',disp+11
        	movb #' ',disp+12
        	movb #' ',disp+13
        	movb #' ',disp+14
        	movb #' ',disp+15
        	movb #'P',disp+16
        	movb #'A',disp+17
        	movb #'S',disp+18
        	movb #'S',disp+19
        	movb #'W',disp+20
        	movb #'O',disp+21
        	movb #'R',disp+22
        	movb #'D',disp+23
        	movb #':',disp+24
        	movb #' ',disp+25
        	movb #' ',disp+26
        	movb #' ',disp+27
        	movb #' ',disp+28
        	movb #' ',disp+29
        	movb #' ',disp+30
        	movb #' ',disp+31
        	movb #0,disp+32
		    
		    SECRET_ID:
		    	
 
 
 
 
 
 
 
  INPUT:
        
        psha			 ;saves value of A
        ldaa #LCD_CUR	 ;loads current location on LCD SCREEN
        ldab #pressed
        BRSET INPUT_BLOCK, #$22, LEFT
        
  UP:     cmpb #$C		 ;checks if up pressed
        BNE DOWN		 ;if not continue
        cmpa #16		 ;check if LCD SCREEN is on upper 16 
        BLE INPUT_DONE	 ;if so then exit
        adda #16		 ;else add 16  store and exit
        staa LCD_CUR	 
        BRA INPUT_DONE
         
  DOWN:   cmpb #$E		 ;checks if down is pressed
        BNE LEFT		 ;if not then continue
        cmpa #16		 ;check if LCD SCREEN is on lower 16
        BGE INPUT_DONE	 ;if greater than then exit
        suba #16		 ;else subtract 16 save and exit 
        staa LCD_CUR
        BRA INPUT_DONE
        
        BRSET INPUT_BLOCK, #$11
           
  LEFT:   cmpb #$A		  ;checks and see if left
        BNE	 RIGHT		  ;if not then continue
        cmpa #0			  ;compare it to 0 and 16 to see if it is already all the way to the left if so then branch
        BEQ	 INPUT_DONE	  
        cmpa #16
        BEQ	 INPUT_DONE
        deca			  ;if not then decrement and store
        staa LCD_CUR
        bra INPUT_DONE
      
  RIGHT:  cmpb #$B		  ;check and see if right is pressed and if not continue
        BNE INPUT_DONE	  
        cmpa #15		  ;compare it to 15 and 31 to see if it is already all the way to the right if so then branch
        BEQ INPUT_DONE	  
        cmpa #31
        adda #1			  ;if not then add one to shift it right and save
        staa LCD_CUR
        bra INPUT_DONE
  
  INPUT_DONE:
  
  ENTER:
        cmpb #$0
        BNE INPUT_DONE
        ldx #LCD_CUR
                
  
		pula
        RTS 
        
        
        
    FLASH:
     pusha                      
    ldaa CARRY                 ;sees what value it is on
    cmpa #1
    BEQ LCD_ON                 ;if it is 1 then branch else continue
             
   LCD_OFF: 
     movb #178,disp+LCD_CUR     ;fills current LCD and returns 
     bra FLASH_END
            
   LCD_ON:
     movb #LCD_VAL, disp+LCD_CUR     ;emptys current LCD and returns
     bra FLASH_END
   FLASH_END:      
    pula
    rts