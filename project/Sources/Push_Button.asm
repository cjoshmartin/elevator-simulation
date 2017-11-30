	XDEF Push_Button
	XREF port_p
EXTRAS_CODE: Section
	
Push_Button:
	 ldaa #port_p
     BRSET port_p, #$20, Push_Button_End
     ldaa #$10
     RTS
     Push_Button_End:
     RTS
	