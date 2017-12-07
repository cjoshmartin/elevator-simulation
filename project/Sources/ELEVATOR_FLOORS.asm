		XDEF ELEVATOR_FLOOR, Floor_Entered, Floor_Dist
		XREF floor, FLOOR_ENTRY, FLOOR_DEST, LCD_CUR, LCD_VAL, disp_loc, currentfloor, disp, display_string
		XREF Floor_SEL_MENU, WAIT, CARRY, flag, Go_Up, Go_Down, direction, stepper_motor, NEXT_FLOOR, MAIN_MENU, stepper_del_length
ELEVATOR_RAM: SECTION
Floor_Entered: ds.b 1
Floor_Flag: ds.b 1
Floor_Dist: ds.b 1
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
       movw #24000, WAIT
       movb #0, CARRY
       movb #0, flag
     ELEVATOR_WAIT:
          ldaa CARRY
          cmpa #1
          BNE ELEVATOR_WAIT
          movb #0, CARRY
       ldaa floor 		
       cmpa currentfloor
       ;BGT Going_UP
     Going_Down:
          JSR Go_Down
          movb Floor_Entered, NEXT_FLOOR 
          JSR MAIN_MENU
          movb #0, CARRY
          movb #99, flag
          movb #2, direction
     Stepper_Down:
       JSR stepper_motor
  
       
        
           
          
     STEPPER_OUT:     
         RTS 
            
        
        