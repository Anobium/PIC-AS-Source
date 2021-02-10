;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\08_reversible_leds_with_variable_delay.S"
 SUBTITLE    "02-10-2021"

; Reverse lookup file
; C:\Program Files\Microchip\xc8\v2.31\pic\include\proc\pic16f18855.inc

 #include <xc.inc>

;********************************************************************************
;Explicit PIC-AS constants to resolve the crazyness of the PIC-AS syntax
;These are therefore the same as MPASM
#define BANKED b
#define ACCESS a
#define UPPER low highword

;********************************************************************************
;Explicit CONFIG
 CONFIG FCMEN = ON
 CONFIG CLKOUTEN = OFF
 CONFIG RSTOSC = HFINT32
 CONFIG FEXTOSC = OFF
 CONFIG MCLRE = OFF
 CONFIG WDTE = OFF
 CONFIG LVP = OFF
 CONFIG WRT = OFF
 CONFIG CPD = OFF
 CONFIG CP = OFF
;Inferred CONFIG

;********************************************************************************

;Set aside RAM memory locations for variables. All variables are global.
 ADREADPORT                       EQU 32                    ; 0X20
 BYTENUM                          EQU 33                    ; 0X21
 BYTETOBIN                        EQU 9150                    ; 0X23BE
 CHECK_SWITCH                     EQU 34                    ; 0X22
 COMPORT                          EQU 35                    ; 0X23
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 DIRECTION                        EQU 36                    ; 0X24
 HSERPRINTCRLFCOUNT               EQU 37                    ; 0X25
 LEDS                             EQU 38                    ; 0X26
 MYDELAY                          EQU 39                    ; 0X27
 PRINTLEN                         EQU 40                    ; 0X28
 READAD10                         EQU 41                    ; 0X29
 READAD10_H                       EQU 42                    ; 0X2A
 RIGHT                            EQU 9159                    ; 0X23C7
 SERDATA                          EQU 43                    ; 0X2B
 STRINGPOINTER                    EQU 44                    ; 0X2C
 SYSARRAYTEMP1                    EQU 45                    ; 0X2D
 SYSARRAYTEMP2                    EQU 46                    ; 0X2E
 SYSBITVAR0                       EQU 47                    ; 0X2F
 SYSBYTETEMPA                     EQU 117                    ; 0X75
 SYSBYTETEMPB                     EQU 121                    ; 0X79
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSCALCTEMPA                     EQU 117                    ; 0X75
 SYSCHARCOUNT                     EQU 48                    ; 0X30
 SYSCHARSTART                     EQU 49                    ; 0X31
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSDIVMULTA                      EQU 119                    ; 0X77
 SYSDIVMULTA_H                    EQU 120                    ; 0X78
 SYSDIVMULTB                      EQU 123                    ; 0X7B
 SYSDIVMULTB_H                    EQU 124                    ; 0X7C
 SYSDIVMULTX                      EQU 114                    ; 0X72
 SYSDIVMULTX_H                    EQU 115                    ; 0X73
 SYSPRINTDATAHANDLER              EQU 50                    ; 0X32
 SYSPRINTDATAHANDLER_H            EQU 51                    ; 0X33
 SYSPRINTTEMP                     EQU 52                    ; 0X34
 SYSREPEATTEMP1                   EQU 53                    ; 0X35
 SYSREPEATTEMP2                   EQU 54                    ; 0X36
 SYSSTRINGA                       EQU 119                    ; 0X77
 SYSSTRINGA_H                     EQU 120                    ; 0X78
 SYSSTRINGLENGTH                  EQU 118                    ; 0X76
 SYSSTRINGTEMP                    EQU 55                    ; 0X37
 SYSSYSINSTRINGHANDLER            EQU 56                    ; 0X38
 SYSSYSINSTRINGHANDLER_H          EQU 57                    ; 0X39
 SYSTEMP1                         EQU 58                    ; 0X3A
 SYSTEMP1_H                       EQU 59                    ; 0X3B
 SYSTEMP2                         EQU 60                    ; 0X3C
 SYSTEMP3                         EQU 61                    ; 0X3D
 SYSWAITTEMP10US                  EQU 117                    ; 0X75
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 SYSWORDTEMPA                     EQU 117                    ; 0X75
 SYSWORDTEMPA_H                   EQU 118                    ; 0X76
 SYSWORDTEMPB                     EQU 121                    ; 0X79
 SYSWORDTEMPB_H                   EQU 122                    ; 0X7A
 SYSWORDTEMPX                     EQU 112                    ; 0X70
 SYSWORDTEMPX_H                   EQU 113                    ; 0X71

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 4
 AFSR0_H                          EQU 5
 SYSREADAD10WORD                  EQU 41
 SYSREADAD10WORD_H                EQU 42
 SYSRIGHT_0                       EQU 1575

;********************************************************************************

 PSECT   RESETVEC,delta=2, abs
 RESETVEC:
;VECTORS
	ORG	0
	PAGESEL	BASPROGRAMSTART
	GOTO	BASPROGRAMSTART
	ORG	4
	RETFIE

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	5
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	CALL	INITSYS
	CALL	INITUSART

;START OF THE MAIN PROGRAM
;''
;''  This demonstration produces a variable speed rotating LED display that is proportional to the ADC value.
;''  The ADC value and LED rotate speed are inversely proportional to each other.
;''
;''  Rotate the POT counterclockwise to see the LEDs shift faster.
;''
;''  Press the switch to reverse the direction of the LEDs.
;''
;''  The four LSbs of the ADC are mirrored onto the LEDs. Rotate the potentiometer
;''  to change the display.
;''
;''
;''  PIC: 16F18855
;''  Compiler: GCB
;''  IDE: GCB@SYN
;''
;''  Board: Xpress Evaluation Board
;''  Date: 13.3.2016
;''
;----- Configuration
;#DEFINE SWITCH_DOWN         0
;#DEFINE SWITCH_UP           1
;#DEFINE LED_RIGHT           TRUE
;#DEFINE LED_LEFT            FALSE
;#DEFINE SWITCH          PORTA.5
;Dim DIRECTION As Byte
;Dim mydelay, leds  As Byte
;start from the right to left
;direction = LED_RIGHT
	MOVLW	255
	MOVWF	DIRECTION
;Dir porta Out
CLRF	TRISA
;leds = 8
	MOVLW	8
	MOVWF	LEDS
;Potentitor is connected to RA4...set as input
;Dir porta.4 In
	BSF	TRISA,4
;setup switch (SW1)
;Dir SWITCH In
	BSF	TRISA,5
;Do
SYSDOLOOP_S1:
;mydelay = ReadAD10( AN4 ) / 4
	MOVLW	4
	MOVWF	ADREADPORT
	CALL	FN_READAD107
	MOVF	SYSREADAD10WORD,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSREADAD10WORD_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	4
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	MOVWF	MYDELAY
;Factor the ADC reading to delay steps
;mydelay = mydelay / 16
	MOVWF	SYSBYTETEMPA
	MOVLW	16
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPA,W
	MOVWF	MYDELAY
;decrement the 4 LSbs of the ADC and delay 20ms for each
;Do While ( mydelay <> 0 )
SYSDOLOOP_S2:
	MOVF	MYDELAY,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	SYSDOLOOP_E2
;mydelay--
	DECF	MYDELAY,F
;Wait 20 ms
	MOVLW	20
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;If check_switch = TRUE Then
	CALL	FN_CHECK_SWITCH
	INCF	CHECK_SWITCH,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
;toggle the direction
;direction = !direction
	COMF	DIRECTION,F
;End If
;Loop
	GOTO	SYSDOLOOP_S2
SYSDOLOOP_E2:
;porta = leds
	MOVF	LEDS,W
MOVWF	PORTA
;Show state
;If direction = LED_RIGHT Then
	INCF	DIRECTION,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ELSE2_1
;HSerPrint ">> "
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;Else
	GOTO	ENDIF2
ELSE2_1:
;HSerPrint "<< "
	MOVLW	LOW STRINGTABLE2
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE2) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;End If
ENDIF2:
;HSerPrint Right(ByteToBin( leds ),4)
	MOVF	LEDS,W
	MOVWF	BYTENUM
	CALL	FN_BYTETOBIN
	MOVLW	LOW BYTETOBIN
	MOVWF	SYSSYSINSTRINGHANDLER
	MOVLW	HIGH BYTETOBIN
	MOVWF	SYSSYSINSTRINGHANDLER_H
	MOVLW	4
	MOVWF	SYSCHARCOUNT
	CALL	FN_RIGHT
	MOVLW	LOW RIGHT
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH RIGHT
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;If  direction = LED_RIGHT  Then
	INCF	DIRECTION,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ELSE3_1
;shift to the right by 1
;Rotate leds Right Simple
	RRF	LEDS,W
	RRF	LEDS,F
;when the ROTATE moves the bit to bit 7, restart the pattern
;If leds = 128 Then
	MOVLW	128
	SUBWF	LEDS,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF4
;leds = 8
	MOVLW	8
	MOVWF	LEDS
;End If
ENDIF4:
;Else
	GOTO	ENDIF3
ELSE3_1:
;Set C off to ensure the carry bit does not impact
;Set C Off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate leds Left
	RLF	LEDS,F
;when the last LED is lit, restart the pattern
;If  leds = 16 Then
	MOVLW	16
	SUBWF	LEDS,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF5
;leds = 1
	MOVLW	1
	MOVWF	LEDS
;End If
ENDIF5:
;End If
ENDIF3:
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
;global variable - if button is held down, we don't want to keep on switching directions
;Dim previous_state As BIT
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: STRING.H (551)
FN_BYTETOBIN:
;ByteToBin = ""
	MOVLW	LOW BYTETOBIN
MOVWF	FSR1L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR1H
	MOVLW	LOW STRINGTABLE34
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE34) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRING
;Repeat 8
	MOVLW	8
	MOVWF	SYSREPEATTEMP1
SYSREPEATLOOP1:
;If ByteNum.7 = 1 Then
	BTFSS	BYTENUM,7
	GOTO	ELSE16_1
;ByteToBin = ByteToBin +"1"
	MOVLW	LOW BYTETOBIN
MOVWF	FSR1L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR1H
	CLRF	SYSSTRINGLENGTH
	MOVLW	LOW BYTETOBIN
MOVWF	FSR0L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR0H
	CALL	SYSCOPYSTRINGPART
	MOVLW	LOW STRINGTABLE35
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE35) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRINGPART
	MOVLW	LOW BYTETOBIN
MOVWF	FSR0L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR0H
	MOVF	SYSSTRINGLENGTH,W
MOVWF	INDF0
;Else
	GOTO	ENDIF16
ELSE16_1:
;ByteToBin = ByteToBin +"0"
	MOVLW	LOW BYTETOBIN
MOVWF	FSR1L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR1H
	CLRF	SYSSTRINGLENGTH
	MOVLW	LOW BYTETOBIN
MOVWF	FSR0L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR0H
	CALL	SYSCOPYSTRINGPART
	MOVLW	LOW STRINGTABLE36
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE36) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRINGPART
	MOVLW	LOW BYTETOBIN
MOVWF	FSR0L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR0H
	MOVF	SYSSTRINGLENGTH,W
MOVWF	INDF0
;End If
ENDIF16:
;Rotate ByteNum Left
	RLF	BYTENUM,F
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
	RETURN

;********************************************************************************

;SOURCE: 08_REVERSIBLE_LEDS_WITH_VARIABLE_DELAY.GCB (106)
FN_CHECK_SWITCH:
;switch is normally open to 5V ...when pressed, RA3 is connected to GND
;If (SWITCH = SWITCH_DOWN) Then
	BTFSC	PORTA,5
	GOTO	ELSE6_1
;debounce by delaying and checking if switch is still pressed
;Wait 1 ms
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;If ( (previous_state =  SWITCH_DOWN) & (SWITCH = SWITCH_DOWN) ) Then
	CLRF	SYSBYTETEMPX
	BTFSS	SYSBITVAR0,0
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP1
	CLRF	SYSBYTETEMPX
	BTFSS	PORTA,5
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP2
	MOVF	SYSTEMP1,W
	ANDWF	SYSTEMP2,W
	MOVWF	SYSTEMP3
	BTFSS	SYSTEMP3,0
	GOTO	ELSE7_1
;don't toggle
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;Else
	GOTO	ENDIF7
ELSE7_1:
;check if still down
;If (SWITCH = SWITCH_DOWN) Then
	BTFSC	PORTA,5
	GOTO	ELSE8_1
;previous_state = SWITCH_DOWN
	BCF	SYSBITVAR0,0
;reverse the LEDs
;check_switch = TRUE
	MOVLW	255
	MOVWF	CHECK_SWITCH
;Exit Function
	RETURN
;Else
	GOTO	ENDIF8
ELSE8_1:
;switch not properly held down
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0
;don't reverse
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;End If
ENDIF8:
;End If
ENDIF7:
;Else
	GOTO	ENDIF6
ELSE6_1:
;switch not pressed
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0
;don't reverse
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;End If
ENDIF6:
	RETURN

;********************************************************************************

DELAY_10US:
D10US_START:
	MOVLW	25
	MOVWF	DELAYTEMP
DELAYUS0:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS0
	NOP
	DECFSZ	SYSWAITTEMP10US, F
	GOTO	D10US_START
	RETURN

;********************************************************************************

DELAY_MS:
	INCF	SYSWAITTEMPMS_H, F
DMS_START:
	MOVLW	14
	MOVWF	DELAYTEMP2
DMS_OUTER:
	MOVLW	189
	MOVWF	DELAYTEMP
DMS_INNER:
	DECFSZ	DELAYTEMP, F
	GOTO	DMS_INNER
	DECFSZ	DELAYTEMP2, F
	GOTO	DMS_OUTER
	DECFSZ	SYSWAITTEMPMS, F
	GOTO	DMS_START
	DECFSZ	SYSWAITTEMPMS_H, F
	GOTO	DMS_START
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: STRING:BYTE:, SOURCE: USART.H (1382)
HSERPRINT294:
;PrintLen = PrintData(0)
	MOVF	SYSPRINTDATAHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSPRINTDATAHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	PRINTLEN
;If PrintLen <> 0 then
	MOVF	PRINTLEN,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF17
;Write Data
;for SysPrintTemp = 1 to PrintLen
	CLRF	SYSPRINTTEMP
	MOVLW	1
	SUBWF	PRINTLEN,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOPEND2
SYSFORLOOP2:
	INCF	SYSPRINTTEMP,F
;HSerSend(PrintData(SysPrintTemp),comport )
	MOVF	SYSPRINTTEMP,W
	ADDWF	SYSPRINTDATAHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSPRINTDATAHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SERDATA
	CALL	HSERSEND284
;next
	MOVF	PRINTLEN,W
	SUBWF	SYSPRINTTEMP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP2
SYSFORLOOPEND2:
;End If
ENDIF17:
;CR
	RETURN

;********************************************************************************

;SOURCE: USART.H (1538)
HSERPRINTCRLF:
;repeat HSerPrintCRLFCount
	MOVF	HSERPRINTCRLFCOUNT,W
	MOVWF	SYSREPEATTEMP2
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	GOTO	SYSREPEATLOOPEND2
SYSREPEATLOOP2:
;HSerSend(13,comport)
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND284
;HSerSend(10,comport)
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND284
;end Repeat
	DECFSZ	SYSREPEATTEMP2,F
	GOTO	SYSREPEATLOOP2
SYSREPEATLOOPEND2:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (848)
HSERSEND284:
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (129)
INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	MOVLW	96
BANKSEL	OSCCON1
MOVWF	OSCCON1
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
CLRF	OSCCON3
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
CLRF	OSCEN
;Default value
;OSCTUNE = 0x00
CLRF	OSCTUNE
;asm showdebug The MCU is a chip family ChipFamily
;asm showdebug OSCCON type is 102
;Set OSCFRQ values for MCUs with OSCSTAT... the 16F18855 MCU family
;OSCFRQ = 0b00000110
	MOVLW	6
MOVWF	OSCFRQ
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
BANKSEL	ADCON0
;B7: ASM Source was:  BCF ADCON0,ADFRM0
	BCF	ADCON0,2
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
;B7: ASM Source was:  BCF ADCON0,ADON
	BCF	ADCON0,7
;ANSELA = 0
BANKSEL	ANSELA
CLRF	ANSELA
;ANSELB = 0
CLRF	ANSELB
;ANSELC = 0
CLRF	ANSELC
;Set comparator register bits for many MCUs with register CM2CON0
;C2ON = 0
BANKSEL	CM2CON0
;B7: ASM Source was:  BCF CM2CON0,C2ON
	BCF	CM2CON0,7
;C1ON = 0
;B7: ASM Source was:  BCF CM1CON0,C1ON
	BCF	CM1CON0,7
;
;'Turn off all ports
;PORTA = 0
BANKSEL	PORTA
CLRF	PORTA
;PORTB = 0
CLRF	PORTB
;PORTC = 0
CLRF	PORTC
;PORTE = 0
CLRF	PORTE
	RETURN

;********************************************************************************

;SOURCE: USART.H (539)
INITUSART:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (2002)
FN_READAD107:
;Always RIGHT justified
;SET ADFM ON
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,ADFRM0
	BSF	ADCON0,2
;ADPCH = ADReadPort
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,W
BANKSEL	ADPCH
MOVWF	ADPCH
;Do conversion
;LLReadAD 0
;Macro Source: a-d.h (371)
;***  'Special section for 16F1688x Chips ***
;'Configure ANSELA/B/C/D
;Select Case ADReadPort 'Configure ANSELA/B/C/D @DebugADC_H
;Case 0: Set ANSELA.0 On
SYSSELECT1CASE1:
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE2
BANKSEL	ANSELA
	BSF	ANSELA,0
;Case 1: Set ANSELA.1 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE2:
	DECF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE3
BANKSEL	ANSELA
	BSF	ANSELA,1
;Case 2: Set ANSELA.2 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE3:
	MOVLW	2
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE4
BANKSEL	ANSELA
	BSF	ANSELA,2
;Case 3: Set ANSELA.3 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE4:
	MOVLW	3
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE5
BANKSEL	ANSELA
	BSF	ANSELA,3
;Case 4: Set ANSELA.4 ON
	GOTO	SYSSELECTEND1
SYSSELECT1CASE5:
	MOVLW	4
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE6
BANKSEL	ANSELA
	BSF	ANSELA,4
;Case 5: Set ANSELA.5 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE6:
	MOVLW	5
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE7
BANKSEL	ANSELA
	BSF	ANSELA,5
;Case 6: Set ANSELA.6 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE7:
	MOVLW	6
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE8
BANKSEL	ANSELA
	BSF	ANSELA,6
;Case 7: Set ANSELA.7 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE8:
	MOVLW	7
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE9
BANKSEL	ANSELA
	BSF	ANSELA,7
;Case 8: Set ANSELB.0 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE9:
	MOVLW	8
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE10
BANKSEL	ANSELB
	BSF	ANSELB,0
;Case 9: Set ANSELB.1 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE10:
	MOVLW	9
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE11
BANKSEL	ANSELB
	BSF	ANSELB,1
;Case 10: Set ANSELB.2 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE11:
	MOVLW	10
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE12
BANKSEL	ANSELB
	BSF	ANSELB,2
;Case 11: Set ANSELB.3 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE12:
	MOVLW	11
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE13
BANKSEL	ANSELB
	BSF	ANSELB,3
;Case 12: Set ANSELB.4 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE13:
	MOVLW	12
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE14
BANKSEL	ANSELB
	BSF	ANSELB,4
;Case 13: Set ANSELB.5 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE14:
	MOVLW	13
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE15
BANKSEL	ANSELB
	BSF	ANSELB,5
;Case 14: Set ANSELB.6 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE15:
	MOVLW	14
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE16
BANKSEL	ANSELB
	BSF	ANSELB,6
;Case 15: Set ANSELB.7 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE16:
	MOVLW	15
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE17
BANKSEL	ANSELB
	BSF	ANSELB,7
;Case 16: Set ANSELC.0 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE17:
	MOVLW	16
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE18
BANKSEL	ANSELC
	BSF	ANSELC,0
;Case 17: Set ANSELC.1 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE18:
	MOVLW	17
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE19
BANKSEL	ANSELC
	BSF	ANSELC,1
;Case 18: Set ANSELC.2 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE19:
	MOVLW	18
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE20
BANKSEL	ANSELC
	BSF	ANSELC,2
;Case 19: Set ANSELC.3 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE20:
	MOVLW	19
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE21
BANKSEL	ANSELC
	BSF	ANSELC,3
;Case 20: Set ANSELC.4 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE21:
	MOVLW	20
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE22
BANKSEL	ANSELC
	BSF	ANSELC,4
;Case 21: Set ANSELC.5 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE22:
	MOVLW	21
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE23
BANKSEL	ANSELC
	BSF	ANSELC,5
;Case 22: Set ANSELC.6 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE23:
	MOVLW	22
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE24
BANKSEL	ANSELC
	BSF	ANSELC,6
;Case 23: Set ANSELC.7 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE24:
	MOVLW	23
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND1
BANKSEL	ANSELC
	BSF	ANSELC,7
;End Select  '*** ANSEL Bits should now be set ***
SYSSELECTEND1:
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
BANKSEL	ADCON0
;B7: ASM Source was:  BCF ADCON0,ADCS
	BCF	ADCON0,4
;ADCLK = 1 ' default to FOSC/2
	MOVLW	1
MOVWF	ADCLK
;Conversion Clock Speed
;SET ADCS OFF  'ADCON0.4
;B7: ASM Source was:  BCF ADCON0,ADCS
	BCF	ADCON0,4
;ADCLK = 15    'FOSC/16
	MOVLW	15
MOVWF	ADCLK
;Result formatting
;if ADLeftadjust = 0 then  '10-bit
;Set ADCON0.2 ON
;Set ADFM ON
;B7: ASM Source was:  BSF ADCON0,ADFRM0
	BSF	ADCON0,2
;Set ADFM0 ON
;B7: ASM Source was:  BSF ADCON0,ADFM0
	BSF	ADCON0,2
;Else
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,W
BANKSEL	ADPCH
MOVWF	ADPCH
;Enable A/D
;SET ADON ON
;B7: ASM Source was:  BSF ADCON0,ADON
	BSF	ADCON0,7
;Acquisition Delay
;Wait AD_Delay
	MOVLW	2
	MOVWF	SYSWAITTEMP10US
BANKSEL	STATUS
	CALL	DELAY_10US
;Read A/D
;SET GO_NOT_DONE ON
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,GO_NOT_DONE
	BSF	ADCON0,0
;nop
	NOP
;Wait While GO_NOT_DONE ON
SYSWAITLOOP1:
;B7: ASM Source was:  BTFSC ADCON0,GO_NOT_DONE
	BTFSC	ADCON0,0
	GOTO	SYSWAITLOOP1
;Switch off A/D
;SET ADCON0.ADON OFF
;B7: ASM Source was:  BCF ADCON0,ADON
	BCF	ADCON0,7
;ANSELA = 0
BANKSEL	ANSELA
CLRF	ANSELA
;ANSELB = 0
CLRF	ANSELB
;ANSELC = 0
CLRF	ANSELC
;Write output
;ReadAD10 = ADRESL
BANKSEL	ADRESL
	MOVF	ADRESL,W
	BANKSEL	READAD10
	MOVWF	READAD10
	CLRF	READAD10_H
;ReadAD10_H = ADRESH
BANKSEL	ADRESH
	MOVF	ADRESH,W
	BANKSEL	READAD10_H
	MOVWF	READAD10_H
;Put A/D format back to normal
;SET ADFM OFF
BANKSEL	ADCON0
;B7: ASM Source was:  BCF ADCON0,ADFRM0
	BCF	ADCON0,2
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: STRING.H (373)
FN_RIGHT:
;Empty input?
;If SysInString(0) = 0 Then
	MOVF	SYSSYSINSTRINGHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF12
;Right(0) = 0
	BANKSEL	SYSRIGHT_0
	CLRF	SYSRIGHT_0
;Exit Function
BANKSEL	STATUS
	RETURN
;End If
ENDIF12:
;Input length too high?
;If SysInString(0) < SysCharCount Then
	MOVF	SYSSYSINSTRINGHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	SYSCHARCOUNT,W
	SUBWF	INDF0,W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF13
;SysCharCount = SysInString(0)
	MOVF	SYSSYSINSTRINGHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SYSCHARCOUNT
;End If
ENDIF13:
;Copy rightmost characters
;SysCharStart = SysInString(0) - SysCharCount
	MOVF	SYSSYSINSTRINGHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	SYSCHARCOUNT,W
	SUBWF	INDF0,W
	MOVWF	SYSCHARSTART
;For SysStringTemp = 1 To SysCharCount
	CLRF	SYSSTRINGTEMP
	MOVLW	1
	SUBWF	SYSCHARCOUNT,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOPEND1
SYSFORLOOP1:
	INCF	SYSSTRINGTEMP,F
;Right(SysStringTemp) = SysInString(SysCharStart + SysStringTemp)
	MOVF	SYSSTRINGTEMP,W
	ADDWF	SYSCHARSTART,W
	MOVWF	SYSTEMP2
	ADDWF	SYSSYSINSTRINGHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSSYSINSTRINGHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SYSARRAYTEMP2
	MOVWF	SYSARRAYTEMP1
	MOVLW	LOW(RIGHT)
	ADDWF	SYSSTRINGTEMP,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	CLRF	SYSTEMP2
	MOVLW	HIGH(RIGHT)
	ADDWFC	SYSTEMP2,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	SYSARRAYTEMP1,W
MOVWF	INDF0
;Next
	MOVF	SYSCHARCOUNT,W
	SUBWF	SYSSTRINGTEMP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP1
SYSFORLOOPEND1:
;Right(0) = SysCharCount
	MOVF	SYSCHARCOUNT,W
	BANKSEL	SYSRIGHT_0
	MOVWF	SYSRIGHT_0
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2894)
SYSCOMPEQUAL16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	MOVF	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	SUBWF	SYSWORDTEMPB, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test high, exit if false
;movf SysWordTempA_H, W
	MOVF	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	SUBWF	SYSWORDTEMPB_H, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (1276)
SYSCOPYSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length
;movf INDF0, W
	MOVF	INDF0, W
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;movwf INDF1
MOVWF	INDF1
;goto SysCopyStringCheck
	GOTO	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART:
;movf INDF0, W
	MOVF	INDF0, W
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;addwf SysStringLength, F
	ADDWF	SYSSTRINGLENGTH, F
SYSCOPYSTRINGCHECK:
;Exit if length = 0
;movf SysCalcTempA,F
	MOVF	SYSCALCTEMPA,F
;btfsc STATUS,Z
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
;return
	RETURN
SYSSTRINGCOPY:
;Increment pointers
;addfsr 0, 1
	ADDFSR	0, 1
;addfsr 1, 1
	ADDFSR	1, 1
;Copy character
;movf INDF0, W
	MOVF	INDF0, W
;movwf INDF1
MOVWF	INDF1
;decfsz SysCalcTempA, F
	DECFSZ	SYSCALCTEMPA, F
;goto SysStringCopy
	GOTO	SYSSTRINGCOPY
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2644)
SYSDIVSUB:
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	MOVF	SYSBYTETEMPB, F
;btfsc STATUS, Z
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
;return
	RETURN
;Main calc routine
;SysByteTempX = 0
	CLRF	SYSBYTETEMPX
;SysDivLoop = 8
	MOVLW	8
	MOVWF	SYSDIVLOOP
SYSDIV8START:
;bcf STATUS, C
;B7: ASM Source was:  BCF STATUS, C
	BCF	STATUS,0
;rlf SysByteTempA, F
	RLF	SYSBYTETEMPA, F
;rlf SysByteTempX, F
	RLF	SYSBYTETEMPX, F
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W
;subwf SysByteTempX, F
	SUBWF	SYSBYTETEMPX, F
;bsf SysByteTempA, 0
	BSF	SYSBYTETEMPA, 0
;btfsc STATUS, C
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
;goto Div8NotNeg
	GOTO	DIV8NOTNEG
;bcf SysByteTempA, 0
	BCF	SYSBYTETEMPA, 0
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W
;addwf SysByteTempX, F
	ADDWF	SYSBYTETEMPX, F
DIV8NOTNEG:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv8Start
	GOTO	SYSDIV8START
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2712)
SYSDIVSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	MOVF	SYSWORDTEMPA,W
	MOVWF	SYSDIVMULTA
	MOVF	SYSWORDTEMPA_H,W
	MOVWF	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	MOVF	SYSWORDTEMPB,W
	MOVWF	SYSDIVMULTB
	MOVF	SYSWORDTEMPB_H,W
	MOVWF	SYSDIVMULTB_H
;SysDivMultX = 0
	CLRF	SYSDIVMULTX
	CLRF	SYSDIVMULTX_H
;Avoid division by zero
;if SysDivMultB = 0 then
	MOVF	SYSDIVMULTB,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSDIVMULTB_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF10
;SysWordTempA = 0
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
;exit sub
	RETURN
;end if
ENDIF10:
;Main calc routine
;SysDivLoop = 16
	MOVLW	16
	MOVWF	SYSDIVLOOP
SYSDIV16START:
;set C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate SysDivMultA Left
	RLF	SYSDIVMULTA,F
	RLF	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	RLF	SYSDIVMULTX,F
	RLF	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	MOVF	SYSDIVMULTB,W
	SUBWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	SUBWFB	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	BSF	SYSDIVMULTA,0
;If C Off Then
;B7: ASM Source was:  BTFSC STATUS,C
	BTFSC	STATUS,0
	GOTO	ENDIF11
;Set SysDivMultA.0 Off
	BCF	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	MOVF	SYSDIVMULTB,W
	ADDWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	ADDWFC	SYSDIVMULTX_H,F
;End If
ENDIF11:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv16Start
	GOTO	SYSDIV16START
;SysWordTempA = SysDivMultA
	MOVF	SYSDIVMULTA,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSDIVMULTA_H,W
	MOVWF	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	MOVF	SYSDIVMULTX,W
	MOVWF	SYSWORDTEMPX
	MOVF	SYSDIVMULTX_H,W
	MOVWF	SYSWORDTEMPX_H
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (1473)
SYSREADSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;call SysStringTables
	CALL	SYSSTRINGTABLES
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;movwf INDF1
MOVWF	INDF1
;goto SysStringReadCheck
	GOTO	SYSSTRINGREADCHECK
SYSREADSTRINGPART:
;Get length
;call SysStringTables
	CALL	SYSSTRINGTABLES
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;addwf SysStringLength,F
	ADDWF	SYSSTRINGLENGTH,F
;Check length
SYSSTRINGREADCHECK:
;If length is 0, exit
;movf SysCalcTempA,F
	MOVF	SYSCALCTEMPA,F
;btfsc STATUS,Z
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
;return
	RETURN
;Copy
SYSSTRINGREAD:
;Get char
;call SysStringTables
	CALL	SYSSTRINGTABLES
;Set char
;addfsr 1,1
	ADDFSR	1,1
;movwf INDF1
MOVWF	INDF1
;decfsz SysCalcTempA, F
	DECFSZ	SYSCALCTEMPA, F
;goto SysStringRead
	GOTO	SYSSTRINGREAD
	RETURN

;********************************************************************************

SYSSTRINGTABLES:
	MOVF	SYSSTRINGA_H,W
MOVWF	PCLATH
	MOVF	SYSSTRINGA,W
	INCF	SYSSTRINGA,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SYSSTRINGA_H,F
MOVWF	PCL

STRINGTABLE1:
	RETLW	3
	RETLW	62	;>
	RETLW	62	;>
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE2:
	RETLW	3
	RETLW	60	;<
	RETLW	60	;<
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE34:
	RETLW	0

	ALIGN	2;X3

STRINGTABLE35:
	RETLW	1
	RETLW	49	;1

	ALIGN	2;X3

STRINGTABLE36:
	RETLW	1
	RETLW	48	;0

	ALIGN	2;X3

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 1
	ORG	2048
;START OF PROGRAM MEMORY PAGE 2
	ORG	4096
;START OF PROGRAM MEMORY PAGE 3
	ORG	6144
	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
