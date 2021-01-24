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
 ADCVAL                           EQU 1293
 ADCVAL_H                         EQU 1294
 ADREADPORT                       EQU 1295
 DELAYTEMP                        EQU 1280
 DELAYTEMP2                       EQU 1281
 L_CALIBRATE                      EQU 1296
 L_CALIBRATE_H                    EQU 1297
 L_FROMHIGH                       EQU 1298
 L_FROMHIGH_H                     EQU 1299
 L_FROMLOW                        EQU 1300
 L_FROMLOW_H                      EQU 1301
 L_MAP                            EQU 1302
 L_MAP_H                          EQU 1303
 L_SYSCALC                        EQU 1304
 L_SYSCALCF                       EQU 1306
 L_SYSCALCF_E                     EQU 1309
 L_SYSCALCF_H                     EQU 1307
 L_SYSCALCF_U                     EQU 1308
 L_SYSCALC_H                      EQU 1305
 L_TOHIGH                         EQU 1310
 L_TOHIGH_H                       EQU 1311
 L_TOLOW                          EQU 1312
 L_TOLOW_H                        EQU 1313
 READAD12                         EQU 1314
 READAD12_H                       EQU 1315
 SCALE                            EQU 1316
 SCALE_H                          EQU 1317
 SYSBYTETEMPX                     EQU 1280
 SYSDIVLOOP                       EQU 1284
 SYSLONGDIVMULTA                  EQU 1318
 SYSLONGDIVMULTA_E                EQU 1321
 SYSLONGDIVMULTA_H                EQU 1319
 SYSLONGDIVMULTA_U                EQU 1320
 SYSLONGDIVMULTB                  EQU 1322
 SYSLONGDIVMULTB_E                EQU 1325
 SYSLONGDIVMULTB_H                EQU 1323
 SYSLONGDIVMULTB_U                EQU 1324
 SYSLONGDIVMULTX                  EQU 1326
 SYSLONGDIVMULTX_E                EQU 1329
 SYSLONGDIVMULTX_H                EQU 1327
 SYSLONGDIVMULTX_U                EQU 1328
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
 SYSTEMP1                         EQU 1330
 SYSTEMP1_E                       EQU 1333
 SYSTEMP1_H                       EQU 1331
 SYSTEMP1_U                       EQU 1332
 SYSTEMP2                         EQU 1334
 SYSTEMP2_H                       EQU 1335
 SYSWAITTEMP10US                  EQU 1285
 SYSWAITTEMPMS                    EQU 1282
 SYSWAITTEMPMS_H                  EQU 1283
 SYSWAITTEMPS                     EQU 1284

;********************************************************************************

;Alias variables
 SYSREADAD12WORD                  EQU 1314
 SYSREADAD12WORD_H                EQU 1315
 SYSSCALEWORD                     EQU 1316
 SYSSCALEWORD_H                   EQU 1317

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
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Set the initial LED states - change to suit your configuration
;#DEFINE LEDSTATEMACRO RC0 = 0: RC1 = 0: RC2 = 0: RC3 = 1
;You may need change to the LEDMASK to suit your port/configuration.  We use a macro as re reuse this statement more that once.
;#DEFINE LEDMASK 0B00001111
;LEDSTATEMACRO
	bcf	LATC,0,ACCESS
	bcf	LATC,1,ACCESS
	bcf	LATC,2,ACCESS
	bsf	LATC,3,ACCESS
;Wait 1 s
	movlw	1
	movwf	SYSWAITTEMPS,ACCESS
	call	Delay_S
;we have change to a larger variable to hold the range of 0 to 4095
;Dim ADCVal As Word
;Do
SysDoLoop_S1:
;ADCVal = ReadAD12 ( AN0 )
	clrf	ADREADPORT,ACCESS
	call	FN_READAD126
	movff	SYSREADAD12WORD,ADCVAL
	movff	SYSREADAD12WORD_H,ADCVAL_H
;ADCVal = Scale ( ADCVal, 0, 4095, 2, 100 )
	movff	ADCVAL,L_MAP
	movff	ADCVAL_H,L_MAP_H
	clrf	L_FROMLOW,ACCESS
	clrf	L_FROMLOW_H,ACCESS
	setf	L_FROMHIGH,ACCESS
	movlw	15
	movwf	L_FROMHIGH_H,ACCESS
	movlw	2
	movwf	L_TOLOW,ACCESS
	clrf	L_TOLOW_H,ACCESS
	movlw	100
	movwf	L_TOHIGH,ACCESS
	clrf	L_TOHIGH_H,ACCESS
	clrf	L_CALIBRATE,ACCESS
	clrf	L_CALIBRATE_H,ACCESS
	call	FN_SCALE70
	movff	SYSSCALEWORD,ADCVAL
	movff	SYSSCALEWORD_H,ADCVAL_H
;Wait for the number of milliseconds
;Wait ADCVal ms
	movff	ADCVAL,SYSWAITTEMPMS
	movff	ADCVAL_H,SYSWAITTEMPMS_H
	call	Delay_MS
;Rotate the LEDs.  We are only interested in the four LEDs so we mask the other bits.
;Set C Off
	bcf	STATUS,0,ACCESS
;and shift the contents of LEDState
;Rotate LEDPORT Right
	rrcf	LATC,F,ACCESS
;If the LEDState.0is equal to 1 then the sequence has completed, then set the initial state again, the same operation as the starting LED.
;If C = 1 Then
	btfss	STATUS,0,ACCESS
	bra	ENDIF1
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
ENDIF1:
;Loop
	bra	SysDoLoop_S1
SysDoLoop_E1:
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
	sleep
	bra	BASPROGRAMEND

;********************************************************************************

Delay_10US:
D10US_START:
	movlw	5
	movwf	DELAYTEMP,ACCESS
DelayUS0:
	decfsz	DELAYTEMP,F,ACCESS
	bra	DelayUS0
	nop
	decfsz	SYSWAITTEMP10US, F,ACCESS
	bra	D10US_START
	return

;********************************************************************************

Delay_MS:
	incf	SYSWAITTEMPMS_H, F,ACCESS
DMS_START:
	movlw	4
	movwf	DELAYTEMP2,ACCESS
DMS_OUTER:
	movlw	165
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

Delay_S:
DS_START:
	movlw	232
	movwf	SYSWAITTEMPMS,ACCESS
	movlw	3
	movwf	SYSWAITTEMPMS_H,ACCESS
	call	Delay_MS
	decfsz	SYSWAITTEMPS, F,ACCESS
	bra	DS_START
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
;OSCFRQ = 0b00000011    '8mhz
	movlw	3
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

;Overloaded signature: BYTE:, Source: a-d.h (2189)
FN_READAD126:
;Always RIGHT justified
;Set up A/D format
;SET ADFM ON
	banksel	ADCON0
	bsf	ADCON0,2,BANKED
;Set A/D Result Mode to 12-Bit
;Required by some chips
;ADPCH = ADReadPort
	movff	ADREADPORT,ADPCH
;Do conversion
;LLReadAD 0
;Macro Source: a-d.h (370)
;***  'Special section for 16F1688x Chips ***
;'Configure ANSELA/B/C/D
;Select Case ADReadPort 'Configure ANSELA/B/C/D @DebugADC_H
;End Select  '*** ANSEL Bits should now be set ***
SysSelectEnd1:
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
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
;Set ADCON0.2 ON
;Set ADFM ON
	bsf	ADCON0,2,BANKED
;Set ADFM0 ON
	bsf	ADCON0,2,BANKED
;Else
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
;Write output
;ReadAD12 = ADRESL
	movff	ADRESL,READAD12
	clrf	READAD12_H,ACCESS
;ReadAD12_H = ADRESH
	movff	ADRESH,READAD12_H
;Put A/D format back to normal
;SET ADFM OFF
	banksel	ADCON0
	bcf	ADCON0,2,BANKED
	banksel	0
	return

;********************************************************************************

;Overloaded signature: WORD:WORD:WORD:WORD:WORD:integer:, Source: stdbasic.h (263)
FN_SCALE70:
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
	bra	ENDIF5
;SysLongTempA = 0
	clrf	SYSLONGTEMPA,ACCESS
	clrf	SYSLONGTEMPA_H,ACCESS
	clrf	SYSLONGTEMPA_U,ACCESS
	clrf	SYSLONGTEMPA_E,ACCESS
;exit sub
	return
;end if
ENDIF5:
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
	bra	ENDIF6
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
ENDIF6:
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
	bra	ENDIF3
	movf	SYSLONGDIVMULTA,W,ACCESS
	addwf	SYSLONGDIVMULTX,F,ACCESS
	movf	SYSLONGDIVMULTA_H,W,ACCESS
	addwfc	SYSLONGDIVMULTX_H,F,ACCESS
	movf	SYSLONGDIVMULTA_U,W,ACCESS
	addwfc	SYSLONGDIVMULTX_U,F,ACCESS
	movf	SYSLONGDIVMULTA_E,W,ACCESS
	addwfc	SYSLONGDIVMULTX_E,F,ACCESS
ENDIF3:
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
