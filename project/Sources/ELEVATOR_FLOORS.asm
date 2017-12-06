		XDEF ELEVATOR_FLOOR
		XREF floor, FLOOR_ENTRY, FLOOR_DEST, LCD_CUR, LCD_VAL, disp_loc, keypadoutput, pressed
ELEVATOR_RAM: SECTION
Floors_Entered: ds.b 8
ELEVATOR_CODE: SECTION

ELEVATOR_FLOOR:		
		JSR FLOOR_ENTRY
		movb #16, LCD_CUR
	     
	     
	     EF_1:
	       JSR keypadoutput
		   ldaa pressed
		   cmpa #$D
		   BNE EF_2
		   
		 EF_2:  
		   adda #48
		   staa LCD_VAL
		   jsr disp_loc
		   ldaa LCD_CUR
		   adda #2
		   staa LCD_CUR