;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\090_reversible_leds_with_variable_delay.S"
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
 ADREADPORT                       EQU 1293                    ; 0X50D
 CHECK_SWITCH                     EQU 1294                    ; 0X50E
 DELAYTEMP                        EQU 1280                    ; 0X500
 DELAYTEMP2                       EQU 1281                    ; 0X501
 DIRECTION                        EQU 1295                    ; 0X50F
 LEDS                             EQU 1296                    ; 0X510
 L_CALIBRATE                      EQU 1297                    ; 0X511
 L_CALIBRATE_H                    EQU 1298                    ; 0X512
 L_FROMHIGH                       EQU 1299                    ; 0X513
 L_FROMHIGH_H                     EQU 1300                    ; 0X514
 L_FROMLOW                        EQU 1301                    ; 0X515
 L_FROMLOW_H                      EQU 1302                    ; 0X516
 L_MAP                            EQU 1303                    ; 0X517
 L_MAP_H                          EQU 1304                    ; 0X518
 L_SYSCALC                        EQU 1305                    ; 0X519
 L_SYSCALCF                       EQU 1307                    ; 0X51B
 L_SYSCALCF_E                     EQU 1310                    ; 0X51E
 L_SYSCALCF_H                     EQU 1308                    ; 0X51C
 L_SYSCALCF_U                     EQU 1309                    ; 0X51D
 L_SYSCALC_H                      EQU 1306                    ; 0X51A
 L_TOHIGH                         EQU 1311                    ; 0X51F
 L_TOHIGH_H                       EQU 1312                    ; 0X520
 L_TOLOW                          EQU 1313                    ; 0X521
 L_TOLOW_H                        EQU 1314                    ; 0X522
 MYDELAY                          EQU 1315                    ; 0X523
 READAD                           EQU 1316                    ; 0X524
 SCALE                            EQU 1317                    ; 0X525
 SCALE_H                          EQU 1318                    ; 0X526
 SYSBITVAR0                       EQU 1319                    ; 0X527
 SYSBYTETEMPX                     EQU 1280                    ; 0X500
 SYSDIVLOOP                       EQU 1284                    ; 0X504
 SYSLONGDIVMULTA                  EQU 1320                    ; 0X528
 SYSLONGDIVMULTA_E                EQU 1323                    ; 0X52B
 SYSLONGDIVMULTA_H                EQU 1321                    ; 0X529
 SYSLONGDIVMULTA_U                EQU 1322                    ; 0X52A
 SYSLONGDIVMULTB                  EQU 1324                    ; 0X52C
 SYSLONGDIVMULTB_E                EQU 1327                    ; 0X52F
 SYSLONGDIVMULTB_H                EQU 1325                    ; 0X52D
 SYSLONGDIVMULTB_U                EQU 1326                    ; 0X52E
 SYSLONGDIVMULTX                  EQU 1328                    ; 0X530
 SYSLONGDIVMULTX_E                EQU 1331                    ; 0X533
 SYSLONGDIVMULTX_H                EQU 1329                    ; 0X531
 SYSLONGDIVMULTX_U                EQU 1330                    ; 0X532
 SYSLONGTEMPA                     EQU 1285                    ; 0X505
 SYSLONGTEMPA_E                   EQU 1288                    ; 0X508
 SYSLONGTEMPA_H                   EQU 1286                    ; 0X506
 SYSLONGTEMPA_U                   EQU 1287                    ; 0X507
 SYSLONGTEMPB                     EQU 1289                    ; 0X509
 SYSLONGTEMPB_E                   EQU 1292                    ; 0X50C
 SYSLONGTEMPB_H                   EQU 1290                    ; 0X50A
 SYSLONGTEMPB_U                   EQU 1291                    ; 0X50B
 SYSLONGTEMPX                     EQU 1280                    ; 0X500
 SYSLONGTEMPX_E                   EQU 1283                    ; 0X503
 SYSLONGTEMPX_H                   EQU 1281                    ; 0X501
 SYSLONGTEMPX_U                   EQU 1282                    ; 0X502
 SYSTEMP1                         EQU 1332                    ; 0X534
 SYSTEMP1_E                       EQU 1335                    ; 0X537
 SYSTEMP1_H                       EQU 1333                    ; 0X535
 SYSTEMP1_U                       EQU 1334                    ; 0X536
 SYSTEMP2                         EQU 1336                    ; 0X538
 SYSTEMP2_H                       EQU 1337                    ; 0X539
 SYSTEMP3                         EQU 1338                    ; 0X53A
 SYSWAITTEMP10US                  EQU 1285                    ; 0X505
 SYSWAITTEMPMS                    EQU 1282                    ; 0X502
 SYSWAITTEMPMS_H                  EQU 1283                    ; 0X503

;********************************************************************************

;ALIAS VARIABLES
 SYSREADADBYTE                    EQU 1316
 SYSSCALEWORD                     EQU 1317
 SYSSCALEWORD_H                   EQU 1318

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
	BCF	TRISC,0,ACCESS
;Dir     RC1         Out
	BCF	TRISC,1,ACCESS
;Dir     RC2         Out
	BCF	TRISC,2,ACCESS
;Dir     RC3         Out
	BCF	TRISC,3,ACCESS
;#DEFINE POTENTIOMETER PORTA.0
;Dir     POTENTIOMETER In
	BSF	TRISA,0,ACCESS
;#DEFINE SWITCHIN      PORTA.3
;Dir     SWITCHIN      In
	BSF	TRISA,3,ACCESS
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
	CLRF	DIRECTION,ACCESS
;Set the initial LED states - change to suit your configuration
;#DEFINE LEDSTATEMACRO RC0 = 0: RC1 = 0: RC2 = 0: RC3 = 1
;#DEFINE LEDMASK = 0x1111000
;leds = 0b10000
	MOVLW	16
	MOVWF	LEDS,ACCESS
;Do
SYSDOLOOP_S1:
;Get a value for the ADC port
;mydelay = ReadAD( AN0 )
	CLRF	ADREADPORT,ACCESS
	RCALL	FN_READAD5
	MOVFF	SYSREADADBYTE,MYDELAY
;mydelay = scale( mydelay, 0, 220, 1, 200 )
	MOVFF	MYDELAY,L_MAP
	CLRF	L_MAP_H,ACCESS
	CLRF	L_FROMLOW,ACCESS
	CLRF	L_FROMLOW_H,ACCESS
	MOVLW	220
	MOVWF	L_FROMHIGH,ACCESS
	CLRF	L_FROMHIGH_H,ACCESS
	MOVLW	1
	MOVWF	L_TOLOW,ACCESS
	CLRF	L_TOLOW_H,ACCESS
	MOVLW	200
	MOVWF	L_TOHIGH,ACCESS
	CLRF	L_TOHIGH_H,ACCESS
	CLRF	L_CALIBRATE,ACCESS
	CLRF	L_CALIBRATE_H,ACCESS
	RCALL	FN_SCALE73
	MOVFF	SYSSCALEWORD,MYDELAY
;Set the LEDs
;If  direction = LED_RIGHT  Then
	MOVF	DIRECTION,F,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ELSE1_1
;Rotate the LEDs.  We are only interested in the four LEDs so we mask the other bits.
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;and shift the contents of LEDState
;Rotate leds Right
	RRCF	LEDS,F,ACCESS
;If the LEDState.0is equal to 1 then the sequence has completed, then set the initial state again, the same operation as the starting LED.
;If C = 1 Then
;A8: ASM Source was:  BTFSS STATUS,C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	ENDIF3
;leds = 16
	MOVLW	16
	MOVWF	LEDS,ACCESS
;End if
ENDIF3:
;LEDPORT = ( LEDPORT and LEDMASK ) or leds
	CLRF	SYSTEMP1,ACCESS
	MOVF	SYSTEMP1,W,ACCESS
	IORWF	LEDS,W,ACCESS
	MOVWF	LATC,ACCESS
;Else
	BRA	ENDIF1
ELSE1_1:
;Rotate the LEDs.  We are only interested in the four LEDs so we mask the other bits.
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;and shift the contents of LEDState
;Rotate leds Left
	RLCF	LEDS,F,ACCESS
;If the LEDState.0is equal to 1 then the sequence has completed, then set the initial state again, the same operation as the starting LED.
;If leds = 32 Then
	MOVLW	32
	SUBWF	LEDS,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF4
;Mask off the other bits
;leds = 1
	MOVLW	1
	MOVWF	LEDS,ACCESS
;End If
ENDIF4:
;LEDPORT = ( LEDPORT and LEDMASK ) or leds
	CLRF	SYSTEMP1,ACCESS
	MOVF	SYSTEMP1,W,ACCESS
	IORWF	LEDS,W,ACCESS
	MOVWF	LATC,ACCESS
;End If
ENDIF1:
;wait, and then check the switch is DOWN
;Wait mydelay ms
	MOVFF	MYDELAY,SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	RCALL	DELAY_MS
;If check_switch = TRUE Then
	RCALL	FN_CHECK_SWITCH
	INCF	CHECK_SWITCH,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
;toggle the direction
;direction = !direction
	COMF	DIRECTION,F,ACCESS
;End If
;Loop
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1:
;global variable - if button is held down, we don't want to keep on switching directions
;#DEFINE SWITCH_UP   1
;#DEFINE SWITCH_DOWN 0
;Dim previous_state As BIT
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0,ACCESS
BASPROGRAMEND:
	SLEEP
	BRA	BASPROGRAMEND

;********************************************************************************

;SOURCE: 090_REVERSIBLE_LEDS_WITH_VARIABLE_DELAY.GCB (128)
FN_CHECK_SWITCH:
;switch is normally open to 5V ...when pressed, RA3 is connected to GND
;If (SwitchIn = SWITCH_DOWN) Then
	BTFSC	PORTA,3,ACCESS
	BRA	ELSE5_1
;debounce by delaying and checking if switch is still pressed
;Wait 1 ms
	MOVLW	1
	MOVWF	SYSWAITTEMPMS,ACCESS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	RCALL	DELAY_MS
;If ( (previous_state =  SWITCH_DOWN) & (SwitchIn = SWITCH_DOWN) ) Then
	CLRF	SYSBYTETEMPX,ACCESS
	BTFSS	SYSBITVAR0,0,ACCESS
	COMF	SYSBYTETEMPX,F,ACCESS
	MOVFF	SYSBYTETEMPX,SYSTEMP1
	CLRF	SYSBYTETEMPX,ACCESS
	BTFSS	PORTA,3,ACCESS
	COMF	SYSBYTETEMPX,F,ACCESS
	MOVFF	SYSBYTETEMPX,SYSTEMP2
	MOVF	SYSTEMP1,W,ACCESS
	ANDWF	SYSTEMP2,W,ACCESS
	MOVWF	SYSTEMP3,ACCESS
	BTFSS	SYSTEMP3,0,ACCESS
	BRA	ELSE6_1
;don't toggle
;check_switch = FALSE
	CLRF	CHECK_SWITCH,ACCESS
;Exit Function
	RETURN
;Else
	BRA	ENDIF6
ELSE6_1:
;check if still down
;If (SwitchIn = SWITCH_DOWN) Then
	BTFSC	PORTA,3,ACCESS
	BRA	ELSE7_1
;previous_state = SWITCH_DOWN
	BCF	SYSBITVAR0,0,ACCESS
;reverse the LEDs
;check_switch = TRUE
	SETF	CHECK_SWITCH,ACCESS
;Exit Function
	RETURN
;Else
	BRA	ENDIF7
ELSE7_1:
;switch not properly held down
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0,ACCESS
;don't reverse
;check_switch = FALSE
	CLRF	CHECK_SWITCH,ACCESS
;Exit Function
	RETURN
;End If
ENDIF7:
;End If
ENDIF6:
;Else
	BRA	ENDIF5
ELSE5_1:
;switch not pressed
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0,ACCESS
;don't reverse
;check_switch = FALSE
	CLRF	CHECK_SWITCH,ACCESS
;Exit Function
	RETURN
;End If
ENDIF5:
	RETURN

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
FN_READAD5:
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
SYSSELECT1CASE1:
	MOVF	ADREADPORT,F,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE2
BANKSEL	ANSELA
	BSF	ANSELA,0,BANKED
;Case 1: Set ANSELA.1 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE2:
	DECF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE3
BANKSEL	ANSELA
	BSF	ANSELA,1,BANKED
;Case 2: Set ANSELA.2 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE3:
	MOVLW	2
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE4
BANKSEL	ANSELA
	BSF	ANSELA,2,BANKED
;Case 3: Set ANSELA.3 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE4:
	MOVLW	3
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE5
BANKSEL	ANSELA
	BSF	ANSELA,3,BANKED
;Case 4: Set ANSELA.4 ON
	BRA	SYSSELECTEND1
SYSSELECT1CASE5:
	MOVLW	4
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE6
BANKSEL	ANSELA
	BSF	ANSELA,4,BANKED
;Case 5: Set ANSELA.5 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE6:
	MOVLW	5
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE7
BANKSEL	ANSELA
	BSF	ANSELA,5,BANKED
;Case 6: Set ANSELA.6 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE7:
	MOVLW	6
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE8
BANKSEL	ANSELA
	BSF	ANSELA,6,BANKED
;Case 7: Set ANSELA.7 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE8:
	MOVLW	7
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE9
BANKSEL	ANSELA
	BSF	ANSELA,7,BANKED
;Case 8: Set ANSELB.0 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE9:
	MOVLW	8
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE10
BANKSEL	ANSELB
	BSF	ANSELB,0,BANKED
;Case 9: Set ANSELB.1 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE10:
	MOVLW	9
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE11
BANKSEL	ANSELB
	BSF	ANSELB,1,BANKED
;Case 10: Set ANSELB.2 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE11:
	MOVLW	10
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE12
BANKSEL	ANSELB
	BSF	ANSELB,2,BANKED
;Case 11: Set ANSELB.3 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE12:
	MOVLW	11
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE13
BANKSEL	ANSELB
	BSF	ANSELB,3,BANKED
;Case 12: Set ANSELB.4 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE13:
	MOVLW	12
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE14
BANKSEL	ANSELB
	BSF	ANSELB,4,BANKED
;Case 13: Set ANSELB.5 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE14:
	MOVLW	13
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE15
BANKSEL	ANSELB
	BSF	ANSELB,5,BANKED
;Case 14: Set ANSELB.6 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE15:
	MOVLW	14
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE16
BANKSEL	ANSELB
	BSF	ANSELB,6,BANKED
;Case 15: Set ANSELB.7 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE16:
	MOVLW	15
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE17
BANKSEL	ANSELB
	BSF	ANSELB,7,BANKED
;Case 16: Set ANSELC.0 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE17:
	MOVLW	16
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE18
BANKSEL	ANSELC
	BSF	ANSELC,0,BANKED
;Case 17: Set ANSELC.1 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE18:
	MOVLW	17
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE19
BANKSEL	ANSELC
	BSF	ANSELC,1,BANKED
;Case 18: Set ANSELC.2 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE19:
	MOVLW	18
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE20
BANKSEL	ANSELC
	BSF	ANSELC,2,BANKED
;Case 19: Set ANSELC.3 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE20:
	MOVLW	19
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE21
BANKSEL	ANSELC
	BSF	ANSELC,3,BANKED
;Case 20: Set ANSELC.4 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE21:
	MOVLW	20
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE22
BANKSEL	ANSELC
	BSF	ANSELC,4,BANKED
;Case 21: Set ANSELC.5 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE22:
	MOVLW	21
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE23
BANKSEL	ANSELC
	BSF	ANSELC,5,BANKED
;Case 22: Set ANSELC.6 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE23:
	MOVLW	22
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECT1CASE24
BANKSEL	ANSELC
	BSF	ANSELC,6,BANKED
;Case 23: Set ANSELC.7 On
	BRA	SYSSELECTEND1
SYSSELECT1CASE24:
	MOVLW	23
	SUBWF	ADREADPORT,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	SYSSELECTEND1
BANKSEL	ANSELC
	BSF	ANSELC,7,BANKED
;End Select  '*** ANSEL Bits should now be set ***
SYSSELECTEND1:
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

;OVERLOADED SIGNATURE: WORD:WORD:WORD:WORD:WORD:INTEGER:, SOURCE: STDBASIC.H (263)
FN_SCALE73:
;dim l_syscalc as word
;dim l_syscalcF as long
;l_syscalcf =  [long]( l_map - l_fromLow ) * [long](l_toHigh   - l_toLow)
	MOVF	L_FROMLOW,W,ACCESS
	SUBWF	L_MAP,W,ACCESS
	MOVWF	SYSTEMP1,ACCESS
	MOVF	L_FROMLOW_H,W,ACCESS
	SUBWFB	L_MAP_H,W,ACCESS
	MOVWF	SYSTEMP1_H,ACCESS
	MOVF	L_TOLOW,W,ACCESS
	SUBWF	L_TOHIGH,W,ACCESS
	MOVWF	SYSTEMP2,ACCESS
	MOVF	L_TOLOW_H,W,ACCESS
	SUBWFB	L_TOHIGH_H,W,ACCESS
	MOVWF	SYSTEMP2_H,ACCESS
	MOVFF	SYSTEMP1,SYSLONGTEMPA
	MOVFF	SYSTEMP1_H,SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
	MOVFF	SYSTEMP2,SYSLONGTEMPB
	MOVFF	SYSTEMP2_H,SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSMULTSUB32
	MOVFF	SYSLONGTEMPX,L_SYSCALCF
	MOVFF	SYSLONGTEMPX_H,L_SYSCALCF_H
	MOVFF	SYSLONGTEMPX_U,L_SYSCALCF_U
	MOVFF	SYSLONGTEMPX_E,L_SYSCALCF_E
;l_syscalc = (  l_fromHigh - l_fromLow )
	MOVF	L_FROMLOW,W,ACCESS
	SUBWF	L_FROMHIGH,W,ACCESS
	MOVWF	L_SYSCALC,ACCESS
	MOVF	L_FROMLOW_H,W,ACCESS
	SUBWFB	L_FROMHIGH_H,W,ACCESS
	MOVWF	L_SYSCALC_H,ACCESS
;scale = (l_syscalcf / l_syscalc) + l_toLow + l_calibrate
	MOVFF	L_SYSCALCF,SYSLONGTEMPA
	MOVFF	L_SYSCALCF_H,SYSLONGTEMPA_H
	MOVFF	L_SYSCALCF_U,SYSLONGTEMPA_U
	MOVFF	L_SYSCALCF_E,SYSLONGTEMPA_E
	MOVFF	L_SYSCALC,SYSLONGTEMPB
	MOVFF	L_SYSCALC_H,SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSDIVSUB32
	MOVFF	SYSLONGTEMPA,SYSTEMP1
	MOVFF	SYSLONGTEMPA_H,SYSTEMP1_H
	MOVFF	SYSLONGTEMPA_U,SYSTEMP1_U
	MOVFF	SYSLONGTEMPA_E,SYSTEMP1_E
	MOVF	L_TOLOW,W,ACCESS
	ADDWF	SYSTEMP1,W,ACCESS
	MOVWF	SYSTEMP2,ACCESS
	MOVF	L_TOLOW_H,W,ACCESS
	ADDWFC	SYSTEMP1_H,W,ACCESS
	MOVWF	SYSTEMP2_H,ACCESS
	MOVF	L_CALIBRATE,W,ACCESS
	ADDWF	SYSTEMP2,W,ACCESS
	MOVWF	SCALE,ACCESS
	MOVF	L_CALIBRATE_H,W,ACCESS
	ADDWFC	SYSTEMP2_H,W,ACCESS
	MOVWF	SCALE_H,ACCESS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2948)
SYSCOMPEQUAL32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX,ACCESS
;Test low, exit if false
;movf SysLongTempB, W
	MOVF	SYSLONGTEMPB, W,ACCESS
;cpfseq SysLongTempA
	CPFSEQ	SYSLONGTEMPA,ACCESS
;return
	RETURN
;Test high, exit if false
;movf SysLongTempB_H, W
	MOVF	SYSLONGTEMPB_H, W,ACCESS
;cpfseq SysLongTempA_H
	CPFSEQ	SYSLONGTEMPA_H,ACCESS
;return
	RETURN
;Test upper, exit if false
;movf SysLongTempB_U, W
	MOVF	SYSLONGTEMPB_U, W,ACCESS
;cpfseq SysLongTempA_U
	CPFSEQ	SYSLONGTEMPA_U,ACCESS
;return
	RETURN
;Test exp, exit if false
;movf SysLongTempB_E, W
	MOVF	SYSLONGTEMPB_E, W,ACCESS
;cpfseq SysLongTempA_E
	CPFSEQ	SYSLONGTEMPA_E,ACCESS
;return
	RETURN
;setf SysByteTempX
	SETF	SYSBYTETEMPX,ACCESS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3123)
SYSCOMPLESSTHAN32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX,ACCESS
;Test Exp, exit if more
;movf SysLongTempA_E,W
	MOVF	SYSLONGTEMPA_E,W,ACCESS
;subwf SysLongTempB_E,W
	SUBWF	SYSLONGTEMPB_E,W,ACCESS
;btfss STATUS,C
;A8: ASM Source was:  BTFSS STATUS,C,ACCESS
	BTFSS	STATUS,0,ACCESS
;return
	RETURN
;If not more and not zero, is less
;bnz SCLT32True
	BNZ	SCLT32TRUE
;Test Upper, exit if more
;movf SysLongTempA_U,W
	MOVF	SYSLONGTEMPA_U,W,ACCESS
;subwf SysLongTempB_U,W
	SUBWF	SYSLONGTEMPB_U,W,ACCESS
;btfss STATUS,C
;A8: ASM Source was:  BTFSS STATUS,C,ACCESS
	BTFSS	STATUS,0,ACCESS
;return
	RETURN
;If not more and not zero, is less
;bnz SCLT32True
	BNZ	SCLT32TRUE
;Test High, exit if more
;movf SysLongTempA_H,W
	MOVF	SYSLONGTEMPA_H,W,ACCESS
;subwf SysLongTempB_H,W
	SUBWF	SYSLONGTEMPB_H,W,ACCESS
;btfss STATUS,C
;A8: ASM Source was:  BTFSS STATUS,C,ACCESS
	BTFSS	STATUS,0,ACCESS
;return
	RETURN
;If not more and not zero, is less
;bnz SCLT32True
	BNZ	SCLT32TRUE
;Test Low, exit if more or equal
;movf SysLongTempB,W
	MOVF	SYSLONGTEMPB,W,ACCESS
;subwf SysLongTempA,W
	SUBWF	SYSLONGTEMPA,W,ACCESS
;btfsc STATUS,C
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
;return
	RETURN
SCLT32TRUE:
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F,ACCESS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2788)
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
	MOVFF	SYSLONGTEMPA,SYSLONGDIVMULTA
	MOVFF	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	MOVFF	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	MOVFF	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	MOVFF	SYSLONGTEMPB,SYSLONGDIVMULTB
	MOVFF	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	MOVFF	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	MOVFF	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	CLRF	SYSLONGDIVMULTX,ACCESS
	CLRF	SYSLONGDIVMULTX_H,ACCESS
	CLRF	SYSLONGDIVMULTX_U,ACCESS
	CLRF	SYSLONGDIVMULTX_E,ACCESS
;Avoid division by zero
;if SysLongDivMultB = 0 then
	MOVFF	SYSLONGDIVMULTB,SYSLONGTEMPA
	MOVFF	SYSLONGDIVMULTB_H,SYSLONGTEMPA_H
	MOVFF	SYSLONGDIVMULTB_U,SYSLONGTEMPA_U
	MOVFF	SYSLONGDIVMULTB_E,SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB,ACCESS
	CLRF	SYSLONGTEMPB_H,ACCESS
	CLRF	SYSLONGTEMPB_U,ACCESS
	CLRF	SYSLONGTEMPB_E,ACCESS
	RCALL	SYSCOMPEQUAL32
	BTFSS	SYSBYTETEMPX,0,ACCESS
	BRA	ENDIF11
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA,ACCESS
	CLRF	SYSLONGTEMPA_H,ACCESS
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
;exit sub
	RETURN
;end if
ENDIF11:
;Main calc routine
;SysDivLoop = 32
	MOVLW	32
	MOVWF	SYSDIVLOOP,ACCESS
SYSDIV32START:
;set C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;Rotate SysLongDivMultA Left
	RLCF	SYSLONGDIVMULTA,F,ACCESS
	RLCF	SYSLONGDIVMULTA_H,F,ACCESS
	RLCF	SYSLONGDIVMULTA_U,F,ACCESS
	RLCF	SYSLONGDIVMULTA_E,F,ACCESS
;Rotate SysLongDivMultX Left
	RLCF	SYSLONGDIVMULTX,F,ACCESS
	RLCF	SYSLONGDIVMULTX_H,F,ACCESS
	RLCF	SYSLONGDIVMULTX_U,F,ACCESS
	RLCF	SYSLONGDIVMULTX_E,F,ACCESS
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	MOVF	SYSLONGDIVMULTB,W,ACCESS
	SUBWF	SYSLONGDIVMULTX,F,ACCESS
	MOVF	SYSLONGDIVMULTB_H,W,ACCESS
	SUBWFB	SYSLONGDIVMULTX_H,F,ACCESS
	MOVF	SYSLONGDIVMULTB_U,W,ACCESS
	SUBWFB	SYSLONGDIVMULTX_U,F,ACCESS
	MOVF	SYSLONGDIVMULTB_E,W,ACCESS
	SUBWFB	SYSLONGDIVMULTX_E,F,ACCESS
;Set SysLongDivMultA.0 On
	BSF	SYSLONGDIVMULTA,0,ACCESS
;If C Off Then
;A8: ASM Source was:  BTFSC STATUS,C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ENDIF12
;Set SysLongDivMultA.0 Off
	BCF	SYSLONGDIVMULTA,0,ACCESS
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	MOVF	SYSLONGDIVMULTB,W,ACCESS
	ADDWF	SYSLONGDIVMULTX,F,ACCESS
	MOVF	SYSLONGDIVMULTB_H,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_H,F,ACCESS
	MOVF	SYSLONGDIVMULTB_U,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_U,F,ACCESS
	MOVF	SYSLONGDIVMULTB_E,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_E,F,ACCESS
;End If
ENDIF12:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F,ACCESS
;goto SysDiv32Start
	BRA	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	MOVFF	SYSLONGDIVMULTA,SYSLONGTEMPA
	MOVFF	SYSLONGDIVMULTA_H,SYSLONGTEMPA_H
	MOVFF	SYSLONGDIVMULTA_U,SYSLONGTEMPA_U
	MOVFF	SYSLONGDIVMULTA_E,SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	MOVFF	SYSLONGDIVMULTX,SYSLONGTEMPX
	MOVFF	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	MOVFF	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	MOVFF	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2584)
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
	MOVFF	SYSLONGTEMPA,SYSLONGDIVMULTA
	MOVFF	SYSLONGTEMPA_H,SYSLONGDIVMULTA_H
	MOVFF	SYSLONGTEMPA_U,SYSLONGDIVMULTA_U
	MOVFF	SYSLONGTEMPA_E,SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	MOVFF	SYSLONGTEMPB,SYSLONGDIVMULTB
	MOVFF	SYSLONGTEMPB_H,SYSLONGDIVMULTB_H
	MOVFF	SYSLONGTEMPB_U,SYSLONGDIVMULTB_U
	MOVFF	SYSLONGTEMPB_E,SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	CLRF	SYSLONGDIVMULTX,ACCESS
	CLRF	SYSLONGDIVMULTX_H,ACCESS
	CLRF	SYSLONGDIVMULTX_U,ACCESS
	CLRF	SYSLONGDIVMULTX_E,ACCESS
MUL32LOOP:
;IF SysLongDivMultB.0 ON then SysLongDivMultX += SysLongDivMultA
	BTFSS	SYSLONGDIVMULTB,0,ACCESS
	BRA	ENDIF9
	MOVF	SYSLONGDIVMULTA,W,ACCESS
	ADDWF	SYSLONGDIVMULTX,F,ACCESS
	MOVF	SYSLONGDIVMULTA_H,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_H,F,ACCESS
	MOVF	SYSLONGDIVMULTA_U,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_U,F,ACCESS
	MOVF	SYSLONGDIVMULTA_E,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_E,F,ACCESS
ENDIF9:
;set STATUS.C OFF
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;rotate SysLongDivMultB right
	RRCF	SYSLONGDIVMULTB_E,F,ACCESS
	RRCF	SYSLONGDIVMULTB_U,F,ACCESS
	RRCF	SYSLONGDIVMULTB_H,F,ACCESS
	RRCF	SYSLONGDIVMULTB,F,ACCESS
;set STATUS.C off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;rotate SysLongDivMultA left
	RLCF	SYSLONGDIVMULTA,F,ACCESS
	RLCF	SYSLONGDIVMULTA_H,F,ACCESS
	RLCF	SYSLONGDIVMULTA_U,F,ACCESS
	RLCF	SYSLONGDIVMULTA_E,F,ACCESS
;if SysLongDivMultB > 0 then goto MUL32LOOP
	MOVFF	SYSLONGDIVMULTB,SYSLONGTEMPB
	MOVFF	SYSLONGDIVMULTB_H,SYSLONGTEMPB_H
	MOVFF	SYSLONGDIVMULTB_U,SYSLONGTEMPB_U
	MOVFF	SYSLONGDIVMULTB_E,SYSLONGTEMPB_E
	CLRF	SYSLONGTEMPA,ACCESS
	CLRF	SYSLONGTEMPA_H,ACCESS
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
	RCALL	SYSCOMPLESSTHAN32
	BTFSC	SYSBYTETEMPX,0,ACCESS
	BRA	MUL32LOOP
;SysLongTempX = SysLongDivMultX
	MOVFF	SYSLONGDIVMULTX,SYSLONGTEMPX
	MOVFF	SYSLONGDIVMULTX_H,SYSLONGTEMPX_H
	MOVFF	SYSLONGDIVMULTX_U,SYSLONGTEMPX_U
	MOVFF	SYSLONGDIVMULTX_E,SYSLONGTEMPX_E
	RETURN

;********************************************************************************

	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
