;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\060_variable_rotate_the_leds.S"
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
 ADCVAL                           EQU 1293                    ; 0X50D
 ADCVAL_H                         EQU 1294                    ; 0X50E
 ADREADPORT                       EQU 1295                    ; 0X50F
 DELAYTEMP                        EQU 1280                    ; 0X500
 DELAYTEMP2                       EQU 1281                    ; 0X501
 L_CALIBRATE                      EQU 1296                    ; 0X510
 L_CALIBRATE_H                    EQU 1297                    ; 0X511
 L_FROMHIGH                       EQU 1298                    ; 0X512
 L_FROMHIGH_H                     EQU 1299                    ; 0X513
 L_FROMLOW                        EQU 1300                    ; 0X514
 L_FROMLOW_H                      EQU 1301                    ; 0X515
 L_MAP                            EQU 1302                    ; 0X516
 L_MAP_H                          EQU 1303                    ; 0X517
 L_SYSCALC                        EQU 1304                    ; 0X518
 L_SYSCALCF                       EQU 1306                    ; 0X51A
 L_SYSCALCF_E                     EQU 1309                    ; 0X51D
 L_SYSCALCF_H                     EQU 1307                    ; 0X51B
 L_SYSCALCF_U                     EQU 1308                    ; 0X51C
 L_SYSCALC_H                      EQU 1305                    ; 0X519
 L_TOHIGH                         EQU 1310                    ; 0X51E
 L_TOHIGH_H                       EQU 1311                    ; 0X51F
 L_TOLOW                          EQU 1312                    ; 0X520
 L_TOLOW_H                        EQU 1313                    ; 0X521
 READAD12                         EQU 1314                    ; 0X522
 READAD12_H                       EQU 1315                    ; 0X523
 SCALE                            EQU 1316                    ; 0X524
 SCALE_H                          EQU 1317                    ; 0X525
 SYSBYTETEMPX                     EQU 1280                    ; 0X500
 SYSDIVLOOP                       EQU 1284                    ; 0X504
 SYSLONGDIVMULTA                  EQU 1318                    ; 0X526
 SYSLONGDIVMULTA_E                EQU 1321                    ; 0X529
 SYSLONGDIVMULTA_H                EQU 1319                    ; 0X527
 SYSLONGDIVMULTA_U                EQU 1320                    ; 0X528
 SYSLONGDIVMULTB                  EQU 1322                    ; 0X52A
 SYSLONGDIVMULTB_E                EQU 1325                    ; 0X52D
 SYSLONGDIVMULTB_H                EQU 1323                    ; 0X52B
 SYSLONGDIVMULTB_U                EQU 1324                    ; 0X52C
 SYSLONGDIVMULTX                  EQU 1326                    ; 0X52E
 SYSLONGDIVMULTX_E                EQU 1329                    ; 0X531
 SYSLONGDIVMULTX_H                EQU 1327                    ; 0X52F
 SYSLONGDIVMULTX_U                EQU 1328                    ; 0X530
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
 SYSTEMP1                         EQU 1330                    ; 0X532
 SYSTEMP1_E                       EQU 1333                    ; 0X535
 SYSTEMP1_H                       EQU 1331                    ; 0X533
 SYSTEMP1_U                       EQU 1332                    ; 0X534
 SYSTEMP2                         EQU 1334                    ; 0X536
 SYSTEMP2_H                       EQU 1335                    ; 0X537
 SYSWAITTEMP10US                  EQU 1285                    ; 0X505
 SYSWAITTEMPMS                    EQU 1282                    ; 0X502
 SYSWAITTEMPMS_H                  EQU 1283                    ; 0X503
 SYSWAITTEMPS                     EQU 1284                    ; 0X504

;********************************************************************************

;ALIAS VARIABLES
 SYSREADAD12WORD                  EQU 1314
 SYSREADAD12WORD_H                EQU 1315
 SYSSCALEWORD                     EQU 1316
 SYSSCALEWORD_H                   EQU 1317

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
;'' This shows how to read the ADC converter and display the
;'' a proportional delay value by changing/inverting the LEDs state.
;'' The pot on the board varies the voltage coming in from the ADC.
;''
;'' The ADC is referenced to the same Vdd as the device, which
;'' is nominally is 5V.  The ADC returns the ratio of the voltage
;'' on Pin RA0 to 5V.  The ADC has a resolution of 12 bits, with 4095
;'' representing 5V and 0 representing 0V.
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
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Set the initial LED states - change to suit your configuration
;#DEFINE LEDSTATEMACRO RC0 = 0: RC1 = 0: RC2 = 0: RC3 = 1
;You may need change to the LEDMASK to suit your port/configuration.  We use a macro as re reuse this statement more that once.
;#DEFINE LEDMASK 0B00001111
;LEDSTATEMACRO
;A8: ASM Source was:  BCF LATC,RC0,ACCESS
	BCF	LATC,0,ACCESS
;A8: ASM Source was:  BCF LATC,RC1,ACCESS
	BCF	LATC,1,ACCESS
;A8: ASM Source was:  BCF LATC,RC2,ACCESS
	BCF	LATC,2,ACCESS
;A8: ASM Source was:  BSF LATC,RC3,ACCESS
	BSF	LATC,3,ACCESS
;Wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS,ACCESS
	RCALL	DELAY_S
;we have change to a larger variable to hold the range of 0 to 4095
;Dim ADCVal As Word
;Do
SYSDOLOOP_S1:
;ADCVal = ReadAD12 ( AN0 )
	CLRF	ADREADPORT,ACCESS
	RCALL	FN_READAD128
	MOVFF	SYSREADAD12WORD,ADCVAL
	MOVFF	SYSREADAD12WORD_H,ADCVAL_H
;ADCVal = Scale ( ADCVal, 0, 4095, 2, 100 )
	MOVFF	ADCVAL,L_MAP
	MOVFF	ADCVAL_H,L_MAP_H
	CLRF	L_FROMLOW,ACCESS
	CLRF	L_FROMLOW_H,ACCESS
	SETF	L_FROMHIGH,ACCESS
	MOVLW	15
	MOVWF	L_FROMHIGH_H,ACCESS
	MOVLW	2
	MOVWF	L_TOLOW,ACCESS
	CLRF	L_TOLOW_H,ACCESS
	MOVLW	100
	MOVWF	L_TOHIGH,ACCESS
	CLRF	L_TOHIGH_H,ACCESS
	CLRF	L_CALIBRATE,ACCESS
	CLRF	L_CALIBRATE_H,ACCESS
	RCALL	FN_SCALE72
	MOVFF	SYSSCALEWORD,ADCVAL
	MOVFF	SYSSCALEWORD_H,ADCVAL_H
;Wait for the number of milliseconds
;Wait ADCVal ms
	MOVFF	ADCVAL,SYSWAITTEMPMS
	MOVFF	ADCVAL_H,SYSWAITTEMPMS_H
	RCALL	DELAY_MS
;Rotate the LEDs.  We are only interested in the four LEDs so we mask the other bits.
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;and shift the contents of LEDState
;Rotate LEDPORT Right
	RRCF	LATC,F,ACCESS
;If the LEDState.0is equal to 1 then the sequence has completed, then set the initial state again, the same operation as the starting LED.
;If C = 1 Then
;A8: ASM Source was:  BTFSS STATUS,C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	ENDIF1
;Set the initial LED states
;LEDSTATEMACRO
;A8: ASM Source was:  BCF LATC,RC0,ACCESS
	BCF	LATC,0,ACCESS
;A8: ASM Source was:  BCF LATC,RC1,ACCESS
	BCF	LATC,1,ACCESS
;A8: ASM Source was:  BCF LATC,RC2,ACCESS
	BCF	LATC,2,ACCESS
;A8: ASM Source was:  BSF LATC,RC3,ACCESS
	BSF	LATC,3,ACCESS
;Mask off the other bits
;LEDPORT = LEDPORT AND LEDMASK
	MOVLW	15
	ANDWF	LATC,F,ACCESS
;End If
ENDIF1:
;Loop
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1:
;'' GCB Optimisation file
;Optimise A-d.h
;Standard family chips
;#define USE_AD0 TRUE
;#define USE_AD1 FALSE
;#define USE_AD2 FALSE
;#define USE_AD2 FALSE
;#define USE_AD3 FALSE
;#define USE_AD4 FALSE
;#define USE_AD5 FALSE
;#define USE_AD6 FALSE
;#define USE_AD7 FALSE
;#define USE_AD8 FALSE
;#define USE_AD9 FALSE
;#define USE_AD10 FALSE
;#define USE_AD11 FALSE
;#define USE_AD12 FALSE
;#define USE_AD13 FALSE
;#define USE_AD14 FALSE
;#define USE_AD15 FALSE
;#define USE_AD16 FALSE
;#define USE_AD17 FALSE
;#define USE_AD18 FALSE
;#define USE_AD19 FALSE
;#define USE_AD20 FALSE
;#define USE_AD21 FALSE
;#define USE_AD22 FALSE
;#define USE_AD23 FALSE
;#define USE_AD24 FALSE
;#define USE_AD25 FALSE
;#define USE_AD26 FALSE
;#define USE_AD27 FALSE
;#define USE_AD28 FALSE
;#define USE_AD29 FALSE
;#define USE_AD30 FALSE
;#define USE_AD31 FALSE
;#define USE_AD32 FALSE
;#define USE_AD33 FALSE
;#define USE_AD34 FALSE
;Family of chips based on 16f1688x with ADCON3 register
;#define USE_ADA0 FALSE
;#define USE_ADA1 FALSE
;#define USE_ADA2 FALSE
;#define USE_ADA3 FALSE
;#define USE_ADA4 FALSE
;#define USE_ADA5 FALSE
;#define USE_ADA6 FALSE
;#define USE_ADA7 FALSE
;#define USE_ADB0 FALSE
;#define USE_ADB1 FALSE
;#define USE_ADB2 FALSE
;#define USE_ADB3 FALSE
;#define USE_ADB4 FALSE
;#define USE_ADB5 FALSE
;#define USE_ADB6 FALSE
;#define USE_ADB7 FALSE
;#define USE_ADC0 FALSE
;#define USE_ADC1 FALSE
;#define USE_ADC2 FALSE
;#define USE_ADC3 FALSE
;#define USE_ADC4 FALSE
;#define USE_ADC5 FALSE
;#define USE_ADC6 FALSE
;#define USE_ADC7 FALSE
;#define USE_ADD0 FALSE
;#define USE_ADD1 FALSE
;#define USE_ADD2 FALSE
;#define USE_ADD3 FALSE
;#define USE_ADD4 FALSE
;#define USE_ADD5 FALSE
;#define USE_ADD6 FALSE
;#define USE_ADD7 FALSE
;#define USE_ADE0 FALSE
;#define USE_ADE1 FALSE
;#define USE_ADE2 FALSE
BASPROGRAMEND:
	SLEEP
	BRA	BASPROGRAMEND

;********************************************************************************

DELAY_10US:
D10US_START:
	MOVLW	5
	MOVWF	DELAYTEMP,ACCESS
DELAYUS0:
	DECFSZ	DELAYTEMP,F,ACCESS
	BRA	DELAYUS0
	NOP
	DECFSZ	SYSWAITTEMP10US, F,ACCESS
	BRA	D10US_START
	RETURN

;********************************************************************************

DELAY_MS:
	INCF	SYSWAITTEMPMS_H, F,ACCESS
DMS_START:
	MOVLW	4
	MOVWF	DELAYTEMP2,ACCESS
DMS_OUTER:
	MOVLW	165
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

DELAY_S:
DS_START:
	MOVLW	232
	MOVWF	SYSWAITTEMPMS,ACCESS
	MOVLW	3
	MOVWF	SYSWAITTEMPMS_H,ACCESS
	RCALL	DELAY_MS
	DECFSZ	SYSWAITTEMPS, F,ACCESS
	BRA	DS_START
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
;OSCFRQ = 0b00000011    '8mhz
	MOVLW	3
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

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (2190)
FN_READAD128:
;Always RIGHT justified
;Set up A/D format
;SET ADFM ON
BANKSEL	ADCON0
;A8: ASM Source was:  BSF ADCON0,ADFM0,BANKED
	BSF	ADCON0,2,BANKED
;Set A/D Result Mode to 12-Bit
;Required by some chips
;ADPCH = ADReadPort
	MOVFF	ADREADPORT,ADPCH
;Do conversion
;LLReadAD 0
;Macro Source: a-d.h (371)
;***  'Special section for 16F1688x Chips ***
;'Configure ANSELA/B/C/D
;Select Case ADReadPort 'Configure ANSELA/B/C/D @DebugADC_H
;End Select  '*** ANSEL Bits should now be set ***
SYSSELECTEND1:
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
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
;Set ADCON0.2 ON
;Set ADFM ON
;A8: ASM Source was:  BSF ADCON0,ADFM0,BANKED
	BSF	ADCON0,2,BANKED
;Set ADFM0 ON
;A8: ASM Source was:  BSF ADCON0,ADFM0,BANKED
	BSF	ADCON0,2,BANKED
;Else
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
;Write output
;ReadAD12 = ADRESL
;A2: ASM Source was:  MOVFF ADRESL,READAD12
;A4: ASM Source was:  MOVFF ADRESL,READAD12
	MOVFF	ADRES,READAD12
	CLRF	READAD12_H,ACCESS
;ReadAD12_H = ADRESH
	MOVFF	ADRESH,READAD12_H
;Put A/D format back to normal
;SET ADFM OFF
BANKSEL	ADCON0
;A8: ASM Source was:  BCF ADCON0,ADFM0,BANKED
	BCF	ADCON0,2,BANKED
	BANKSEL	0
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: WORD:WORD:WORD:WORD:WORD:INTEGER:, SOURCE: STDBASIC.H (263)
FN_SCALE72:
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
	BRA	ENDIF5
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA,ACCESS
	CLRF	SYSLONGTEMPA_H,ACCESS
	CLRF	SYSLONGTEMPA_U,ACCESS
	CLRF	SYSLONGTEMPA_E,ACCESS
;exit sub
	RETURN
;end if
ENDIF5:
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
	BRA	ENDIF6
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
ENDIF6:
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
	BRA	ENDIF3
	MOVF	SYSLONGDIVMULTA,W,ACCESS
	ADDWF	SYSLONGDIVMULTX,F,ACCESS
	MOVF	SYSLONGDIVMULTA_H,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_H,F,ACCESS
	MOVF	SYSLONGDIVMULTA_U,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_U,F,ACCESS
	MOVF	SYSLONGDIVMULTA_E,W,ACCESS
	ADDWFC	SYSLONGDIVMULTX_E,F,ACCESS
ENDIF3:
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
