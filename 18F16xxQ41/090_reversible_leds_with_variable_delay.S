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
 ADREADPORT                       EQU 1293
 CHECK_SWITCH                     EQU 1294
 DELAYTEMP                        EQU 1280
 DELAYTEMP2                       EQU 1281
 DIRECTION                        EQU 1295
 LEDS                             EQU 1296
 L_CALIBRATE                      EQU 1297
 L_CALIBRATE_H                    EQU 1298
 L_FROMHIGH                       EQU 1299
 L_FROMHIGH_H                     EQU 1300
 L_FROMLOW                        EQU 1301
 L_FROMLOW_H                      EQU 1302
 L_MAP                            EQU 1303
 L_MAP_H                          EQU 1304
 L_SYSCALC                        EQU 1305
 L_SYSCALCF                       EQU 1307
 L_SYSCALCF_E                     EQU 1310
 L_SYSCALCF_H                     EQU 1308
 L_SYSCALCF_U                     EQU 1309
 L_SYSCALC_H                      EQU 1306
 L_TOHIGH                         EQU 1311
 L_TOHIGH_H                       EQU 1312
 L_TOLOW                          EQU 1313
 L_TOLOW_H                        EQU 1314
 MYDELAY                          EQU 1315
 READAD                           EQU 1316
 SCALE                            EQU 1317
 SCALE_H                          EQU 1318
 SYSBITVAR0                       EQU 1319
 SYSBYTETEMPX                     EQU 1280
 SYSDIVLOOP                       EQU 1284
 SYSLONGDIVMULTA                  EQU 1320
 SYSLONGDIVMULTA_E                EQU 1323
 SYSLONGDIVMULTA_H                EQU 1321
 SYSLONGDIVMULTA_U                EQU 1322
 SYSLONGDIVMULTB                  EQU 1324
 SYSLONGDIVMULTB_E                EQU 1327
 SYSLONGDIVMULTB_H                EQU 1325
 SYSLONGDIVMULTB_U                EQU 1326
 SYSLONGDIVMULTX                  EQU 1328
 SYSLONGDIVMULTX_E                EQU 1331
 SYSLONGDIVMULTX_H                EQU 1329
 SYSLONGDIVMULTX_U                EQU 1330
 SYSLONGTEMPA                     EQU 1285
 SYSLONGTEMPA_E                   EQU 1288
 SYSLONGTEMPA_H                   EQU 1286
 SYSLONGTEMPA_U                   EQU 1287
 SYSLONGTEMPB                     EQU 1289
 SYSLONGTEMPB_E                   EQU 1292
 SYSLONGTEMPB_H                   EQU 1290
 SYSLONGTEMPB_U                   EQU 1291
 SYSLONGTEMPX                     EQU 1280
 SYSLONGTEMPX_E                   EQU 1283
 SYSLONGTEMPX_H                   EQU 1281
 SYSLONGTEMPX_U                   EQU 1282
 SYSTEMP1                         EQU 1332
 SYSTEMP1_E                       EQU 1335
 SYSTEMP1_H                       EQU 1333
 SYSTEMP1_U                       EQU 1334
 SYSTEMP2                         EQU 1336
 SYSTEMP2_H                       EQU 1337
 SYSTEMP3                         EQU 1338
 SYSWAITTEMP10US                  EQU 1285
 SYSWAITTEMPMS                    EQU 1282
 SYSWAITTEMPMS_H                  EQU 1283

;********************************************************************************

;Alias variables
 SYSREADADBYTE                    EQU 1316
 SYSSCALEWORD                     EQU 1317
 SYSSCALEWORD_H                   EQU 1318

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
;' IO:   -----------------SW----------ADC--
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
;Dim mydelay, leds  As Byte
;#DEFINE LED_RIGHT 0
;#DEFINE LED_LEFT  1
;start from the right to left
;direction = LED_RIGHT
	clrf	DIRECTION,ACCESS
;Set the initial LED states - change to suit your configuration
;#DEFINE LEDSTATEMACRO RC0 = 0: RC1 = 0: RC2 = 0: RC3 = 1
;#DEFINE LEDMASK = 0x1111000
;leds = 0b10000
	movlw	16
	movwf	LEDS,ACCESS
;Do
SysDoLoop_S1:
;Get a value for the ADC port
;mydelay = ReadAD( AN0 )
	clrf	ADREADPORT,ACCESS
	call	FN_READAD3
	movff	SYSREADADBYTE,MYDELAY
;mydelay = scale( mydelay, 0, 220, 1, 200 )
	movff	MYDELAY,L_MAP
	clrf	L_MAP_H,ACCESS
	clrf	L_FROMLOW,ACCESS
	clrf	L_FROMLOW_H,ACCESS
	movlw	220
	movwf	L_FROMHIGH,ACCESS
	clrf	L_FROMHIGH_H,ACCESS
	movlw	1
	movwf	L_TOLOW,ACCESS
	clrf	L_TOLOW_H,ACCESS
	movlw	200
	movwf	L_TOHIGH,ACCESS
	clrf	L_TOHIGH_H,ACCESS
	clrf	L_CALIBRATE,ACCESS
	clrf	L_CALIBRATE_H,ACCESS
	call	FN_SCALE71
	movff	SYSSCALEWORD,MYDELAY
;Set the LEDs
;If  direction = LED_RIGHT  Then
	movf	DIRECTION,F,ACCESS
	btfss	STATUS,2,ACCESS
	bra	ELSE1_1
;Rotate the LEDs.  We are only interested in the four LEDs so we mask the other bits.
;Set C Off
	bcf	STATUS,0,ACCESS
;and shift the contents of LEDState
;Rotate leds Right
	rrcf	LEDS,F,ACCESS
;If the LEDState.0is equal to 1 then the sequence has completed, then set the initial state again, the same operation as the starting LED.
;If C = 1 Then
	btfss	STATUS,0,ACCESS
	bra	ENDIF3
;leds = 16
	movlw	16
	movwf	LEDS,ACCESS
;End if
ENDIF3:
;LEDPORT = ( LEDPORT and LEDMASK ) or leds
	clrf	SYSTEMP1,ACCESS
	movf	SYSTEMP1,W,ACCESS
	iorwf	LEDS,W,ACCESS
	movwf	LATC,ACCESS
;Else
	bra	ENDIF1
ELSE1_1:
;Rotate the LEDs.  We are only interested in the four LEDs so we mask the other bits.
;Set C Off
	bcf	STATUS,0,ACCESS
;and shift the contents of LEDState
;Rotate leds Left
	rlcf	LEDS,F,ACCESS
;If the LEDState.0is equal to 1 then the sequence has completed, then set the initial state again, the same operation as the starting LED.
;If leds = 32 Then
	movlw	32
	subwf	LEDS,W,ACCESS
	btfss	STATUS,2,ACCESS
	bra	ENDIF4
;Mask off the other bits
;leds = 1
	movlw	1
	movwf	LEDS,ACCESS
;End If
ENDIF4:
;LEDPORT = ( LEDPORT and LEDMASK ) or leds
	clrf	SYSTEMP1,ACCESS
	movf	SYSTEMP1,W,ACCESS
	iorwf	LEDS,W,ACCESS
	movwf	LATC,ACCESS
;End If
ENDIF1:
;wait, and then check the switch is DOWN
;Wait mydelay ms
	movff	MYDELAY,SYSWAITTEMPMS
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
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1:
;global variable - if button is held down, we don't want to keep on switching directions
;#DEFINE SWITCH_UP   1
;#DEFINE SWITCH_DOWN 0
;Dim previous_state As BIT
;previous_state = SWITCH_UP
	bsf	SYSBITVAR0,0,ACCESS
BASPROGRAMEND:
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

;Source: 090_reversible_LEDS_with_variable_delay.gcb (128)
FN_CHECK_SWITCH:
;switch is normally open to 5V ...when pressed, RA3 is connected to GND
;If (SwitchIn = SWITCH_DOWN) Then
	btfsc	PORTA,3,ACCESS
	bra	ELSE5_1
;debounce by delaying and checking if switch is still pressed
;Wait 1 ms
	movlw	1
	movwf	SYSWAITTEMPMS,ACCESS
	clrf	SYSWAITTEMPMS_H,ACCESS
	call	Delay_MS
;If ( (previous_state =  SWITCH_DOWN) & (SwitchIn = SWITCH_DOWN) ) Then
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
	bra	ELSE6_1
;don't toggle
;check_switch = FALSE
	clrf	CHECK_SWITCH,ACCESS
;Exit Function
	return
;Else
	bra	ENDIF6
ELSE6_1:
;check if still down
;If (SwitchIn = SWITCH_DOWN) Then
	btfsc	PORTA,3,ACCESS
	bra	ELSE7_1
;previous_state = SWITCH_DOWN
	bcf	SYSBITVAR0,0,ACCESS
;reverse the LEDs
;check_switch = TRUE
	setf	CHECK_SWITCH,ACCESS
;Exit Function
	return
;Else
	bra	ENDIF7
ELSE7_1:
;switch not properly held down
;previous_state = SWITCH_UP
	bsf	SYSBITVAR0,0,ACCESS
;don't reverse
;check_switch = FALSE
	clrf	CHECK_SWITCH,ACCESS
;Exit Function
	return
;End If
ENDIF7:
;End If
ENDIF6:
;Else
	bra	ENDIF5
ELSE5_1:
;switch not pressed
;previous_state = SWITCH_UP
	bsf	SYSBITVAR0,0,ACCESS
;don't reverse
;check_switch = FALSE
	clrf	CHECK_SWITCH,ACCESS
;Exit Function
	return
;End If
ENDIF5:
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

;Overloaded signature: WORD:WORD:WORD:WORD:WORD:integer:, Source: stdbasic.h (263)
FN_SCALE71:
;dim l_syscalc as word
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
	movf	L_FROMLOW,W,ACCESS
	subwf	L_MAP,W,ACCESS
	movwf	SYSTEMP1,ACCESS
	movf	L_FROMLOW_H,W,ACCESS
	subwfb	L_MAP_H,W,ACCESS
	movwf	SYSTEMP1_H,ACCESS
	movf	L_TOLOW,W,ACCESS
	subwf	L_TOHIGH,W,ACCESS
	movwf	SYSTEMP2,ACCESS
	movf	L_TOLOW_H,W,ACCESS
	subwfb	L_TOHIGH_H,W,ACCESS
	movwf	SYSTEMP2_H,ACCESS
	movff	SYSTEMP1,SYSLONGTEMPA
	movff	SYSTEMP1_H,SYSLONGTEMPA_H
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
	movff	SYSTEMP2,SYSLONGTEMPB
	movff	SYSTEMP2_H,SYSLONGTEMPB_H
	clrf	SYSLONGTEMPB_U,ACCESS
	clrf	SYSLONGTEMPB_E,ACCESS
	call	SYSMULTSUB32
	movff	SYSLONGTEMPX,L_SYSCALCF
	movff	SYSLONGTEMPX_H,L_SYSCALCF_H
	movff	SYSLONGTEMPX_U,L_SYSCALCF_U
	movff	SYSLONGTEMPX_E,L_SYSCALCF_E
;l_syscalc = (  l_fromHigh - l_fromLow )
	movf	L_FROMLOW,W,ACCESS
	subwf	L_FROMHIGH,W,ACCESS
	movwf	L_SYSCALC,ACCESS
	movf	L_FROMLOW_H,W,ACCESS
	subwfb	L_FROMHIGH_H,W,ACCESS
	movwf	L_SYSCALC_H,ACCESS
;scale = (l_syscalcf / l_syscalc) + l_toLow + l_calibrate
	movff	L_SYSCALCF,SYSLONGTEMPA
	movff	L_SYSCALCF_H,SYSLONGTEMPA_H
	movff	L_SYSCALCF_U,SYSLONGTEMPA_U
	movff	L_SYSCALCF_E,SYSLONGTEMPA_E
	movff	L_SYSCALC,SYSLONGTEMPB
	movff	L_SYSCALC_H,SYSLONGTEMPB_H
	clrf	SYSLONGTEMPB_U,ACCESS
	clrf	SYSLONGTEMPB_E,ACCESS
	call	SYSDIVSUB32
	movff	SYSLONGTEMPA,SYSTEMP1
	movff	SYSLONGTEMPA_H,SYSTEMP1_H
	movff	SYSLONGTEMPA_U,SYSTEMP1_U
	movff	SYSLONGTEMPA_E,SYSTEMP1_E
	movf	L_TOLOW,W,ACCESS
	addwf	SYSTEMP1,W,ACCESS
	movwf	SYSTEMP2,ACCESS
	movf	L_TOLOW_H,W,ACCESS
	addwfc	SYSTEMP1_H,W,ACCESS
	movwf	SYSTEMP2_H,ACCESS
	movf	L_CALIBRATE,W,ACCESS
	addwf	SYSTEMP2,W,ACCESS
	movwf	SCALE,ACCESS
	movf	L_CALIBRATE_H,W,ACCESS
	addwfc	SYSTEMP2_H,W,ACCESS
	movwf	SCALE_H,ACCESS
	return

;********************************************************************************

;Source: system.h (2946)
SYSCOMPEQUAL32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysLongTempB, W
	movf	SYSLONGTEMPB, W,ACCESS
;cpfseq SysLongTempA
	cpfseq	SYSLONGTEMPA,ACCESS
;return
	return
;Test high, exit if false
;movf SysLongTempB_H, W
	movf	SYSLONGTEMPB_H, W,ACCESS
;cpfseq SysLongTempA_H
	cpfseq	SYSLONGTEMPA_H,ACCESS
;return
	return
;Test upper, exit if false
;movf SysLongTempB_U, W
	movf	SYSLONGTEMPB_U, W,ACCESS
;cpfseq SysLongTempA_U
	cpfseq	SYSLONGTEMPA_U,ACCESS
;return
	return
;Test exp, exit if false
;movf SysLongTempB_E, W
	movf	SYSLONGTEMPB_E, W,ACCESS
;cpfseq SysLongTempA_E
	cpfseq	SYSLONGTEMPA_E,ACCESS
;return
	return
;setf SysByteTempX
	setf	SYSBYTETEMPX,ACCESS
	return

;********************************************************************************

;Source: system.h (3121)
SYSCOMPLESSTHAN32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	clrf	SYSBYTETEMPX,ACCESS
;Test Exp, exit if more
;movf SysLongTempA_E,W
	movf	SYSLONGTEMPA_E,W,ACCESS
;subwf SysLongTempB_E,W
	subwf	SYSLONGTEMPB_E,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,0,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	movf	SYSLONGTEMPA_U,W,ACCESS
;subwf SysLongTempB_U,W
	subwf	SYSLONGTEMPB_U,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,0,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	movf	SYSLONGTEMPA_H,W,ACCESS
;subwf SysLongTempB_H,W
	subwf	SYSLONGTEMPB_H,W,ACCESS
;btfss STATUS,C
	btfss	STATUS,0,ACCESS
;return
	return
;If not more and not zero, is less
;bnz SCLT32True
	bnz	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	movf	SYSLONGTEMPB,W,ACCESS
;subwf SysLongTempA,W
	subwf	SYSLONGTEMPA,W,ACCESS
;btfsc STATUS,C
	btfsc	STATUS,0,ACCESS
;return
	return
SCLT32TRUE:
;comf SysByteTempX,F
	comf	SYSBYTETEMPX,F,ACCESS
	return

;********************************************************************************

;Source: system.h (2786)
SYSDIVSUB32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	movff	SYSLONGTEMPA,SYSLONGDIVMULTA
	movff	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	movff	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	movff	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movff	SYSLONGTEMPB,SYSLONGDIVMULTB
	movff	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	movff	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	movff	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX,ACCESS
	clrf	SYSLONGDIVMULTX_H,ACCESS
	clrf	SYSLONGDIVMULTX_U,ACCESS
	clrf	SYSLONGDIVMULTX_E,ACCESS
;Avoid division by zero
;if SysLongDivMultB = 0 then
	movff	SYSLONGDIVMULTB,SYSLONGTEMPA
	movff	SYSLONGDIVMULTB_H,SYSLONGTEMPA_H
	movff	SYSLONGDIVMULTB_U,SYSLONGTEMPA_U
	movff	SYSLONGDIVMULTB_E,SYSLONGTEMPA_E
	clrf	SYSLONGTEMPB,ACCESS
	clrf	SYSLONGTEMPB_H,ACCESS
	clrf	SYSLONGTEMPB_U,ACCESS
	clrf	SYSLONGTEMPB_E,ACCESS
	call	SYSCOMPEQUAL32
	btfss	SYSBYTETEMPX,0,ACCESS
	bra	ENDIF11
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF11:
;Main calc routine
;SysDivLoop = 32
	movlw	32
	movwf	SYSDIVLOOP,ACCESS
SYSDIV32START:
;set C off
	bcf	STATUS,0,ACCESS
;Rotate SysLongDivMultA Left
	rlcf	SYSLONGDIVMULTA,F,ACCESS
	rlcf	SYSLONGDIVMULTA_H,F,ACCESS
	rlcf	SYSLONGDIVMULTA_U,F,ACCESS
	rlcf	SYSLONGDIVMULTA_E,F,ACCESS
;Rotate SysLongDivMultX Left
	rlcf	SYSLONGDIVMULTX,F,ACCESS
	rlcf	SYSLONGDIVMULTX_H,F,ACCESS
	rlcf	SYSLONGDIVMULTX_U,F,ACCESS
	rlcf	SYSLONGDIVMULTX_E,F,ACCESS
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,ACCESS
	subwf	SYSLONGDIVMULTX,F,ACCESS
	movf	SYSLONGDIVMULTB_H,W,ACCESS
	subwfb	SYSLONGDIVMULTX_H,F,ACCESS
	movf	SYSLONGDIVMULTB_U,W,ACCESS
	subwfb	SYSLONGDIVMULTX_U,F,ACCESS
	movf	SYSLONGDIVMULTB_E,W,ACCESS
	subwfb	SYSLONGDIVMULTX_E,F,ACCESS
;Set SysLongDivMultA.0 On
	bsf	SYSLONGDIVMULTA,0,ACCESS
;If C Off Then
	btfsc	STATUS,0,ACCESS
	bra	ENDIF12
;Set SysLongDivMultA.0 Off
	bcf	SYSLONGDIVMULTA,0,ACCESS
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	movf	SYSLONGDIVMULTB,W,ACCESS
	addwf	SYSLONGDIVMULTX,F,ACCESS
	movf	SYSLONGDIVMULTB_H,W,ACCESS
	addwfc	SYSLONGDIVMULTX_H,F,ACCESS
	movf	SYSLONGDIVMULTB_U,W,ACCESS
	addwfc	SYSLONGDIVMULTX_U,F,ACCESS
	movf	SYSLONGDIVMULTB_E,W,ACCESS
	addwfc	SYSLONGDIVMULTX_E,F,ACCESS
;End If
ENDIF12:
;decfsz SysDivLoop, F
	decfsz	SYSDIVLOOP, F,ACCESS
;goto SysDiv32Start
	bra	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	movff	SYSLONGDIVMULTA,SYSLONGTEMPA
	movff	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	movff	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	movff	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	movff	SYSLONGDIVMULTX,SYSLONGTEMPX
	movff	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	movff	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	movff	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
	return

;********************************************************************************

;Source: system.h (2582)
SYSMULTSUB32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;Can't use normal SysDivMult variables for 32 bit, they overlap with
;SysLongTemp variables
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;SysLongDivMultA = SysLongTempA
	movff	SYSLONGTEMPA,SYSLONGDIVMULTA
	movff	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	movff	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	movff	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	movff	SYSLONGTEMPB,SYSLONGDIVMULTB
	movff	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	movff	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	movff	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	clrf	SYSLONGDIVMULTX,ACCESS
	clrf	SYSLONGDIVMULTX_H,ACCESS
	clrf	SYSLONGDIVMULTX_U,ACCESS
	clrf	SYSLONGDIVMULTX_E,ACCESS
MUL32LOOP:
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	btfss	SYSLONGDIVMULTB,0,ACCESS
	bra	ENDIF9
	movf	SYSLONGDIVMULTA,W,ACCESS
	addwf	SYSLONGDIVMULTX,F,ACCESS
	movf	SYSLONGDIVMULTA_H,W,ACCESS
	addwfc	SYSLONGDIVMULTX_H,F,ACCESS
	movf	SYSLONGDIVMULTA_U,W,ACCESS
	addwfc	SYSLONGDIVMULTX_U,F,ACCESS
	movf	SYSLONGDIVMULTA_E,W,ACCESS
	addwfc	SYSLONGDIVMULTX_E,F,ACCESS
ENDIF9:
;set STATUS.C OFF
	bcf	STATUS,0,ACCESS
;rotate SysLongDivMultB right
	rrcf	SYSLONGDIVMULTB_E,F,ACCESS
	rrcf	SYSLONGDIVMULTB_U,F,ACCESS
	rrcf	SYSLONGDIVMULTB_H,F,ACCESS
	rrcf	SYSLONGDIVMULTB,F,ACCESS
;set STATUS.C off
	bcf	STATUS,0,ACCESS
;rotate SysLongDivMultA left
	rlcf	SYSLONGDIVMULTA,F,ACCESS
	rlcf	SYSLONGDIVMULTA_H,F,ACCESS
	rlcf	SYSLONGDIVMULTA_U,F,ACCESS
	rlcf	SYSLONGDIVMULTA_E,F,ACCESS
;if SysLongDivMultB > 0 then goto MUL32LOOP
	movff	SYSLONGDIVMULTB,SYSLONGTEMPB
	movff	SYSLONGDIVMULTB_H,SYSLONGTEMPB_H
	movff	SYSLONGDIVMULTB_U,SYSLONGTEMPB_U
	movff	SYSLONGDIVMULTB_E,SYSLONGTEMPB_E
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
	call	SYSCOMPLESSTHAN32
	btfsc	SYSBYTETEMPX,0,ACCESS
	bra	MUL32LOOP
;SysLongTempX = SysLongDivMultX
	movff	SYSLONGDIVMULTX,SYSLONGTEMPX
	movff	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	movff	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	movff	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
	return

;********************************************************************************

;
; Declare Power-On-Reset entry point
;
 END     resetVec
