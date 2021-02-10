;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\09_reversible_leds_with_variable_delay_to_serial_terminal.S"
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
 ADN_PORT                         EQU 32                    ; 0X20
 ADREADPORT                       EQU 33                    ; 0X21
 BYTENUM                          EQU 34                    ; 0X22
 BYTETOBIN                        EQU 9150                    ; 0X23BE
 CHECK_SWITCH                     EQU 35                    ; 0X23
 COMPORT                          EQU 36                    ; 0X24
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 DIRECTION                        EQU 37                    ; 0X25
 HSERPRINTCRLFCOUNT               EQU 38                    ; 0X26
 LEDS                             EQU 39                    ; 0X27
 MYDELAY                          EQU 40                    ; 0X28
 MYDELAY_H                        EQU 41                    ; 0X29
 OUTVALUETEMP                     EQU 42                    ; 0X2A
 PRINTLEN                         EQU 43                    ; 0X2B
 READAD                           EQU 44                    ; 0X2C
 READAD10                         EQU 46                    ; 0X2E
 READAD10_H                       EQU 47                    ; 0X2F
 READAD_H                         EQU 45                    ; 0X2D
 RIGHT                            EQU 9159                    ; 0X23C7
 SERDATA                          EQU 48                    ; 0X30
 SERPRINTVAL                      EQU 49                    ; 0X31
 SERPRINTVAL_H                    EQU 50                    ; 0X32
 STRINGPOINTER                    EQU 51                    ; 0X33
 SYSARRAYTEMP1                    EQU 52                    ; 0X34
 SYSARRAYTEMP2                    EQU 53                    ; 0X35
 SYSBITVAR0                       EQU 54                    ; 0X36
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSCALCTEMPA                     EQU 117                    ; 0X75
 SYSCALCTEMPX                     EQU 112                    ; 0X70
 SYSCALCTEMPX_H                   EQU 113                    ; 0X71
 SYSCHARCOUNT                     EQU 55                    ; 0X37
 SYSCHARSTART                     EQU 56                    ; 0X38
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSDIVMULTA                      EQU 119                    ; 0X77
 SYSDIVMULTA_H                    EQU 120                    ; 0X78
 SYSDIVMULTB                      EQU 123                    ; 0X7B
 SYSDIVMULTB_H                    EQU 124                    ; 0X7C
 SYSDIVMULTX                      EQU 114                    ; 0X72
 SYSDIVMULTX_H                    EQU 115                    ; 0X73
 SYSPRINTDATAHANDLER              EQU 57                    ; 0X39
 SYSPRINTDATAHANDLER_H            EQU 58                    ; 0X3A
 SYSPRINTTEMP                     EQU 59                    ; 0X3B
 SYSREPEATTEMP1                   EQU 60                    ; 0X3C
 SYSREPEATTEMP2                   EQU 61                    ; 0X3D
 SYSSTRINGA                       EQU 119                    ; 0X77
 SYSSTRINGA_H                     EQU 120                    ; 0X78
 SYSSTRINGLENGTH                  EQU 118                    ; 0X76
 SYSSTRINGTEMP                    EQU 62                    ; 0X3E
 SYSSYSINSTRINGHANDLER            EQU 63                    ; 0X3F
 SYSSYSINSTRINGHANDLER_H          EQU 64                    ; 0X40
 SYSTEMP1                         EQU 65                    ; 0X41
 SYSTEMP1_H                       EQU 66                    ; 0X42
 SYSTEMP2                         EQU 67                    ; 0X43
 SYSTEMP3                         EQU 68                    ; 0X44
 SYSWAITTEMP10US                  EQU 117                    ; 0X75
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 SYSWAITTEMPS                     EQU 116                    ; 0X74
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
 SYSREADAD10WORD                  EQU 46
 SYSREADAD10WORD_H                EQU 47
 SYSREADADBYTE                    EQU 44
 SYSREADADINTEGER                 EQU 44
 SYSREADADINTEGER_H               EQU 45
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
	CALL	INITPPS
	CALL	INITUSART

;START OF THE MAIN PROGRAM
;''
;''  This demonstration produces a variable speed rotating LED display that is proportional to the ADC value.
;''  The ADC value and LED rotate speed are inversely proportional to each other.
;''
;''  Rotate the POT counterclockwise to see the LEDs shift faster, press the switch to reverse the direction of the LEDs.
;''
;''  An attached Serial Terminal will show the state of the LEDs and the direction of the rotation.
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
;''  Date: 19.10.2016
;''
;----- Configuration
;Set the PPS of the PWM and the RS232 ports.
;Set the PPS for this solution.
;#DEFINE USART_BAUD_RATE 19200
;#DEFINE USART_TX_BLOCKING
;#DEFINE SWITCH_DOWN         0
;#DEFINE SWITCH_UP           1
;#DEFINE LED_RIGHT           TRUE
;#DEFINE LED_LEFT            FALSE
;#DEFINE SWITCH      PORTA.5
;Dim leds  As Byte
;Dim DIRECTION As Byte
;Dim mydelay As Word
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
;Dir portb.0 Out
	BCF	TRISB,0
;setup switch (SW1)
;Dir SWITCH In
	BSF	TRISA,5
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "Great Cow Basic @2016": HSerPrintCRLF
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT295
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "Xpress Demo Board": HSerPrintCRLF
	MOVLW	LOW STRINGTABLE2
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE2) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT295
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "03 Rotate": HSerPrintCRLF 3
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT295
	MOVLW	3
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;Wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;Do
SYSDOLOOP_S1:
;Show BYTE read of ADC just passing the Analog address - you will get an incorrect response as this is a 10bit ADC
;mydelay = ReadAD ( AN4  )
	MOVLW	4
	MOVWF	ADREADPORT
	CALL	FN_READAD6
	MOVF	SYSREADADBYTE,W
	MOVWF	MYDELAY
	CLRF	MYDELAY_H
;HSerPrint "P: "
	MOVLW	LOW STRINGTABLE4
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE4) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT295
;HSerPrint mydelay
	MOVF	MYDELAY,W
	MOVWF	SERPRINTVAL
	MOVF	MYDELAY_H,W
	MOVWF	SERPRINTVAL_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT297
;HSerSend 9
	MOVLW	9
	MOVWF	SERDATA
	CALL	HSERSEND284
;Show BYTE read of ADC by using the 2nd parameter to force a byte response
;mydelay = ReadAD ( AN4, TRUE )
	MOVLW	4
	MOVWF	ADREADPORT
	MOVLW	255
	MOVWF	ADN_PORT
	CALL	FN_READAD7
	MOVF	SYSREADADINTEGER,W
	MOVWF	MYDELAY
	MOVF	SYSREADADINTEGER_H,W
	MOVWF	MYDELAY_H
;HSerPrint "P: "
	MOVLW	LOW STRINGTABLE4
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE4) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT295
;HSerPrint mydelay
	MOVF	MYDELAY,W
	MOVWF	SERPRINTVAL
	MOVF	MYDELAY_H,W
	MOVWF	SERPRINTVAL_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT297
;HSerSend 9
	MOVLW	9
	MOVWF	SERDATA
	CALL	HSERSEND284
;Show WORD read of ADC by using the 2nd parameter
;mydelay = ReadAD10 ( AN4 )
	MOVLW	4
	MOVWF	ADREADPORT
	CALL	FN_READAD108
	MOVF	SYSREADAD10WORD,W
	MOVWF	MYDELAY
	MOVF	SYSREADAD10WORD_H,W
	MOVWF	MYDELAY_H
;HSerPrint "P: "
	MOVLW	LOW STRINGTABLE4
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE4) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT295
;HSerPrint mydelay
	MOVF	MYDELAY,W
	MOVWF	SERPRINTVAL
	MOVF	MYDELAY_H,W
	MOVWF	SERPRINTVAL_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT297
;HSerSend 9
	MOVLW	9
	MOVWF	SERDATA
	CALL	HSERSEND284
;Factor the ADC reading to delay steps
;mydelay = mydelay / 16
	MOVF	MYDELAY,W
	MOVWF	SYSWORDTEMPA
	MOVF	MYDELAY_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	16
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	MOVWF	MYDELAY
	MOVF	SYSWORDTEMPA_H,W
	MOVWF	MYDELAY_H
;decrement the 8 MSbs of the ADC and delay 20ms for each
;Do While ( mydelay <> 0 )
SYSDOLOOP_S2:
	MOVF	MYDELAY,W
	MOVWF	SYSWORDTEMPA
	MOVF	MYDELAY_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	SYSDOLOOP_E2
;mydelay--
	MOVLW	1
	SUBWF	MYDELAY,F
	MOVLW	0
	SUBWFB	MYDELAY_H,F
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
	MOVLW	LOW STRINGTABLE5
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE5) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT295
;Else
	GOTO	ENDIF2
ELSE2_1:
;HSerPrint "<< "
	MOVLW	LOW STRINGTABLE6
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE6) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT295
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
	CALL	HSERPRINT295
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
;'' GCB Optimisation file
;Optmise PWM.h
;#DEFINE USE_HPWMCCP1 TRUE
;#DEFINE USE_HPWMCCP2 TRUE
;#DEFINE USE_HPWMCCP3 TRUE
;#DEFINE USE_HPWMCCP4 TRUE
;#DEFINE USE_HPWM6 TRUE
;#DEFINE USE_HPWM7 TRUE
;#DEFINE USE_HPWM_TIMER2 TRUE
;#DEFINE USE_HPWM_TIMER4 TRUE
;#DEFINE USE_HPWM_TIMER6 TRUE
;Optimise A-d.h
;Standard family chips
;#DEFINE USE_AD0 FALSE
;#DEFINE USE_AD1 FALSE
;#DEFINE USE_AD2 FALSE
;#DEFINE USE_AD2 FALSE
;#DEFINE USE_AD3 FALSE
;#DEFINE USE_AD4 TRUE
;#DEFINE USE_AD5 FALSE
;#DEFINE USE_AD6 FALSE
;#DEFINE USE_AD7 FALSE
;#DEFINE USE_AD8 FALSE
;#DEFINE USE_AD9 FALSE
;#DEFINE USE_AD10 FALSE
;#DEFINE USE_AD11 FALSE
;#DEFINE USE_AD12 FALSE
;#DEFINE USE_AD13 FALSE
;#DEFINE USE_AD14 FALSE
;#DEFINE USE_AD15 FALSE
;#DEFINE USE_AD16 FALSE
;#DEFINE USE_AD17 FALSE
;#DEFINE USE_AD18 FALSE
;#DEFINE USE_AD19 FALSE
;#DEFINE USE_AD20 FALSE
;#DEFINE USE_AD21 FALSE
;#DEFINE USE_AD22 FALSE
;#DEFINE USE_AD23 FALSE
;#DEFINE USE_AD24 FALSE
;#DEFINE USE_AD25 FALSE
;#DEFINE USE_AD26 FALSE
;#DEFINE USE_AD27 FALSE
;#DEFINE USE_AD28 FALSE
;#DEFINE USE_AD29 FALSE
;#DEFINE USE_AD30 FALSE
;#DEFINE USE_AD31 FALSE
;#DEFINE USE_AD32 FALSE
;#DEFINE USE_AD33 FALSE
;#DEFINE USE_AD34 FALSE
;Family of chips based on 16f1688x with ADCON3 register
;#DEFINE USE_ADA0 FALSE
;#DEFINE USE_ADA1 FALSE
;#DEFINE USE_ADA2 FALSE
;#DEFINE USE_ADA3 FALSE
;#DEFINE USE_ADA4 TRUE
;#DEFINE USE_ADA5 FALSE
;#DEFINE USE_ADA6 FALSE
;#DEFINE USE_ADA7 FALSE
;#DEFINE USE_ADB0 FALSE
;#DEFINE USE_ADB1 FALSE
;#DEFINE USE_ADB2 FALSE
;#DEFINE USE_ADB3 FALSE
;#DEFINE USE_ADB4 FALSE
;#DEFINE USE_ADB5 FALSE
;#DEFINE USE_ADB6 FALSE
;#DEFINE USE_ADB7 FALSE
;#DEFINE USE_ADC0 FALSE
;#DEFINE USE_ADC1 FALSE
;#DEFINE USE_ADC2 FALSE
;#DEFINE USE_ADC3 FALSE
;#DEFINE USE_ADC4 FALSE
;#DEFINE USE_ADC5 FALSE
;#DEFINE USE_ADC6 FALSE
;#DEFINE USE_ADC7 FALSE
;#DEFINE USE_ADD0 FALSE
;#DEFINE USE_ADD1 FALSE
;#DEFINE USE_ADD2 FALSE
;#DEFINE USE_ADD3 FALSE
;#DEFINE USE_ADD4 FALSE
;#DEFINE USE_ADD5 FALSE
;#DEFINE USE_ADD6 FALSE
;#DEFINE USE_ADD7 FALSE
;#DEFINE USE_ADE0 FALSE
;#DEFINE USE_ADE1 FALSE
;#DEFINE USE_ADE2 FALSE
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
	MOVLW	LOW STRINGTABLE38
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE38) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRING
;Repeat 8
	MOVLW	8
	MOVWF	SYSREPEATTEMP1
SYSREPEATLOOP1:
;If ByteNum.7 = 1 Then
	BTFSS	BYTENUM,7
	GOTO	ELSE22_1
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
	MOVLW	LOW STRINGTABLE39
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE39) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRINGPART
	MOVLW	LOW BYTETOBIN
MOVWF	FSR0L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR0H
	MOVF	SYSSTRINGLENGTH,W
MOVWF	INDF0
;Else
	GOTO	ENDIF22
ELSE22_1:
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
	MOVLW	LOW STRINGTABLE40
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE40) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRINGPART
	MOVLW	LOW BYTETOBIN
MOVWF	FSR0L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR0H
	MOVF	SYSSTRINGLENGTH,W
MOVWF	INDF0
;End If
ENDIF22:
;Rotate ByteNum Left
	RLF	BYTENUM,F
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
	RETURN

;********************************************************************************

;SOURCE: 09_REVERSIBLE_LEDS_WITH_VARIABLE_DELAY_TO_SERIAL_TERMINAL.GCB (151)
FN_CHECK_SWITCH:
;switch is normally open to 5V ...when pressed, RA3 is connected to GND
;If (SWITCH = SWITCH_DOWN) Then
	BTFSC	PORTA,5
	GOTO	ELSE9_1
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
	GOTO	ELSE10_1
;don't toggle
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;Else
	GOTO	ENDIF10
ELSE10_1:
;check if still down
;If (SWITCH = SWITCH_DOWN) Then
	BTFSC	PORTA,5
	GOTO	ELSE11_1
;previous_state = SWITCH_DOWN
	BCF	SYSBITVAR0,0
;reverse the LEDs
;check_switch = TRUE
	MOVLW	255
	MOVWF	CHECK_SWITCH
;Exit Function
	RETURN
;Else
	GOTO	ENDIF11
ELSE11_1:
;switch not properly held down
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0
;don't reverse
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;End If
ENDIF11:
;End If
ENDIF10:
;Else
	GOTO	ENDIF9
ELSE9_1:
;switch not pressed
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0
;don't reverse
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;End If
ENDIF9:
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

DELAY_S:
DS_START:
	MOVLW	232
	MOVWF	SYSWAITTEMPMS
	MOVLW	3
	MOVWF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
	DECFSZ	SYSWAITTEMPS, F
	GOTO	DS_START
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: STRING:BYTE:, SOURCE: USART.H (1382)
HSERPRINT295:
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
	GOTO	ENDIF23
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
	CALL	HSERSEND285
;next
	MOVF	PRINTLEN,W
	SUBWF	SYSPRINTTEMP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP2
SYSFORLOOPEND2:
;End If
ENDIF23:
;CR
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: WORD:BYTE:, SOURCE: USART.H (1434)
HSERPRINT297:
;Dim SysCalcTempX As Word
;OutValueTemp = 0
	CLRF	OUTVALUETEMP
;If SerPrintVal >= 10000 then
	MOVF	SERPRINTVAL,W
	MOVWF	SYSWORDTEMPA
	MOVF	SERPRINTVAL_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	16
	MOVWF	SYSWORDTEMPB
	MOVLW	39
	MOVWF	SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF26
;OutValueTemp = SerPrintVal / 10000 [word]
	MOVF	SERPRINTVAL,W
	MOVWF	SYSWORDTEMPA
	MOVF	SERPRINTVAL_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	16
	MOVWF	SYSWORDTEMPB
	MOVLW	39
	MOVWF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	MOVWF	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SERPRINTVAL
	MOVF	SYSCALCTEMPX_H,W
	MOVWF	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	MOVLW	48
	ADDWF	OUTVALUETEMP,W
	MOVWF	SERDATA
	CALL	HSERSEND285
;Goto HSerPrintWord1000
	GOTO	HSERPRINTWORD1000
;End If
ENDIF26:
;If SerPrintVal >= 1000 then
	MOVF	SERPRINTVAL,W
	MOVWF	SYSWORDTEMPA
	MOVF	SERPRINTVAL_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	232
	MOVWF	SYSWORDTEMPB
	MOVLW	3
	MOVWF	SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF27
HSERPRINTWORD1000:
;OutValueTemp = SerPrintVal / 1000 [word]
	MOVF	SERPRINTVAL,W
	MOVWF	SYSWORDTEMPA
	MOVF	SERPRINTVAL_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	232
	MOVWF	SYSWORDTEMPB
	MOVLW	3
	MOVWF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	MOVWF	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SERPRINTVAL
	MOVF	SYSCALCTEMPX_H,W
	MOVWF	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport  )
	MOVLW	48
	ADDWF	OUTVALUETEMP,W
	MOVWF	SERDATA
	CALL	HSERSEND285
;Goto HSerPrintWord100
	GOTO	HSERPRINTWORD100
;End If
ENDIF27:
;If SerPrintVal >= 100 then
	MOVF	SERPRINTVAL,W
	MOVWF	SYSWORDTEMPA
	MOVF	SERPRINTVAL_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	100
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF28
HSERPRINTWORD100:
;OutValueTemp = SerPrintVal / 100 [word]
	MOVF	SERPRINTVAL,W
	MOVWF	SYSWORDTEMPA
	MOVF	SERPRINTVAL_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	100
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	MOVWF	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SERPRINTVAL
	MOVF	SYSCALCTEMPX_H,W
	MOVWF	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	MOVLW	48
	ADDWF	OUTVALUETEMP,W
	MOVWF	SERDATA
	CALL	HSERSEND285
;Goto HSerPrintWord10
	GOTO	HSERPRINTWORD10
;End If
ENDIF28:
;If SerPrintVal >= 10 then
	MOVF	SERPRINTVAL,W
	MOVWF	SYSWORDTEMPA
	MOVF	SERPRINTVAL_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	10
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF29
HSERPRINTWORD10:
;OutValueTemp = SerPrintVal / 10 [word]
	MOVF	SERPRINTVAL,W
	MOVWF	SYSWORDTEMPA
	MOVF	SERPRINTVAL_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	10
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	MOVWF	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SERPRINTVAL
	MOVF	SYSCALCTEMPX_H,W
	MOVWF	SERPRINTVAL_H
;HSerSend(OutValueTemp + 48 ,comport )
	MOVLW	48
	ADDWF	OUTVALUETEMP,W
	MOVWF	SERDATA
	CALL	HSERSEND285
;End If
ENDIF29:
;HSerSend(SerPrintVal + 48 ,comport  )
	MOVLW	48
	ADDWF	SERPRINTVAL,W
	MOVWF	SERDATA
	CALL	HSERSEND284
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
	CALL	HSERSEND285
;HSerSend(10,comport)
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND285
;end Repeat
	DECFSZ	SYSREPEATTEMP2,F
	GOTO	SYSREPEATLOOP2
SYSREPEATLOOPEND2:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: USART.H (759)
HSERSEND284:
;Registers/Bits determined by #samevar at top of library
;USART_TX_BLOCKING
;Wait While TXIF = Off
SYSWAITLOOP4:
BANKSEL	PIR3
;B7: ASM Source was:  BTFSS PIR3,TXIF
	BTFSS	PIR3,4
	GOTO	SYSWAITLOOP4
;ensure any previous operation has completed
;Wait until TRMT = 1
SYSWAITLOOP5:
BANKSEL	TX1STA
;B7: ASM Source was:  BTFSS TX1STA,TRMT
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP5
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	BANKSEL	SERDATA
	MOVF	SERDATA,W
;B9: ASM Source was:  BANKSEL TXREG
BANKSEL	TX1REG
;B9: ASM Source was:  MOVWF TXREG
MOVWF	TX1REG
;Add USART_DELAY after the byte is sent by the USART module
;Wait USART_DELAY
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
BANKSEL	STATUS
	GOTO	DELAY_MS

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (848)
HSERSEND285:
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	DECF	COMPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF30
;USART_TX_BLOCKING
;Wait While TXIF = Off
SYSWAITLOOP6:
BANKSEL	PIR3
;B7: ASM Source was:  BTFSS PIR3,TXIF
	BTFSS	PIR3,4
	GOTO	SYSWAITLOOP6
;ensure any previous operation has completed
;Wait until TRMT = 1
SYSWAITLOOP7:
BANKSEL	TX1STA
;B7: ASM Source was:  BTFSS TX1STA,TRMT
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP7
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	BANKSEL	SERDATA
	MOVF	SERDATA,W
;B9: ASM Source was:  BANKSEL TXREG
BANKSEL	TX1REG
;B9: ASM Source was:  MOVWF TXREG
MOVWF	TX1REG
;Add USART_DELAY after the byte is sent by the USART module
;Wait USART_DELAY
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
BANKSEL	STATUS
	CALL	DELAY_MS
;end if
ENDIF30:
	RETURN

;********************************************************************************

;SOURCE: 09_REVERSIBLE_LEDS_WITH_VARIABLE_DELAY_TO_SERIAL_TERMINAL.GCB (29)
INITPPS:
;UNLOCKPPS
;Macro Source: stdbasic.h (78)
;dim IntState as bit
;IntState = GIE
	BCF	SYSBITVAR0,2
;B7: ASM Source was:  BTFSC INTCON,GIE
	BTFSC	INTCON,7
	BSF	SYSBITVAR0,2
;GIE = 0
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
;PPSLOCK = 0x55
	MOVLW	85
BANKSEL	PPSLOCK
MOVWF	PPSLOCK
;PPSLOCK = 0xAA
	MOVLW	170
MOVWF	PPSLOCK
;PPSLOCKED = 0x00  'unlock PPS
;B7: ASM Source was:  BCF PPSLOCK,PPSLOCKED
	BCF	PPSLOCK,0
;RC0->EUSART:TX;
;RC0PPS = 0x0010
	MOVLW	16
BANKSEL	RC0PPS
MOVWF	RC0PPS
;RC1->EUSART:RX;
;RXPPS  = 0x0011
	MOVLW	17
BANKSEL	RXPPS
MOVWF	RXPPS
;LOCKPPS
;Macro Source: stdbasic.h (89)
;PPSLOCK = 0x55
	MOVLW	85
MOVWF	PPSLOCK
;PPSLOCK = 0xAA
	MOVLW	170
MOVWF	PPSLOCK
;PPSLOCKED = 0x01  'lock PPS
;B7: ASM Source was:  BSF PPSLOCK,PPSLOCKED
	BSF	PPSLOCK,0
;GIE = IntState
	BANKSEL	SYSBITVAR0
	BTFSS	SYSBITVAR0,2
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
	BTFSC	SYSBITVAR0,2
;B7: ASM Source was:  BSF INTCON,GIE
	BSF	INTCON,7
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
;asm showdebug Values_calculated_in_the_script
;asm showdebug _SPBRGH_TEMP=_ SPBRGH_TEMP
;asm showdebug _SPBRGL_TEMP=_ SPBRGL_TEMP
;asm showdebug _BRG16_TEMP=_ BRG16_TEMP
;asm showdebug _BRGH_TEMP=_ BRGH_TEMP
;Set baud rate for legacy chips
;SPBRG = SPBRGL_TEMP
	MOVLW	159
;B9: ASM Source was:  BANKSEL SPBRG
BANKSEL	SP1BRGL
;B9: ASM Source was:  MOVWF SPBRG
MOVWF	SP1BRGL
;Set baud rate for chips with BRG16 bit
;SPBRGH = SPBRGH_TEMP
	MOVLW	1
MOVWF	SP1BRGH
;SPBRGL = SPBRGL_TEMP
	MOVLW	159
MOVWF	SP1BRGL
;BRG16: 16-bit Baud Rate Generator bit
;1 = 16-bit Baud Rate Generator is used
;0 = 8-bit Baud Rate Generator is used
;BRG16 = BRG16_TEMP
;B7: ASM Source was:  BSF BAUD1CON,BRG16
	BSF	BAUD1CON,3
;Set High Baud Rate Select bit
;BRGH = BRGH_TEMP
;B7: ASM Source was:  BSF TX1STA,BRGH
	BSF	TX1STA,2
;Enable async and TX mode for most non K42
;Set SYNC Off
;Set TXEN On
;Changed to canskip to silently exit when no USART
;[canskip]SYNC=0
;B7: ASM Source was:  BCF TX1STA,SYNC_TX1STA
	BCF	TX1STA,4
;[canskip]TXEN=1
;B7: ASM Source was:  BSF TX1STA,TXEN
	BSF	TX1STA,5
;SPEN=1
;B7: ASM Source was:  BSF RC1STA,SPEN
	BSF	RC1STA,7
;Enable TX and RX
;CREN=1
;B7: ASM Source was:  BSF RC1STA,CREN
	BSF	RC1STA,4
BANKSEL	STATUS
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (1740)
FN_READAD6:
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
BANKSEL	ADCON0
;B7: ASM Source was:  BCF ADCON0,ADFRM0
	BCF	ADCON0,2
;for 16F1885x and possibly future others
;ADPCH = ADReadPort
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,W
BANKSEL	ADPCH
MOVWF	ADPCH
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (371)
;***  'Special section for 16F1688x Chips ***
;'Configure ANSELA/B/C/D
;Select Case ADReadPort 'Configure ANSELA/B/C/D @DebugADC_H
;Case 4: Set ANSELA.4 ON
SYSSELECT1CASE1:
	MOVLW	4
	BANKSEL	ADREADPORT
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND1
BANKSEL	ANSELA
	BSF	ANSELA,4
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
;Set ADCON.2 off     '8-bit
;Set ADFM OFF
;B7: ASM Source was:  BCF ADCON0,ADFRM0
	BCF	ADCON0,2
;Set ADFM0 OFF
;B7: ASM Source was:  BCF ADCON0,ADFM0
	BCF	ADCON0,2
;End if
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
;ReadAD = ADRESH
BANKSEL	ADRESH
	MOVF	ADRESH,W
	BANKSEL	READAD
	MOVWF	READAD
;SET ADFM OFF
BANKSEL	ADCON0
;B7: ASM Source was:  BCF ADCON0,ADFRM0
	BCF	ADCON0,2
BANKSEL	STATUS
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: A-D.H (1858)
FN_READAD7:
;Optional ADN_PORT to support differential ADC
;Always LEFT justified
;for 16F1885x and possibly future others
;ADPCH = ADReadPort
	MOVF	ADREADPORT,W
BANKSEL	ADPCH
MOVWF	ADPCH
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (371)
;***  'Special section for 16F1688x Chips ***
;'Configure ANSELA/B/C/D
;Select Case ADReadPort 'Configure ANSELA/B/C/D @DebugADC_H
;Case 4: Set ANSELA.4 ON
SYSSELECT2CASE1:
	MOVLW	4
	BANKSEL	ADREADPORT
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND2
BANKSEL	ANSELA
	BSF	ANSELA,4
;End Select  '*** ANSEL Bits should now be set ***
SYSSELECTEND2:
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
;Set ADCON.2 off     '8-bit
;Set ADFM OFF
;B7: ASM Source was:  BCF ADCON0,ADFRM0
	BCF	ADCON0,2
;Set ADFM0 OFF
;B7: ASM Source was:  BCF ADCON0,ADFM0
	BCF	ADCON0,2
;End if
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
SYSWAITLOOP2:
;B7: ASM Source was:  BTFSC ADCON0,GO_NOT_DONE
	BTFSC	ADCON0,0
	GOTO	SYSWAITLOOP2
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
;Chips with no differential ADC
;IF ADN_PORT = True then
	BANKSEL	ADN_PORT
	INCF	ADN_PORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF14
;'Return an 8 Bit result for a 10bit number, as we are ALWAYS LEFT JUSTIFIED just return the ADRESH ignoring ADRESL
;ReadAD = ADRESH
BANKSEL	ADRESH
	MOVF	ADRESH,W
	BANKSEL	READAD
	MOVWF	READAD
	CLRF	READAD_H
;End if
ENDIF14:
;Allow 8-bit differential reads - WMR
;SET ADFM OFF
BANKSEL	ADCON0
;B7: ASM Source was:  BCF ADCON0,ADFRM0
	BCF	ADCON0,2
BANKSEL	STATUS
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (2002)
FN_READAD108:
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
;Case 4: Set ANSELA.4 ON
SYSSELECT3CASE1:
	MOVLW	4
	BANKSEL	ADREADPORT
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND3
BANKSEL	ANSELA
	BSF	ANSELA,4
;End Select  '*** ANSEL Bits should now be set ***
SYSSELECTEND3:
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
SYSWAITLOOP3:
;B7: ASM Source was:  BTFSC ADCON0,GO_NOT_DONE
	BTFSC	ADCON0,0
	GOTO	SYSWAITLOOP3
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
	GOTO	ENDIF18
;Right(0) = 0
	BANKSEL	SYSRIGHT_0
	CLRF	SYSRIGHT_0
;Exit Function
BANKSEL	STATUS
	RETURN
;End If
ENDIF18:
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
	GOTO	ENDIF19
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
ENDIF19:
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
	MOVWF	SYSTEMP1
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
	CLRF	SYSTEMP1
	MOVLW	HIGH(RIGHT)
	ADDWFC	SYSTEMP1,W
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

;SOURCE: SYSTEM.H (3065)
SYSCOMPLESSTHAN16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test High, exit if more
;movf SysWordTempA_H,W
	MOVF	SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
	SUBWF	SYSWORDTEMPB_H,W
;btfss STATUS,C
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;Test high, exit true if less
;movf SysWordTempB_H,W
	MOVF	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	SUBWF	SYSWORDTEMPA_H,W
;btfss STATUS,C
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
;goto SCLT16True
	GOTO	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	MOVF	SYSWORDTEMPB,W
;subwf SysWordTempA,W
	SUBWF	SYSWORDTEMPA,W
;btfsc STATUS,C
;B7: ASM Source was:  BTFSC STATUS,C
	BTFSC	STATUS,0
;return
	RETURN
SCLT16TRUE:
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
	GOTO	ENDIF16
;SysWordTempA = 0
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
;exit sub
	RETURN
;end if
ENDIF16:
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
	GOTO	ENDIF17
;Set SysDivMultA.0 Off
	BCF	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	MOVF	SYSDIVMULTB,W
	ADDWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	ADDWFC	SYSDIVMULTX_H,F
;End If
ENDIF17:
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
	RETLW	21
	RETLW	71	;G
	RETLW	114	;R
	RETLW	101	;E
	RETLW	97	;A
	RETLW	116	;T
	RETLW	32	; 
	RETLW	67	;C
	RETLW	111	;O
	RETLW	119	;W
	RETLW	32	; 
	RETLW	66	;B
	RETLW	97	;A
	RETLW	115	;S
	RETLW	105	;I
	RETLW	99	;C
	RETLW	32	; 
	RETLW	64	;
	RETLW	50	;2
	RETLW	48	;0
	RETLW	49	;1
	RETLW	54	;6

	ALIGN	2;X3

STRINGTABLE2:
	RETLW	17
	RETLW	88	;X
	RETLW	112	;P
	RETLW	114	;R
	RETLW	101	;E
	RETLW	115	;S
	RETLW	115	;S
	RETLW	32	; 
	RETLW	68	;D
	RETLW	101	;E
	RETLW	109	;M
	RETLW	111	;O
	RETLW	32	; 
	RETLW	66	;B
	RETLW	111	;O
	RETLW	97	;A
	RETLW	114	;R
	RETLW	100	;D

	ALIGN	2;X3

STRINGTABLE3:
	RETLW	9
	RETLW	48	;0
	RETLW	51	;3
	RETLW	32	; 
	RETLW	82	;R
	RETLW	111	;O
	RETLW	116	;T
	RETLW	97	;A
	RETLW	116	;T
	RETLW	101	;E

	ALIGN	2;X3

STRINGTABLE4:
	RETLW	3
	RETLW	80	;P
	RETLW	58	;:
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE5:
	RETLW	3
	RETLW	62	;>
	RETLW	62	;>
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE6:
	RETLW	3
	RETLW	60	;<
	RETLW	60	;<
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE38:
	RETLW	0

	ALIGN	2;X3

STRINGTABLE39:
	RETLW	1
	RETLW	49	;1

	ALIGN	2;X3

STRINGTABLE40:
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
