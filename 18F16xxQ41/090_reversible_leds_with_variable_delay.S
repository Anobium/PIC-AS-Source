;Program compiled by Great Cow BASIC (0.98.<<>> 2021-01-20 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
 PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC

 #include <xc.inc>

;********************************************************************************
;Explicit PIC-AS constants to resolve the crazyness of the PIC-AS syntax
;These are therefore the same as MPASM
#define BANKED b
#define ACCESS a

;********************************************************************************
;Explicit CONFIG
 CONFIG  CP = OFF
 CONFIG  WRTSAF = OFF
 CONFIG  WRTD = OFF
 CONFIG  WDTE = OFF
 CONFIG  XINST = OFF
 CONFIG  LVP = OFF
 CONFIG  MVECEN = OFF
 CONFIG  MCLRE = INTMCLR
 CONFIG  FCMEN = ON
 CONFIG  CLKOUTEN = OFF
 CONFIG  RSTOSC = HFINTOSC_1MHZ
 CONFIG  FEXTOSC = OFF
;Inferred CONFIG
 CONFIG  BBEN=ON
 CONFIG  BBSIZE=BBSIZE_512
 CONFIG  BOREN=OFF
 CONFIG  BORV=VBOR_2P85
 CONFIG  CSWEN=ON
 CONFIG  DEBUG=OFF
 CONFIG  FCMENP=OFF
 CONFIG  FCMENS=OFF
 CONFIG  IVT1WAY=OFF
 CONFIG  LPBOREN=ON
 CONFIG  PPS1WAY=OFF
 CONFIG  PR1WAY=OFF
 CONFIG  PWRTS=1
 CONFIG  SAFEN=ON
 CONFIG  STVREN=OFF
 CONFIG  WDTCCS=LFINTOSC
 CONFIG  WDTCPS=0
 CONFIG  WDTCWS=0
 CONFIG  WRTAPP=ON
 CONFIG  WRTB=ON
 CONFIG  WRTC=ON
 CONFIG  ZCD=ON

;********************************************************************************

;Set aside RAM memory locations for variables. All variables are global.
 ADCVAL                           EQU 1284
 ADREADPORT                       EQU 1286
 CHECK_SWITCH                     EQU 1287
 DELAYTEMP                        EQU 1280
 DELAYTEMP2                       EQU 1281
 DIRECTION                        EQU 1288
 READAD                           EQU 1289
 SYSBITVAR0                       EQU 1290
 SYSBYTETEMPX                     EQU 1280
 SYSTEMP1                         EQU 1291
 SYSTEMP2                         EQU 1292
 SYSTEMP3                         EQU 1293
 SYSWAITTEMP10US                  EQU 1285
 SYSWAITTEMPMS                    EQU 1282
 SYSWAITTEMPMS_H                  EQU 1283

;********************************************************************************

;Alias variables
 SYSREADADBYTE                    EQU 1289

;********************************************************************************

 PSECT   resetVec,class=CODE
 resetVec:
;Vectors
	ORG	0
	goto	BASPROGRAMSTART
	ORG	8
	retfie

;********************************************************************************

;Start of program memory page 0
	ORG	12
BASPROGRAMSTART:
;Call initialisation routines
	call	INITSYS

;Start of the main program
;''
;''  This demonstration shows the impact of the time delay to manage the debouncing of a switch.
;''  The ADC value creates a delay and LEDs switch between each other when the switch is depressed.
;''
;''
;''  Press the switch to reverse the direction of the LEDs, increase the ADC value to increase the debounce check.
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.01
;''@date    31.12.2020
;----- Configuration
;Chip Settings.
;' -------------------PORTA----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:   ---------------------SW------ADC--
;'-----------------------------------------
;'
;' -------------------PORTB----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ---------------------------------
;'-----------------------------------------
;'
;' ------------------PORTC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ---------------LED--LED-LED LED--
;'-----------------------------------------
;'
;Define constants to make things easier. We can reuse these at any time.
;#DEFINE LEDPORT LATC
;Dir     RC0         Out
	bcf	TRISC,0,ACCESS
;Dir     RC1         Out
	bcf	TRISC,1,ACCESS
;Dir     RC2         Out
	bcf	TRISC,2,ACCESS
;Dir     RC3         Out
	bcf	TRISC,3,ACCESS
;#DEFINE POTENTIOMETER PORTA.0
;Dir     POTENTIOMETER In
	bsf	TRISA,0,ACCESS
;#DEFINE SWITCHIN      PORTA.3
;Dir     SWITCHIN      In
	bsf	TRISA,3,ACCESS
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;#DEFINE DOWN        0
;#DEFINE UP          1
;Dim direction As Byte
;Dim ADCVal, leds  As Byte
;#DEFINE LED_RIGHT 0
;#DEFINE LED_LEFT  1
;start from the right to left
;direction = LED_RIGHT
	clrf	DIRECTION,ACCESS
;Set the initial LED states - change to suit your configuration
;#DEFINE LEDSTATEMACRO RC0 = 0: RC1 = 0: RC2 = 0: RC3 = 1
;You may need change to the LEDMASK to suit your port/configuration.  We use a macro as re reuse this statement more that once.
;#DEFINE LEDMASK 0B00001111
;LEDSTATEMACRO
	bcf	LATC,0,ACCESS
	bcf	LATC,1,ACCESS
	bcf	LATC,2,ACCESS
	bsf	LATC,3,ACCESS
;Do
SysDoLoop_S1:
;Get a value for the debounce period (the time)
;ADCVal = ReadAD( AN0 )
	clrf	ADREADPORT,ACCESS
	call	FN_READAD3
	movff	SYSREADADBYTE,ADCVAL
;Set the LEDs
;If  direction = LED_RIGHT  Then
	movf	DIRECTION,F,ACCESS
	btfss	STATUS,2,ACCESS
	bra	ELSE1_1
;LEDPORT = LEDPORT AND LEDMASK
	movlw	15
	andwf	LATC,F,ACCESS
;Rotate the LEDs.  We are only interested in the four LEDs so we mask the other bits.
;Set C Off
	bcf	STATUS,0,ACCESS
;and shift the contents of LEDState
;Rotate LEDPORT Right
	rrcf	LATC,F,ACCESS
;If the LEDState.0is equal to 1 then the sequence has completed, then set the initial state again, the same operation as the starting LED.
;If C = 1 Then
	btfss	STATUS,0,ACCESS
	bra	ENDIF3
;Set the initial LED states
;LEDSTATEMACRO
	bcf	LATC,0,ACCESS
	bcf	LATC,1,ACCESS
	bcf	LATC,2,ACCESS
	bsf	LATC,3,ACCESS
;Mask off the other bits
;LEDPORT = LEDPORT AND LEDMASK
	movlw	15
	andwf	LATC,F,ACCESS
;End If
ENDIF3:
;Else
	bra	ENDIF1
ELSE1_1:
;LEDPORT = LEDPORT AND LEDMASK
	movlw	15
	andwf	LATC,F,ACCESS
;Rotate the LEDs.  We are only interested in the four LEDs so we mask the other bits.
;Set C Off
	bcf	STATUS,0,ACCESS
;and shift the contents of LEDState
;Rotate LEDPORT Left
	rlcf	LATC,F,ACCESS
;If the LEDState.0is equal to 1 then the sequence has completed, then set the initial state again, the same operation as the starting LED.
;If RC4 = 1 Then
	btfss	PORTC,4,ACCESS
	bra	ENDIF4
;Mask off the other bits
;LEDPORT = LEDPORT AND LEDMASK
	movlw	15
	andwf	LATC,F,ACCESS
;Set the initial LED states
;RC0 = 1
	bsf	LATC,0,ACCESS
;End If
ENDIF4:
;End If
ENDIF1:
;wait for our debounce time, and then check the switch is DOWN
;If ADCVal > 1 Then
	movf	ADCVAL,W,ACCESS
	sublw	1
	btfsc	STATUS,0,ACCESS
	bra	ENDIF2
;Wait ADCVal ms
	movff	ADCVAL,SYSWAITTEMPMS
	clrf	SYSWAITTEMPMS_H,ACCESS
	call	Delay_MS
;If check_switch = TRUE Then
	call	FN_CHECK_SWITCH
	incf	CHECK_SWITCH,W,ACCESS
	btfsc	STATUS,2,ACCESS
;toggle the direction
;direction = !direction
	comf	DIRECTION,F,ACCESS
;End If
;End If
ENDIF2:
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1:
;global variable - if button is held down, we don't want to keep on SWITCHINg directions
;#DEFINE SWITCH_UP   1
;#DEFINE SWITCH_DOWN 0
;Dim previous_state As BIT
;previous_state = SWITCH_UP
	bsf	SYSBITVAR0,0,ACCESS
BASPROGRAMEND:
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: 090_reversible_leds_with_variable_delay.gcb (134)
FN_CHECK_SWITCH:
;switch is normally open to 5V ...when pressed, RA3 is connected to GND
;If (SWITCHIN = SWITCH_DOWN) Then
	btfsc	PORTA,3,ACCESS
	bra	ELSE6_1
;debounce by delaying and checking if switch is still pressed
;Wait 1 ms
	movlw	1
	movwf	SYSWAITTEMPMS,ACCESS
	clrf	SYSWAITTEMPMS_H,ACCESS
	call	Delay_MS
;If ( (previous_state =  SWITCH_DOWN) & (SWITCHIN = SWITCH_DOWN) ) Then
	clrf	SYSBYTETEMPX,ACCESS
	btfss	SYSBITVAR0,0,ACCESS
	comf	SYSBYTETEMPX,F,ACCESS
	movff	SYSBYTETEMPX,SYSTEMP1
	clrf	SYSBYTETEMPX,ACCESS
	btfss	PORTA,3,ACCESS
	comf	SYSBYTETEMPX,F,ACCESS
	movff	SYSBYTETEMPX,SYSTEMP2
	movf	SYSTEMP1,W,ACCESS
	andwf	SYSTEMP2,W,ACCESS
	movwf	SYSTEMP3,ACCESS
	btfss	SYSTEMP3,0,ACCESS
	bra	ELSE7_1
;don't toggle
;check_switch = FALSE
	clrf	CHECK_SWITCH,ACCESS
;Exit Function
	return
;Else
	bra	ENDIF7
ELSE7_1:
;check if still down
;If (SWITCHIN = SWITCH_DOWN) Then
	btfsc	PORTA,3,ACCESS
	bra	ELSE8_1
;previous_state = SWITCH_DOWN
	bcf	SYSBITVAR0,0,ACCESS
;reverse the LEDs
;check_switch = TRUE
	setf	CHECK_SWITCH,ACCESS
;Exit Function
	return
;Else
	bra	ENDIF8
ELSE8_1:
;switch not properly held down
;previous_state = SWITCH_UP
	bsf	SYSBITVAR0,0,ACCESS
;don't reverse
;check_switch = FALSE
	clrf	CHECK_SWITCH,ACCESS
;Exit Function
	return
;End If
ENDIF8:
;End If
ENDIF7:
;Else
	bra	ENDIF6
ELSE6_1:
;switch not pressed
;previous_state = SWITCH_UP
	bsf	SYSBITVAR0,0,ACCESS
;don't reverse
;check_switch = FALSE
	clrf	CHECK_SWITCH,ACCESS
;Exit Function
	return
;End If
ENDIF6:
	return

;********************************************************************************

Delay_10US:
D10US_START:
	movlw	52
	movwf	DELAYTEMP,ACCESS
DelayUS0:
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS0
	decfsz	SYSWAITTEMP10US, F,ACCESS
	bra	D10US_START
	return

;********************************************************************************

Delay_MS:
	incf	SYSWAITTEMPMS_H, F,ACCESS
DMS_START:
	movlw	129
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER:
	movlw	40
	movwf	DELAYTEMP,ACCESS
DMS_INNER:
	decfsz	DELAYTEMP, F,ACCESS
	bra	DMS_INNER
	decfsz	DELAYTEMP2, F,ACCESS
	bra	DMS_OUTER
	decfsz	SYSWAITTEMPMS, F,ACCESS
	bra	DMS_START
	decfsz	SYSWAITTEMPMS_H, F,ACCESS
	bra	DMS_START
	return

;********************************************************************************

;Source: system.h (127)
INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	movlw	96
	movwf	OSCCON1,BANKED
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
	clrf	OSCCON3,BANKED
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
	clrf	OSCEN,BANKED
;Default value
;OSCTUNE = 0x00
	clrf	OSCTUNE,BANKED
;asm showdebug The MCU is a chip family ChipFamily
;Section supports many MCUs, 18FxxK40, 18FxxK42 etc that have NDIV3 bit
;asm showdebug OSCCON type is 101
;Clear NDIV3:0
;NDIV3 = 0
	bcf	OSCCON1,3,BANKED
;NDIV2 = 0
	bcf	OSCCON1,2,BANKED
;NDIV1 = 0
	bcf	OSCCON1,1,BANKED
;NDIV0 = 0
	bcf	OSCCON1,0,BANKED
;OSCFRQ = 0b00001000  '64mhz
	movlw	8
	movwf	OSCFRQ,BANKED
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Clear BSR on ChipFamily16 MCUs
;BSR = 0
	clrf	BSR,ACCESS
;Clear TBLPTRU on MCUs with this bit as this must be zero
;TBLPTRU = 0
	clrf	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,2,BANKED
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
	bcf	ADCON0,7,BANKED
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
	banksel	CM2CON0
	bcf	CM2CON0,7,BANKED
;C1EN = 0
	bcf	CM1CON0,7,BANKED
;
;'Turn off all ports
;PORTA = 0
	clrf	PORTA,ACCESS
;PORTB = 0
	clrf	PORTB,ACCESS
;PORTC = 0
	clrf	PORTC,ACCESS
	return

;********************************************************************************

;Overloaded signature: BYTE:, Source: a-d.h (1739)
FN_READAD3:
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,2,BANKED
;for 16F1885x and possibly future others
;ADPCH = ADReadPort
	movff	ADREADPORT,ADPCH
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (370)
;***  'Special section for 16F1688x Chips ***
;'Configure ANSELA/B/C/D
;Select Case ADReadPort 'Configure ANSELA/B/C/D @DebugADC_H
;Case 0: Set ANSELA.0 On
SysSelect1Case1:
	movf	ADREADPORT,F,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case2
	banksel	ANSELA
	bsf	ANSELA,0,BANKED
;Case 1: Set ANSELA.1 On
	bra	SysSelectEnd1
SysSelect1Case2:
	decf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case3
	banksel	ANSELA
	bsf	ANSELA,1,BANKED
;Case 2: Set ANSELA.2 On
	bra	SysSelectEnd1
SysSelect1Case3:
	movlw	2
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case4
	banksel	ANSELA
	bsf	ANSELA,2,BANKED
;Case 3: Set ANSELA.3 On
	bra	SysSelectEnd1
SysSelect1Case4:
	movlw	3
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case5
	banksel	ANSELA
	bsf	ANSELA,3,BANKED
;Case 4: Set ANSELA.4 ON
	bra	SysSelectEnd1
SysSelect1Case5:
	movlw	4
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case6
	banksel	ANSELA
	bsf	ANSELA,4,BANKED
;Case 5: Set ANSELA.5 On
	bra	SysSelectEnd1
SysSelect1Case6:
	movlw	5
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case7
	banksel	ANSELA
	bsf	ANSELA,5,BANKED
;Case 6: Set ANSELA.6 On
	bra	SysSelectEnd1
SysSelect1Case7:
	movlw	6
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case8
	banksel	ANSELA
	bsf	ANSELA,6,BANKED
;Case 7: Set ANSELA.7 On
	bra	SysSelectEnd1
SysSelect1Case8:
	movlw	7
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case9
	banksel	ANSELA
	bsf	ANSELA,7,BANKED
;Case 8: Set ANSELB.0 On
	bra	SysSelectEnd1
SysSelect1Case9:
	movlw	8
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case10
	banksel	ANSELB
	bsf	ANSELB,0,BANKED
;Case 9: Set ANSELB.1 On
	bra	SysSelectEnd1
SysSelect1Case10:
	movlw	9
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case11
	banksel	ANSELB
	bsf	ANSELB,1,BANKED
;Case 10: Set ANSELB.2 On
	bra	SysSelectEnd1
SysSelect1Case11:
	movlw	10
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case12
	banksel	ANSELB
	bsf	ANSELB,2,BANKED
;Case 11: Set ANSELB.3 On
	bra	SysSelectEnd1
SysSelect1Case12:
	movlw	11
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case13
	banksel	ANSELB
	bsf	ANSELB,3,BANKED
;Case 12: Set ANSELB.4 On
	bra	SysSelectEnd1
SysSelect1Case13:
	movlw	12
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case14
	banksel	ANSELB
	bsf	ANSELB,4,BANKED
;Case 13: Set ANSELB.5 On
	bra	SysSelectEnd1
SysSelect1Case14:
	movlw	13
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case15
	banksel	ANSELB
	bsf	ANSELB,5,BANKED
;Case 14: Set ANSELB.6 On
	bra	SysSelectEnd1
SysSelect1Case15:
	movlw	14
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case16
	banksel	ANSELB
	bsf	ANSELB,6,BANKED
;Case 15: Set ANSELB.7 On
	bra	SysSelectEnd1
SysSelect1Case16:
	movlw	15
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case17
	banksel	ANSELB
	bsf	ANSELB,7,BANKED
;Case 16: Set ANSELC.0 On
	bra	SysSelectEnd1
SysSelect1Case17:
	movlw	16
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case18
	banksel	ANSELC
	bsf	ANSELC,0,BANKED
;Case 17: Set ANSELC.1 On
	bra	SysSelectEnd1
SysSelect1Case18:
	movlw	17
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case19
	banksel	ANSELC
	bsf	ANSELC,1,BANKED
;Case 18: Set ANSELC.2 On
	bra	SysSelectEnd1
SysSelect1Case19:
	movlw	18
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case20
	banksel	ANSELC
	bsf	ANSELC,2,BANKED
;Case 19: Set ANSELC.3 On
	bra	SysSelectEnd1
SysSelect1Case20:
	movlw	19
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case21
	banksel	ANSELC
	bsf	ANSELC,3,BANKED
;Case 20: Set ANSELC.4 On
	bra	SysSelectEnd1
SysSelect1Case21:
	movlw	20
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case22
	banksel	ANSELC
	bsf	ANSELC,4,BANKED
;Case 21: Set ANSELC.5 On
	bra	SysSelectEnd1
SysSelect1Case22:
	movlw	21
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case23
	banksel	ANSELC
	bsf	ANSELC,5,BANKED
;Case 22: Set ANSELC.6 On
	bra	SysSelectEnd1
SysSelect1Case23:
	movlw	22
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect1Case24
	banksel	ANSELC
	bsf	ANSELC,6,BANKED
;Case 23: Set ANSELC.7 On
	bra	SysSelectEnd1
SysSelect1Case24:
	movlw	23
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelectEnd1
	banksel	ANSELC
	bsf	ANSELC,7,BANKED
;End Select  '*** ANSEL Bits should now be set ***
SysSelectEnd1:
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
	banksel	ADCON0
	bcf	ADCON0,4,BANKED
;ADCLK = 1 ' default to FOSC/2
	movlw	1
	movwf	ADCLK,BANKED
;Conversion Clock Speed
;SET ADCS OFF  'ADCON0.4
	bcf	ADCON0,4,BANKED
;ADCLK = 15    'FOSC/16
	movlw	15
	movwf	ADCLK,BANKED
;Result formatting
;if ADLeftadjust = 0 then  '10-bit
;Set ADCON.2 off     '8-bit
;Set ADFM OFF
	bcf	ADCON0,2,BANKED
;Set ADFM0 OFF
	bcf	ADCON0,2,BANKED
;End if
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	movff	ADREADPORT,ADPCH
;Enable A/D
;SET ADON ON
	bsf	ADCON0,7,BANKED
;Acquisition Delay
;Wait AD_Delay
	movlw	2
	movwf	SYSWAITTEMP10US,ACCESS
	banksel	0
	call	Delay_10US
;Read A/D
;SET GO_NOT_DONE ON
	banksel	ADCON0
	bsf	ADCON0,0,BANKED
;nop
	nop
;Wait While GO_NOT_DONE ON
SysWaitLoop1:
	btfsc	ADCON0,0,BANKED
	bra	SysWaitLoop1
;Switch off A/D
;SET ADCON0.ADON OFF
	bcf	ADCON0,7,BANKED
;ANSELA = 0
	banksel	ANSELA
	clrf	ANSELA,BANKED
;ANSELB = 0
	clrf	ANSELB,BANKED
;ANSELC = 0
	clrf	ANSELC,BANKED
;ReadAD = ADRESH
	movff	ADRESH,READAD
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,2,BANKED
	banksel	0
	return

;********************************************************************************

;
; Declare Power-On-Reset entry point
;
 END     resetVec
