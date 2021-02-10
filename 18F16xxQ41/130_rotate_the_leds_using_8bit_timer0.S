;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\130_rotate_the_leds_using_8bit_timer0.S"
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
 SYSTEMP1                         EQU 1280                    ; 0X500
 TIMERCOUNTER                     EQU 1281                    ; 0X501
 TMRNUMBER                        EQU 1282                    ; 0X502
 TMRPOST                          EQU 1283                    ; 0X503
 TMRPRES                          EQU 1284                    ; 0X504
 TMRSOURCE                        EQU 1285                    ; 0X505
 TMRVALUE                         EQU 1286                    ; 0X506
 TMRVALUE_H                       EQU 1287                    ; 0X507

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
;''  This demonstration flashes an LED to show the use of an 8Bit Timer 0
;''
;''  Timer0 is a counter implemented in the processor. It may be used to count instruction
;''  cycles or external events, that occur at or below the instruction cycle rate.
;''  In the PIC18, Timer0 can be used as either an 8-bit or 16-bit counter, or timer. The
;''  enhanced mid-range core implements only an 8-bit counter.
;''
;''  This lesson configures Timer0 to count instruction cycles and to set a flag when it rolls
;''  over. This frees up the processor to do meaningful work rather than wasting instruction
;''  cycles in a timing loop.
;''  Using a counter provides a convenient method of measuring time or delay loops as it
;''  allows the processor to work on other tasks rather than counting instruction cycles.
;''
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
;#DEFINE SWITCHIN      PORTA.2
;Dir     SWITCHIN      In
	BSF	TRISA,2,ACCESS
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;For this we need the following:
;Prescaler with the FOSC/4
;Prescaler with the FOSC/4 with a post scaler
;1:256
;1:1 which is the constant POST0_1
;InitTimer0 Osc, PRE0_256 + TMR0_FOSC4 ,  POST0_1
	MOVLW	1
	MOVWF	TMRSOURCE,ACCESS
	MOVLW	72
	MOVWF	TMRPRES,ACCESS
	CLRF	TMRPOST,ACCESS
	RCALL	INITTIMER0176
;Start the Timer
;StartTimer 0
	CLRF	TMRNUMBER,ACCESS
	RCALL	STARTTIMER
;Every 10 msec, we will count 100 to make 1 second
;SetTimer ( 0 , 0x9C  )
	CLRF	TMRNUMBER,ACCESS
	MOVLW	156
	MOVWF	TMRVALUE,ACCESS
	CLRF	TMRVALUE_H,ACCESS
	RCALL	SETTIMER173
;we will use this to count the number of times the event happens
;Dim TimerCounter As Byte
;TimerCounter = 0
	CLRF	TIMERCOUNTER,ACCESS
;Set the initial LED states - change to suit your configuration - same as previous demonstrations
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
;Do
SYSDOLOOP_S1:
;wait for the event
;Wait While TMR0IF = 0
SYSWAITLOOP1:
;A8: ASM Source was:  BTFSS PIR3,TMR0IF,ACCESS
	BTFSS	PIR3,7,ACCESS
	BRA	SYSWAITLOOP1
;Clearing Timer flag will reset event
;TMR0IF = 0
;A8: ASM Source was:  BCF PIR3,TMR0IF,ACCESS
	BCF	PIR3,7,ACCESS
;TimerCounter = TimerCounter + 1
	INCF	TIMERCOUNTER,F,ACCESS
;When at 100 we are at 1 s
;If TimerCounter = 100 Then
	MOVLW	100
	SUBWF	TIMERCOUNTER,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF1
;Rotate the LEDs.  We are only interested in the four LEDs so we mask the other bits.
;Set C Off
;A8: ASM Source was:  BCF STATUS,C,ACCESS
	BCF	STATUS,0,ACCESS
;and shift the contents of LEDState
;Rotate LEDPORT Right
	RRCF	LATC,F,ACCESS
;If C = to 1 then the sequence has completed, then set the initial state again, the same operation as the starting LED.
;If C = 1 Then
;A8: ASM Source was:  BTFSS STATUS,C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	ENDIF2
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
ENDIF2:
;restart our event counter
;TimerCounter = 0
	CLRF	TIMERCOUNTER,ACCESS
;End If
ENDIF1:
;Set the Timer start value
;SetTimer ( 0 , 0x9C  )
	CLRF	TMRNUMBER,ACCESS
	MOVLW	156
	MOVWF	TMRVALUE,ACCESS
	CLRF	TMRVALUE_H,ACCESS
	RCALL	SETTIMER173
;Loop
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1:
BASPROGRAMEND:
	SLEEP
	BRA	BASPROGRAMEND

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
;OSCFRQ = 0b00000101   '16mhz
	MOVLW	5
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

;OVERLOADED SIGNATURE: BYTE:BYTE:BYTE:, SOURCE: TIMER.H (1360)
INITTIMER0176:
;Equate to      T0CON1 7:5      3:0        T0CON0 3:0
;Assumed for code below Timer0 is 16-bit capable as we have been passed three parameters
;Set prescaler
;T0CON1 Sets up  CLK Source (7:5)  Sync (4) & Prescale 3:0
;T0CON1 POR Val = b'00000000'
;Re-Use TMRPres as T0CON1 Temp register
;Keep T0CON1 7:4 and write bits 3:0 to  register
;Bits therefore will be cleared!
;TMRPres = (T0CON1 And 240 ) OR TMRPres
	MOVLW	240
BANKSEL	T0CON1
	ANDWF	T0CON1,W,BANKED
	MOVWF	SYSTEMP1,ACCESS
	IORWF	TMRPRES,F,ACCESS
;Set the Source bit
;IF TMRSource <> OSC  THEN
	DECF	TMRSOURCE,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	BRA	ELSE14_1
;SET TMRPost.5 ON
	BSF	TMRPOST,5,ACCESS
;ELSE
	BRA	ENDIF14
ELSE14_1:
;SET TMRPost.5 OFF
	BCF	TMRPOST,5,ACCESS
;END IF
ENDIF14:
;Write the TOCON register
;T0CON1 = TMRPres
	MOVFF	TMRPRES,T0CON1
;Assumed for code below Timer0 is 16-bit capable
;Set Postscaler
;Re-Use TMRPost as T0CON0 Temp register
;Keep T0CON0 7:5  and write bits 5:0 to register
;Bits therefore will be cleared!
;TMRPost = (T0CON0 And 224) OR TMRPost
	MOVLW	224
	ANDWF	T0CON0,W,BANKED
	MOVWF	SYSTEMP1,ACCESS
	IORWF	TMRPOST,F,ACCESS
;Set TO16BIT
;Set TMRPost.4 OFF '8-bit Timer0
	BCF	TMRPOST,4,ACCESS
;Write the TOCON register
;T0CON0 = TMRPost
	MOVFF	TMRPOST,T0CON0
	BANKSEL	0
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: TIMER.H (1028)
SETTIMER173:
;Dim TMRValue as word
;If TMRNumber = 0 Then
	MOVF	TMRNUMBER,F,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF8
;TMRValue_H = [byte]TMRValue
	MOVFF	TMRVALUE,TMRVALUE_H
;[byte]TMRValue = 0
	CLRF	TMRVALUE,ACCESS
;end if
ENDIF8:
;SetTimer ( TMRNumber, [word]TMRValue )
	BRA	SETTIMER174

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:WORD:, SOURCE: TIMER.H (1049)
SETTIMER174:
;If TMRNumber = 0 Then
	MOVF	TMRNUMBER,F,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
;Handle chips with TMR0H
;Use default 8-bit mode therefore _TMR0_16BIT_ not defined
;Added to resolve using 8bit Timer0 with enhance timer
;High byte is timer0 register of interest
;TMR0H = TMRValue_H
	MOVFF	TMRVALUE_H,TMR0H
;End If
;If TMRNumber = 1 then
	DECF	TMRNUMBER,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF10
;TMR1H = TMRValue_H
	MOVFF	TMRVALUE_H,TMR1H
;TMR1L = TMRValue
	MOVFF	TMRVALUE,TMR1L
;End If
ENDIF10:
;If TMRNumber = 2 Then
	MOVLW	2
	SUBWF	TMRNUMBER,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
;TMR2 = TMRValue
;A6: ASM Source was:  MOVFF TMRVALUE,TMR2
	MOVFF	TMRVALUE,T2TMR
;End If
;If TMRNumber = 3 then
	MOVLW	3
	SUBWF	TMRNUMBER,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF12
;TMR3H = TMRValue_H
	MOVFF	TMRVALUE_H,TMR3H
;TMR3L = TMRValue
	MOVFF	TMRVALUE,TMR3L
;End If
ENDIF12:
;If TMRNumber = 4 Then
	MOVLW	4
	SUBWF	TMRNUMBER,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
;TMR4 = TMRValue
;A6: ASM Source was:  MOVFF TMRVALUE,TMR4
	MOVFF	TMRVALUE,T4TMR
;End If
	RETURN

;********************************************************************************

;SOURCE: TIMER.H (704)
STARTTIMER:
;IF TMRNumber = 0 then Set T0EN on
	MOVF	TMRNUMBER,F,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF3
BANKSEL	T0CON0
;A8: ASM Source was:  BSF T0CON0,T0EN,BANKED
	BSF	T0CON0,7,BANKED
ENDIF3:
;IF TMRNumber = 1 then Set TMR1ON on
	DECF	TMRNUMBER,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF4
BANKSEL	T1CON
;A8: ASM Source was:  BSF T1CON,TMR1ON,BANKED
	BSF	T1CON,0,BANKED
ENDIF4:
;IF TMRNumber = 2 then Set TMR2ON on
	MOVLW	2
	SUBWF	TMRNUMBER,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF5
BANKSEL	T2CON
;A8: ASM Source was:  BSF T2CON,TMR2ON,BANKED
	BSF	T2CON,7,BANKED
ENDIF5:
;IF TMRNumber = 3 then Set TMR3ON on
	MOVLW	3
	SUBWF	TMRNUMBER,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF6
BANKSEL	T3CON
;A8: ASM Source was:  BSF T3CON,TMR3ON,BANKED
	BSF	T3CON,0,BANKED
ENDIF6:
;IF TMRNumber = 4 then Set TMR4ON on
	MOVLW	4
	SUBWF	TMRNUMBER,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF7
BANKSEL	T4CON
;A8: ASM Source was:  BSF T4CON,TMR4ON,BANKED
	BSF	T4CON,7,BANKED
ENDIF7:
	BANKSEL	0
	RETURN

;********************************************************************************

	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
