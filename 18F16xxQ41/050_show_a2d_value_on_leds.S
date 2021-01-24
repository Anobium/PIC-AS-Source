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
#define upper low highword

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
PSECT UDATA
 ADCVAL                           EQU 1284
 ADREADPORT                       EQU 1286
 DELAYTEMP                        EQU 1280
 DELAYTEMP2                       EQU 1281
 READAD                           EQU 1287
 SYSWAITTEMP10US                  EQU 1285
 SYSWAITTEMPMS                    EQU 1282
 SYSWAITTEMPMS_H                  EQU 1283

;********************************************************************************

;Alias variables
 SYSREADADBYTE                    EQU 1287

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
;'' This shows how to read the A2D converter and display the a proportioanal value on the LEDs.
;'' The pot on the board varies the voltage coming in on the microcontroller.
;''
;'' Rotate the POT to see the LEDs change.
;''
;'' The A2D is referenced to the same Vdd as the device, which
;'' is nominally is 5V.  The A2D returns the ratio of the voltage
;'' on Pin RA0 to 5V.  The A2D has a resolution of 8 bits, with 255
;'' representing 5V and 0 representing 0V.
;''
;''
;'' Rotate the potentiometer to change the LEDs displayed.
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
;' IO:   -----------------------------ADC--
;'-----------------------------------------
;'
;' -------------------PORTB----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ---------------------------------
;'-----------------------------------------
;'
;' ------------------PORTC-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:    ---------------LED--LED-LED-LED--
;'-----------------------------------------
;'
;Define constants to make things easier. We can reuse these at any time.
;#DEFINE LEDPORT LATC
;#DEFINE POTENTIOMETER RA0
;Dir     RC0         Out
	bcf	TRISC,0,ACCESS
;Dir     RC1         Out
	bcf	TRISC,1,ACCESS
;Dir     RC2         Out
	bcf	TRISC,2,ACCESS
;Dir     RC3         Out
	bcf	TRISC,3,ACCESS
;This is the PORTA.0 port
;Dir     POTENTIOMETER In
	bsf	TRISA,0,ACCESS
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim adcVal As Byte
;Do
SysDoLoop_S1:
;adcVal =  ReadAD ( AN0 )
	clrf	ADREADPORT,ACCESS
	call	FN_READAD2
	movff	SYSREADADBYTE,ADCVAL
;Select Case adcVal
;Case 0 to 49
SysSelect1Case1:
	movlw	0
	subwf	ADCVAL,W,ACCESS
	btfss	STATUS,0,ACCESS
	bra	SysSelect1Case2
	movf	ADCVAL,W,ACCESS
	sublw	49
	btfss	STATUS,0,ACCESS
	bra	SysSelect1Case2
;RC0 = 0
	bcf	LATC,0,ACCESS
;RC1 = 0
	bcf	LATC,1,ACCESS
;RC2 = 0
	bcf	LATC,2,ACCESS
;RC3 = 0
	bcf	LATC,3,ACCESS
;Case 50 to 99
	bra	SysSelectEnd1
SysSelect1Case2:
	movlw	50
	subwf	ADCVAL,W,ACCESS
	btfss	STATUS,0,ACCESS
	bra	SysSelect1Case3
	movf	ADCVAL,W,ACCESS
	sublw	99
	btfss	STATUS,0,ACCESS
	bra	SysSelect1Case3
;RC0 = 1
	bsf	LATC,0,ACCESS
;RC1 = 0
	bcf	LATC,1,ACCESS
;RC2 = 0
	bcf	LATC,2,ACCESS
;RC3 = 0
	bcf	LATC,3,ACCESS
;Case 100 to 149
	bra	SysSelectEnd1
SysSelect1Case3:
	movlw	100
	subwf	ADCVAL,W,ACCESS
	btfss	STATUS,0,ACCESS
	bra	SysSelect1Case4
	movf	ADCVAL,W,ACCESS
	sublw	149
	btfss	STATUS,0,ACCESS
	bra	SysSelect1Case4
;RC0 = 1
	bsf	LATC,0,ACCESS
;RC1 = 1
	bsf	LATC,1,ACCESS
;RC2 = 0
	bcf	LATC,2,ACCESS
;RC3 = 0
	bcf	LATC,3,ACCESS
;Case 150 to 200
	bra	SysSelectEnd1
SysSelect1Case4:
	movlw	150
	subwf	ADCVAL,W,ACCESS
	btfss	STATUS,0,ACCESS
	bra	SysSelect1Case5
	movf	ADCVAL,W,ACCESS
	sublw	200
	btfss	STATUS,0,ACCESS
	bra	SysSelect1Case5
;RC0 = 1
	bsf	LATC,0,ACCESS
;RC1 = 1
	bsf	LATC,1,ACCESS
;RC2 = 1
	bsf	LATC,2,ACCESS
;RC3 = 0
	bcf	LATC,3,ACCESS
;Case Else
	bra	SysSelectEnd1
SysSelect1Case5:
;RC0 = 1
	bsf	LATC,0,ACCESS
;RC1 = 1
	bsf	LATC,1,ACCESS
;RC2 = 1
	bsf	LATC,2,ACCESS
;RC3 = 1
	bsf	LATC,3,ACCESS
;End Select
SysSelectEnd1:
;Or, another way
;
;If adcVal < 49 then
;RC1 = 0
;RC2 = 0
;RC3 = 0
;RC4 = 0
;
;else if adcVal > 49 and adcVal < 100 then
;RC1 = 1
;RC2 = 0
;RC3 = 0
;RC4 = 0
;
;else if adcVal > 100 and adcVal < 150 then
;RC1 = 1
;RC2 = 1
;RC3 = 0
;RC4 = 0
;
;else if adcVal > 150 and adcVal < 200 then
;RC1 = 1
;RC2 = 1
;RC3 = 1
;RC4 = 0
;
;else if adcVal > 200 then
;RC1 = 1
;RC2 = 1
;RC3 = 1
;RC4 = 1
;End if
;wait 100 ms
	movlw	100
	movwf	SYSWAITTEMPMS,ACCESS
	clrf	SYSWAITTEMPMS_H,ACCESS
	call	Delay_MS
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1:
BASPROGRAMEND:
	sleep
	bra	BASPROGRAMEND

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
FN_READAD2:
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
SysSelect2Case1:
	movf	ADREADPORT,F,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case2
	banksel	ANSELA
	bsf	ANSELA,0,BANKED
;Case 1: Set ANSELA.1 On
	bra	SysSelectEnd2
SysSelect2Case2:
	decf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case3
	banksel	ANSELA
	bsf	ANSELA,1,BANKED
;Case 2: Set ANSELA.2 On
	bra	SysSelectEnd2
SysSelect2Case3:
	movlw	2
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case4
	banksel	ANSELA
	bsf	ANSELA,2,BANKED
;Case 3: Set ANSELA.3 On
	bra	SysSelectEnd2
SysSelect2Case4:
	movlw	3
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case5
	banksel	ANSELA
	bsf	ANSELA,3,BANKED
;Case 4: Set ANSELA.4 ON
	bra	SysSelectEnd2
SysSelect2Case5:
	movlw	4
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case6
	banksel	ANSELA
	bsf	ANSELA,4,BANKED
;Case 5: Set ANSELA.5 On
	bra	SysSelectEnd2
SysSelect2Case6:
	movlw	5
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case7
	banksel	ANSELA
	bsf	ANSELA,5,BANKED
;Case 6: Set ANSELA.6 On
	bra	SysSelectEnd2
SysSelect2Case7:
	movlw	6
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case8
	banksel	ANSELA
	bsf	ANSELA,6,BANKED
;Case 7: Set ANSELA.7 On
	bra	SysSelectEnd2
SysSelect2Case8:
	movlw	7
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case9
	banksel	ANSELA
	bsf	ANSELA,7,BANKED
;Case 8: Set ANSELB.0 On
	bra	SysSelectEnd2
SysSelect2Case9:
	movlw	8
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case10
	banksel	ANSELB
	bsf	ANSELB,0,BANKED
;Case 9: Set ANSELB.1 On
	bra	SysSelectEnd2
SysSelect2Case10:
	movlw	9
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case11
	banksel	ANSELB
	bsf	ANSELB,1,BANKED
;Case 10: Set ANSELB.2 On
	bra	SysSelectEnd2
SysSelect2Case11:
	movlw	10
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case12
	banksel	ANSELB
	bsf	ANSELB,2,BANKED
;Case 11: Set ANSELB.3 On
	bra	SysSelectEnd2
SysSelect2Case12:
	movlw	11
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case13
	banksel	ANSELB
	bsf	ANSELB,3,BANKED
;Case 12: Set ANSELB.4 On
	bra	SysSelectEnd2
SysSelect2Case13:
	movlw	12
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case14
	banksel	ANSELB
	bsf	ANSELB,4,BANKED
;Case 13: Set ANSELB.5 On
	bra	SysSelectEnd2
SysSelect2Case14:
	movlw	13
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case15
	banksel	ANSELB
	bsf	ANSELB,5,BANKED
;Case 14: Set ANSELB.6 On
	bra	SysSelectEnd2
SysSelect2Case15:
	movlw	14
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case16
	banksel	ANSELB
	bsf	ANSELB,6,BANKED
;Case 15: Set ANSELB.7 On
	bra	SysSelectEnd2
SysSelect2Case16:
	movlw	15
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case17
	banksel	ANSELB
	bsf	ANSELB,7,BANKED
;Case 16: Set ANSELC.0 On
	bra	SysSelectEnd2
SysSelect2Case17:
	movlw	16
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case18
	banksel	ANSELC
	bsf	ANSELC,0,BANKED
;Case 17: Set ANSELC.1 On
	bra	SysSelectEnd2
SysSelect2Case18:
	movlw	17
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case19
	banksel	ANSELC
	bsf	ANSELC,1,BANKED
;Case 18: Set ANSELC.2 On
	bra	SysSelectEnd2
SysSelect2Case19:
	movlw	18
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case20
	banksel	ANSELC
	bsf	ANSELC,2,BANKED
;Case 19: Set ANSELC.3 On
	bra	SysSelectEnd2
SysSelect2Case20:
	movlw	19
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case21
	banksel	ANSELC
	bsf	ANSELC,3,BANKED
;Case 20: Set ANSELC.4 On
	bra	SysSelectEnd2
SysSelect2Case21:
	movlw	20
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case22
	banksel	ANSELC
	bsf	ANSELC,4,BANKED
;Case 21: Set ANSELC.5 On
	bra	SysSelectEnd2
SysSelect2Case22:
	movlw	21
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case23
	banksel	ANSELC
	bsf	ANSELC,5,BANKED
;Case 22: Set ANSELC.6 On
	bra	SysSelectEnd2
SysSelect2Case23:
	movlw	22
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelect2Case24
	banksel	ANSELC
	bsf	ANSELC,6,BANKED
;Case 23: Set ANSELC.7 On
	bra	SysSelectEnd2
SysSelect2Case24:
	movlw	23
	subwf	ADREADPORT,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	SysSelectEnd2
	banksel	ANSELC
	bsf	ANSELC,7,BANKED
;End Select  '*** ANSEL Bits should now be set ***
SysSelectEnd2:
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
