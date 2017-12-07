		XDEF DC_MOTOR, Ton, Toff

DC_RAM: SECTION
Ton: ds.b 1
Toff: ds.b 1
		
DC_CODE: SECTION

DC_MOTOR:
			