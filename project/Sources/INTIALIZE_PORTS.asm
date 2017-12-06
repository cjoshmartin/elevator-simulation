		XDEF INITIALIZE_PORTS
		XDEF port_s, port_t, port_p,port_u, ddr_port_u ,psr_port_u, pde_port_u 
	    XDEF RTIENA,RTIFLG
	    
	    XREF init_LCD, Count_1, Count_2, TIME_VAL, DATE_VAL
	  	XREF WAIT, CARRY, CRGINT, RTICTL, stateofelevator, NEXT_FLOOR
	  	XREF ADMIN_PASS
	  	XREF state_of_load, stepper_flag,direction,floor, stepper_delay,LED_delay, max_value_of_pot, currentfloor
	   	XREF flag, LED_flag
	   


PORTS_RAM: SECTION
ddr_port_u: equ $26A
psr_port_u: equ $26D
pde_port_u: equ $26C
port_u      equ $268
port_s:     equ $248
port_s_ddr: equ $24A
port_t:     equ	$240 ;DC Motor
port_t_ddr: equ $242
port_p: 	equ $258 ;Stepper Motor
port_p_ddr: equ $25A
RTIENA:		equ $38
RTIFLG: 	equ $37
		
PORTS_CODE:	 SECTION

	INITIALIZE_PORTS:
	JSR init_LCD
	movb #0, WAIT
	movb #0, CARRY
	movb #'1', stateofelevator
	movb #'1', NEXT_FLOOR
	movb #0, Count_1
	movb #0, Count_2
	movb #%00011110, port_p_ddr ; intialize the stepper motor
	
	;pre-initialize the value for time
	movb #'-', TIME_VAL
	movb #'-', TIME_VAL+1
	movb #':', TIME_VAL+2
    movb #'-', TIME_VAL+3
    movb #'-', TIME_VAL+4
    movb #'-', TIME_VAL+5
    movb #'-', TIME_VAL+6
  
  ;pre-initialize the value for date
  movb #'-', DATE_VAL
  movb #'-', DATE_VAL+1
  movb #'/', DATE_VAL+2
  movb #'-', DATE_VAL+3
  movb #'-', DATE_VAL+4
  movb #'/', DATE_VAL+5
  movb #'-', DATE_VAL+6
  movb #'-', DATE_VAL+7
  movb #'-', DATE_VAL+8
  movb #'-', DATE_VAL+9
  
  ;pre-initialize the password for ADMIN Password
  movb #48, ADMIN_PASS
  movb #48, ADMIN_PASS+1
  movb #48, ADMIN_PASS+2
  movb #48, ADMIN_PASS+3
  movb #48, ADMIN_PASS+4
  movb #48, ADMIN_PASS+5
  movb #48, ADMIN_PASS+6
  movb #48, ADMIN_PASS+7
	bset port_s_ddr, #$FF ; used to intiliaze the LED display
	bset ddr_port_u, #$F0; used to intiliaze the hex keys
    bset psr_port_u, #$F0
    bset pde_port_u, #$0F
    bset port_p_ddr, #$1E ;Turns the stepper motor on
    BSET port_t_ddr, #$08 ;Turns the DC MOTOR
   
    clr stateofelevator
    clr floor
    clr state_of_load
    clr stepper_flag
    clr LED_flag
    clr LED_delay
    clr stepper_delay
   
    movb #'1', currentfloor
    movb #'1', NEXT_FLOOR
	movb #0, stepper_flag ;init state of the stepper
	movb #0, flag
   	movb #$74, max_value_of_pot
    movb #0, state_of_load
    movb #0, floor ; the highest or lowest floor 
    movb #2, direction ; tell the elevator wants to move upwards
	
	bset CRGINT, #$80					  ;sets CRGINT
 	movb #$10 ,RTICTL	;6b				  ;Sets RTICTIL to about 50 milliseconds 
 	CLI
    RTS    
				