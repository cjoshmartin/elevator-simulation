		XDEF ELEVATOR_FLOOR, Floor_Entered, Going_Up, Going_Down
		XREF floor, LCD_CUR, LCD_VAL, disp_loc, currentfloor, disp, display_string, stepper_flag, stepper_length
		XREF Floor_SEL_MENU, flag, direction, stepper_motor, NEXT_FLOOR, MAIN_MENU, keypadoutput, pressed
		
ELEVATOR_RAM: SECTION
Floor_Entered: ds.b 1
ELEVATOR_CODE: SECTION

ELEVATOR_FLOOR:
       cmpa currentfloor 
       BNE ELEVATOR_FLOOR_CONT
       RTS
       
     ELEVATOR_FLOOR_CONT:
       staa floor
       adda #48  
       staa Floor_Entered
       JSR Floor_SEL_MENU
       movb #24, LCD_CUR
       movb Floor_Entered, LCD_VAL
       JSR disp_loc
       JSR keypadoutput
       ldaa pressed
       cmpa #$10
       BEQ EF_CONT
       RTS
       
     EF_CONT:
      ldaa currentfloor
      cmpa floor
      BLT Going_Down
      
    Going_Up:
      movb #1, direction
      movb #3, flag
      movb #1, stepper_flag
    Go_Up_L:
      JSR stepper_motor
      ldaa direction
      cmpa #0
      BNE Go_Up_L
      RTS
      
    Going_Down:
      movb #2, direction
      movb #3, flag
      movb #1, stepper_flag
    Go_Down_L:
      JSR stepper_motor
      ldaa direction
      cmpa #0
      BNE Go_Down_L      
      RTS  
        
        