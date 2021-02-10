;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\050_show_a2d_value_on_leds.S"
 SUBTITLE    "02-10-2021"

; Reverse lookup file
; C:\Program Files\Microchip\xc8\v2.31\pic\include\proc\pic18f16q41.inc

 #include <xc.inc>

;********************************************************************************
;Explicit PIC-AS constants to resolve the crazyness of the PIC-AS syntax
;These are therefore the same as MPASM
#define BANKED b
#define ACCESS a
#define UPPER low highword

;********************************************************************************
;Explicit CONFIG
 CONFIG  CP = OFF
 CONFIG  WRTSAF = OFF
 CONFIG  WRTD = OFF
 CONFIG  WRTB = OFF
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
 CONFIG  PWRTS=PWRT_1
 CONFIG  SAFEN=ON
 CONFIG  STVREN=OFF
 CONFIG  WDTCCS=LFINTOSC
 CONFIG  WDTCPS=WDTCPS_0
 CONFIG  WDTCWS=WDTCWS_0
 CONFIG  WRTAPP=ON
 CONFIG  WRTC=ON
 CONFIG  ZCD=ON

;********************************************************************************

;Set aside RAM memory locations for variables. All variables are global.
 ADCVAL                           EQU 1284                    ; 0X504
 ADREADPORT                       EQU 1286                    ; 0X506
 DELAYTEMP                        EQU 1280                    ; 0X500
 DELAYTEMP2                       EQU 1281                    ; 0X501
 READAD                           EQU 1287                    ; 0X507
 SYSWAITTEMP10US                  EQU 1285                    ; 0X505
 SYSWAITTEMPMS                    EQU 1282                    ; 0X502
 SYSWAITTEMPMS_H                  EQU 1283                    ; 0X503

;********************************************************************************

;ALIAS VARIABLES
 SYSREADADBYTE                    EQU 1287

;********************************************************************************

 PSECT   RESETVEC,delta=1, abs
 RESETVEC:
;VECTORS
	ORG	0
	GOTO	BASPROGRAMSTART
	ORG	8
	RETFIE

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	12
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	RCALL	INITSYS

;START OF THE MAIN PROGRAM
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
	BCF	TRISC,0,ACCESS
;Dir     RC1         Out
	BCF	TRISC,1,ACCESS
;Dir     RC2         Out
	BCF	TRISC,2,ACCESS
;Dir     RC3         Out
	BCF	TRISC,3,ACCESS
;This is the PORTA.0 port
;Dir     POTENTIOMETER In
	BSF	TRISA,0,ACCESS
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim adcVal As Byte
;Do
SYSDOLOOP_S1:
;adcVal =  ReadAD ( AN0 )
	CLRF	ADREADPORT,ACCESS
	RCALL	FN_READAD4
	MOVFF	SYSREADADBYTE,ADCVAL
;Select Case adcVal
;Case 0 to 49
SYSSELECT1CASE1:
	MOVLW	0
	SUBWF	ADCVAL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSSELECT1CASE2
	MOVF	ADCVAL,W,ACCESS
	SUBLW	49
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSSELECT1CASE2
;RC0 = 0
;A8: ASM Source was:  BCF LATC,RC0,ACCESS
	BCF	LATC,0,ACCESS
;RC1 = 0
;A8: ASM Source was:  BCF LATC,RC1,ACCESS
	BCF	LATC,1,ACCESS
;RC2 = 0
;A8: ASM Source was:  BCF LATC,RC2,ACCESS
	BCF	LATC,2,ACCESS
;RC3 = 0
;A8: ASM Source was:  BCF LATC,RC3,ACCESS
	BCF	LATC,3,ACCESS
;Case 50 to 99
	BRA	SYSSELECTEND1
SYSSELECT1CASE2:
	MOVLW	50
	SUBWF	ADCVAL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSSELECT1CASE3
	MOVF	ADCVAL,W,ACCESS
	SUBLW	99
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSSELECT1CASE3
;RC0 = 1
;A8: ASM Source was:  BSF LATC,RC0,ACCESS
	BSF	LATC,0,ACCESS
;RC1 = 0
;A8: ASM Source was:  BCF LATC,RC1,ACCESS
	BCF	LATC,1,ACCESS
;RC2 = 0
;A8: ASM Source was:  BCF LATC,RC2,ACCESS
	BCF	LATC,2,ACCESS
;RC3 = 0
;A8: ASM Source was:  BCF LATC,RC3,ACCESS
	BCF	LATC,3,ACCESS
;Case 100 to 149
	BRA	SYSSELECTEND1
SYSSELECT1CASE3:
	MOVLW	100
	SUBWF	ADCVAL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSSELECT1CASE4
	MOVF	ADCVAL,W,ACCESS
	SUBLW	149
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSSELECT1CASE4
;RC0 = 1
;A8: ASM Source was:  BSF LATC,RC0,ACCESS
	BSF	LATC,0,ACCESS
;RC1 = 1
;A8: ASM Source was:  BSF LATC,RC1,ACCESS
	BSF	LATC,1,ACCESS
;RC2 = 0
;A8: ASM Source was:  BCF LATC,RC2,ACCESS
	BCF	LATC,2,ACCESS
;RC3 = 0
;A8: ASM Source was:  BCF LATC,RC3,ACCESS
	BCF	LATC,3,ACCESS
;Case 150 to 200
	BRA	SYSSELECTEND1
SYSSELECT1CASE4:
	MOVLW	150
	SUBWF	ADCVAL,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSSELECT1CASE5
	MOVF	ADCVAL,W,ACCESS
	SUBLW	200
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSSELECT1CASE5
;RC0 = 1
;A8: ASM Source was:  BSF LATC,RC0,ACCESS
	BSF	LATC,0,ACCESS
;RC1 = 1
;A8: ASM Source was:  BSF LATC,RC1,ACCESS
	BSF	LATC,1,ACCESS
;RC2 = 1
;A8: ASM Source was:  BSF LATC,RC2,ACCESS
	BSF	LATC,2,ACCESS
;RC3 = 0
;A8: ASM Source was:  BCF LATC,RC3,ACCESS
	BCF	LATC,3,ACCESS
;Case Else
	BRA	SYSSELECTEND1
SYSSELECT1CASE5:
;RC0 = 1
;A8: ASM Source was:  BSF LATC,RC0,ACCESS
	BSF	LATC,0,ACCESS
;RC1 = 1
;A8: ASM Source was:  BSF LATC,RC1,ACCESS
	BSF	LATC,1,ACCESS
;RC2 = 1
;A8: ASM Source was:  BSF LATC,RC2,ACCESS
	BSF	LATC,2,ACCESS
;RC3 = 1
;A8: ASM Source was:  BSF LATC,RC3,ACCESS
	BSF	LATC,3,ACCESS
;End Select
SYSSELECTEND1:
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
	MOVLW	100
	MOVWF	SYSWAITTEMPMS,ACCESS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	RCALL	DELAY_MS
;Loop
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1:
BASPROGRAMEND:
	SLEEP
	BRA	BASPROGRAMEND

;********************************************************************************

DELAY_10US:
D10US_START:
	MOVLW	52
	MOVWF	DELAYTEMP,ACCESS
DELAYUS0:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS0
	DECFSZ	SYSWAITTEMP10US, F,ACCESS
	BRA	D10US_START
	RETURN

;********************************************************************************

DELAY_MS:
	INCF	SYSWAITTEMPMS_H, F,ACCESS
DMS_START:
	MOVLW	129
	MOVWF	DELAYTEMP2,ACCESS
DMS_OUTER:
	MOVLW	40
	MOVWF	DELAYTEMP,ACCESS
DMS_INNER:
	DECFSZ	DELAYTEMP, F,ACCESS
	BRA	DMS_INNER
	DECFSZ	DELAYTEMP2, F,ACCESS
	BRA	DMS_OUTER
	DECFSZ	SYSWAITTEMPMS, F,ACCESS
	BRA	DMS_START
	DECFSZ	SYSWAITTEMPMS_H, F,ACCESS
	BRA	DMS_START
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (129)
INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	MOVLW	96
	MOVWF	OSCCON1,BANKED
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
	CLRF	OSCCON3,BANKED
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
	CLRF	OSCEN,BANKED
;Default value
;OSCTUNE = 0x00
	CLRF	OSCTUNE,BANKED
;asm showdebug The MCU is a chip family ChipFamily
;Section supports many MCUs, 18FxxK40, 18FxxK42 etc that have NDIV3 bit
;asm showdebug OSCCON type is 101
;Clear NDIV3:0
;NDIV3 = 0
;A8: ASM Source was:  BCF OSCCON1,NDIV3,BANKED
	BCF	OSCCON1,3,BANKED
;NDIV2 = 0
;A8: ASM Source was:  BCF OSCCON1,NDIV2,BANKED
	BCF	OSCCON1,2,BANKED
;NDIV1 = 0
;A8: ASM Source was:  BCF OSCCON1,NDIV1,BANKED
	BCF	OSCCON1,1,BANKED
;NDIV0 = 0
;A8: ASM Source was:  BCF OSCCON1,NDIV0,BANKED
	BCF	OSCCON1,0,BANKED
;OSCFRQ = 0b00001000  '64mhz
	MOVLW	8
	MOVWF	OSCFRQ,BANKED
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Clear BSR on ChipFamily16 MCUs
;BSR = 0
	CLRF	BSR,ACCESS
;Clear TBLPTRU on MCUs with this bit as this must be zero
;TBLPTRU = 0
	CLRF	TBLPTRU,ACCESS
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
BANKSEL	ADCON0
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
;A8: ASM Source was:  BCF ADCON0,ADON,BANKED
	BCF	ADCON0,7,BANKED
;ANSELA = 0
BANKSEL	ANSELA
	CLRF	ANSELA,BANKED
;ANSELB = 0
	CLRF	ANSELB,BANKED
;ANSELC = 0
	CLRF	ANSELC,BANKED
;Set comparator register bits for many MCUs with register CM2CON0
;C2EN = 0
BANKSEL	CM2CON0
;A8: ASM Source was:  BCF CM2CON0,C2EN,BANKED
	BCF	CM2CON0,7,BANKED
;C1EN = 0
;A8: ASM Source was:  BCF CM1CON0,C1EN,BANKED
	BCF	CM1CON0,7,BANKED
;
;'Turn off all ports
;PORTA = 0
	CLRF	PORTA,ACCESS
;PORTB = 0
	CLRF	PORTB,ACCESS
;PORTC = 0
	CLRF	PORTC,ACCESS
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (1740)
FN_READAD4:
;ADFM should configured to ensure LEFT justified
;SET ADFM OFF
BANKSEL	ADCON0
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
;for 16F1885x and possibly future others
;ADPCH = ADReadPort
	MOVFF	ADREADPORT,ADPCH
;***************************************
;Perform conversion
;LLReadAD 1
;Macro Source: a-d.h (371)
;***  'Special section for 16F1688x Chips ***
;'Configure ANSELA/B/C/D
;Select Case ADReadPort 'Configure ANSELA/B/C/D @DebugADC_H
;Case 0: Set ANSELA.0 On
SYSSELECT2CASE1:
	MOVF	ADREADPORT,F,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE2
BANKSEL	ANSELA
	BSF	ANSELA,0,BANKED
;Case 1: Set ANSELA.1 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE2:
	DECF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE3
BANKSEL	ANSELA
	BSF	ANSELA,1,BANKED
;Case 2: Set ANSELA.2 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE3:
	MOVLW	2
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE4
BANKSEL	ANSELA
	BSF	ANSELA,2,BANKED
;Case 3: Set ANSELA.3 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE4:
	MOVLW	3
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE5
BANKSEL	ANSELA
	BSF	ANSELA,3,BANKED
;Case 4: Set ANSELA.4 ON
	BRA	SYSSELECTEND2
SYSSELECT2CASE5:
	MOVLW	4
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE6
BANKSEL	ANSELA
	BSF	ANSELA,4,BANKED
;Case 5: Set ANSELA.5 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE6:
	MOVLW	5
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE7
BANKSEL	ANSELA
	BSF	ANSELA,5,BANKED
;Case 6: Set ANSELA.6 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE7:
	MOVLW	6
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE8
BANKSEL	ANSELA
	BSF	ANSELA,6,BANKED
;Case 7: Set ANSELA.7 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE8:
	MOVLW	7
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE9
BANKSEL	ANSELA
	BSF	ANSELA,7,BANKED
;Case 8: Set ANSELB.0 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE9:
	MOVLW	8
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE10
BANKSEL	ANSELB
	BSF	ANSELB,0,BANKED
;Case 9: Set ANSELB.1 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE10:
	MOVLW	9
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE11
BANKSEL	ANSELB
	BSF	ANSELB,1,BANKED
;Case 10: Set ANSELB.2 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE11:
	MOVLW	10
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE12
BANKSEL	ANSELB
	BSF	ANSELB,2,BANKED
;Case 11: Set ANSELB.3 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE12:
	MOVLW	11
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE13
BANKSEL	ANSELB
	BSF	ANSELB,3,BANKED
;Case 12: Set ANSELB.4 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE13:
	MOVLW	12
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE14
BANKSEL	ANSELB
	BSF	ANSELB,4,BANKED
;Case 13: Set ANSELB.5 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE14:
	MOVLW	13
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE15
BANKSEL	ANSELB
	BSF	ANSELB,5,BANKED
;Case 14: Set ANSELB.6 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE15:
	MOVLW	14
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE16
BANKSEL	ANSELB
	BSF	ANSELB,6,BANKED
;Case 15: Set ANSELB.7 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE16:
	MOVLW	15
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE17
BANKSEL	ANSELB
	BSF	ANSELB,7,BANKED
;Case 16: Set ANSELC.0 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE17:
	MOVLW	16
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE18
BANKSEL	ANSELC
	BSF	ANSELC,0,BANKED
;Case 17: Set ANSELC.1 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE18:
	MOVLW	17
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE19
BANKSEL	ANSELC
	BSF	ANSELC,1,BANKED
;Case 18: Set ANSELC.2 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE19:
	MOVLW	18
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE20
BANKSEL	ANSELC
	BSF	ANSELC,2,BANKED
;Case 19: Set ANSELC.3 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE20:
	MOVLW	19
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE21
BANKSEL	ANSELC
	BSF	ANSELC,3,BANKED
;Case 20: Set ANSELC.4 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE21:
	MOVLW	20
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE22
BANKSEL	ANSELC
	BSF	ANSELC,4,BANKED
;Case 21: Set ANSELC.5 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE22:
	MOVLW	21
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE23
BANKSEL	ANSELC
	BSF	ANSELC,5,BANKED
;Case 22: Set ANSELC.6 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE23:
	MOVLW	22
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT2CASE24
BANKSEL	ANSELC
	BSF	ANSELC,6,BANKED
;Case 23: Set ANSELC.7 On
	BRA	SYSSELECTEND2
SYSSELECT2CASE24:
	MOVLW	23
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECTEND2
BANKSEL	ANSELC
	BSF	ANSELC,7,BANKED
;End Select  '*** ANSEL Bits should now be set ***
SYSSELECTEND2:
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
BANKSEL	ADCON0
;A8: ASM Source was:  BCF ADCON0,ADCS,BANKED
	BCF	ADCON0,4,BANKED
;ADCLK = 1 ' default to FOSC/2
	MOVLW	1
	MOVWF	ADCLK,BANKED
;Conversion Clock Speed
;SET ADCS OFF  'ADCON0.4
;A8: ASM Source was:  BCF ADCON0,ADCS,BANKED
	BCF	ADCON0,4,BANKED
;ADCLK = 15    'FOSC/16
	MOVLW	15
	MOVWF	ADCLK,BANKED
;Result formatting
;if ADLeftadjust = 0 then  '10-bit
;Set ADCON.2 off     '8-bit
;Set ADFM OFF
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
;Set ADFM0 OFF
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
;End if
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	MOVFF	ADREADPORT,ADPCH
;Enable A/D
;SET ADON ON
;A8: ASM Source was:  BSF ADCON0,ADON,BANKED
	BSF	ADCON0,7,BANKED
;Acquisition Delay
;Wait AD_Delay
	MOVLW	2
	MOVWF	SYSWAITTEMP10US,ACCESS
	BANKSEL	0
	RCALL	DELAY_10US
;Read A/D
;SET GO_NOT_DONE ON
BANKSEL	ADCON0
;A8: ASM Source was:  BSF ADCON0,GO_NOT_DONE,BANKED
	BSF	ADCON0,0,BANKED
;nop
	NOP
;Wait While GO_NOT_DONE ON
SYSWAITLOOP1:
;A8: ASM Source was:  BTFSC ADCON0,GO_NOT_DONE,BANKED
	BTFSC	ADCON0,0,BANKED
	BRA	SYSWAITLOOP1
;Switch off A/D
;SET ADCON0.ADON OFF
;A8: ASM Source was:  BCF ADCON0,ADON,BANKED
	BCF	ADCON0,7,BANKED
;ANSELA = 0
BANKSEL	ANSELA
	CLRF	ANSELA,BANKED
;ANSELB = 0
	CLRF	ANSELB,BANKED
;ANSELC = 0
	CLRF	ANSELC,BANKED
;ReadAD = ADRESH
	MOVFF	ADRESH,READAD
;SET ADFM OFF
BANKSEL	ADCON0
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
