		XDEF INITIALIZE_PORTS
		XDEF port_s, port_t, port_p, port_u
	  XREF init_LCD
	  XREF WAIT, CARRY, CRGINT, RTICTL


PORTS_RAM: SECTION
port_u: equ $268
ddr_port_u: equ $26A
psr_port_u: equ $26D
pde_port_u: equ $26C
port_s: equ     $248
port_s_ddr: equ $24A
port_t: equ		$240 ;DC Motor
port_t_ddr: equ $242
port_p: equ     $258 ;Stepper Motor
port_p_ddr: equ $25A
		
PORTS_CODE:	 SECTION

	INITIALIZE_PORTS:
	JSR init_LCD
	movb #0, WAIT
	movb #0, CARRY
	bset port_s_ddr, #$FF ; used to intiliaze the LED display
	bset ddr_port_u, #$F0; used to intiliaze the hex keys
  bset psr_port_u, #$F0
  bset pde_port_u, #$0F
  bset port_p_ddr, #$1E ;Turns the stepper motor on
  BSET port_t_ddr, #$08 ;Turns the DC MOTOR
  bset CRGINT, #$80					  ;sets CRGINT
  movb #$6B ,RTICTL					  ;Sets RTICTIL to about 50 milliseconds
  CLI 
    RTS    
				