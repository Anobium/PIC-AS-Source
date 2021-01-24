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
 DELAYTEMP                        EQU 1280
 DELAYTEMP2                       EQU 1281
 SYSREPEATTEMP1                   EQU 1284
 SYSTEMP1                         EQU 1285
 SYSWAITTEMPMS                    EQU 1282
 SYSWAITTEMPMS_H                  EQU 1283

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
;'' This demonstration uses the master reset as an input.  This WILL ONLY work when you do NOT use Low Voltage Programming (LVP).
;''
;'' The code will inspect the switch status, but should overcome most of the noise from a switch.
;'' Some switches are worse than others.
;''
;'' When the switch is held down, one LED will be lit.
;'' This time we are using the RESET button as an input switch.
;''
;''
;''************************************************************************
;''@author  EvanV
;''@licence GPL
;''@version 1.01
;''@date    31.12.2020
;Chip Settings.
;The will enable the reset switch to be an input.  This will NOT reset the chip now but the reset becomes a switch input but ONLY when LVP=off
;EXTMCLR is MCLR Enable bit->If LVP = 0, MCLR pin is MCLR; If LVP = 1, RA3 pin function is MCLR
;' -------------------PORTA----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' IO:   -----------------MCLE-SW-----ADC--
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
;#DEFINE RSTButton     PORTA.3
;Dir     RSTButton     In  'this is set automatically - so, you cannot set as an output
	bsf	TRISA,3,ACCESS
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Flash an LED to show a reset has happened
;Repeat 10
	movlw	10
	movwf	SYSREPEATTEMP1,ACCESS
SysRepeatLoop1:
;RC1 = !RC1
	clrf	SYSTEMP1,ACCESS
	btfsc	PORTC,1,ACCESS
	incf	SYSTEMP1,F,ACCESS
	comf	SYSTEMP1,F,ACCESS
	bcf	LATC,1,ACCESS
	btfsc	SYSTEMP1,0,ACCESS
	bsf	LATC,1,ACCESS
;wait 100 ms
	movlw	100
	movwf	SYSWAITTEMPMS,ACCESS
	clrf	SYSWAITTEMPMS_H,ACCESS
	call	Delay_MS
;End Repeat
	decfsz	SYSREPEATTEMP1,F,ACCESS
	bra	SysRepeatLoop1
SysRepeatLoopEnd1:
;Do Forever
SysDoLoop_S1:
;Wait 10 ms
	movlw	10
	movwf	SYSWAITTEMPMS,ACCESS
	clrf	SYSWAITTEMPMS_H,ACCESS
	call	Delay_MS
;The reset line is always HIGH, so, we have to test when the line goes low.
;If  RSTButton = 0 Then
	btfsc	PORTA,3,ACCESS
	bra	ELSE1_1
;push button pressed
;RC2 = 1
	bsf	LATC,2,ACCESS
;Else
	bra	ENDIF1
ELSE1_1:
;RC2 = 0
	bcf	LATC,2,ACCESS
;End If
ENDIF1:
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1:
BASPROGRAMEND:
	sleep
	bra	BASPROGRAMEND

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

;
; Declare Power-On-Reset entry point
;
 END     resetVec
