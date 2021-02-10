;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   18F16Q41
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\18f16q41\190_using_an_interrupt_to_manage_the_pwm_signal_to_control_an_leds_brightness.S"
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
 DELAYTEMP                        EQU 1280                    ; 0X500
 DELAYTEMP2                       EQU 1281                    ; 0X501
 MOTORSPEED                       EQU 1285                    ; 0X505
 PWMCOUNTER                       EQU 1286                    ; 0X506
 SPEED                            EQU 1287                    ; 0X507
 SYSBSR                           EQU 1288                    ; 0X508
 SYSSTATUS                        EQU 1295                    ; 0X50F
 SYSTEMP1                         EQU 1289                    ; 0X509
 SYSW                             EQU 1294                    ; 0X50E
 SYSWAITTEMPMS                    EQU 1282                    ; 0X502
 SYSWAITTEMPMS_H                  EQU 1283                    ; 0X503
 SYSWAITTEMPS                     EQU 1284                    ; 0X504
 TMRNUMBER                        EQU 1290                    ; 0X50A
 TMRPOST                          EQU 1291                    ; 0X50B
 TMRPRES                          EQU 1292                    ; 0X50C
 TMRSOURCE                        EQU 1293                    ; 0X50D

;********************************************************************************

 PSECT   RESETVEC,delta=1, abs
 RESETVEC:
;VECTORS
	ORG	0
	GOTO	BASPROGRAMSTART
	ORG	8
	BRA	INTERRUPT

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	12
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	RCALL	INITSYS
;ENABLE INTERRUPTS
;A8: ASM Source was:  BSF INTCON0,GIE,ACCESS
	BSF	INTCON0,7,ACCESS

;START OF THE MAIN PROGRAM
;''
;'' This demonstration will show how you can control a motor using a PWM signal.
;''
;'' Pulse-Width Modulation (PWM) is a scheme that provides power to a load by switching
;'' quickly between fully on and fully off states. The PWM signal resembles a square wave
;'' where the high portion of the signal is considered the on state and the low portion of
;'' the signal is considered the off state. The high portion, also known as the pulse width,
;'' can vary in time and is defined in steps. A longer, high on time will illuminate the LED
;'' brighter. The frequency or period of the PWM does not change.
;''
;'' This program demostrates a method where the number of steps applied,
;'' which lengthens the pulse width are calculated in an Interrupt routine.
;'' The PWM period defined as the duration of one complete cycle or the total
;'' amount of on and off time combined is based on a simple counter.
;''
;'' The demo varies the PWM to the LED.  We are pretending the motor is connected to PortC.1, via a suitable motor control device.
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
;' IO:    ----TX---------LED--LED-LED LED--
;'-----------------------------------------
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;Dim speed, MotorSpeed, PWMCounter As Byte
;We are pretending the motor is connected to Portb.1, via a suitable motor control device.
;#DEFINE MOTOR PORTC.0
;Dir MOTOR Out
	BCF	TRISC,0,ACCESS
;Call the initialisation routine
;InitMotorControl
	RCALL	INITMOTORCONTROL
;Main routine
;Do
SYSDOLOOP_S1:
;Increase speed to full over 2.5 seconds
;For Speed = 0 To 100
	SETF	SPEED,ACCESS
SYSFORLOOP1:
	INCF	SPEED,F,ACCESS
;MotorSpeed = Speed
	MOVFF	SPEED,MOTORSPEED
;Wait 25 ms
	MOVLW	25
	MOVWF	SYSWAITTEMPMS,ACCESS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	RCALL	DELAY_MS
;Next
	MOVLW	100
	SUBWF	SPEED,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP1
SYSFORLOOPEND1:
;Hold speed
;Wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS,ACCESS
	RCALL	DELAY_S
;Decrease speed to zero over 2.5 seconds
;For Speed = 100 To 0
	MOVLW	101
	MOVWF	SPEED,ACCESS
SYSFORLOOP2:
	DECF	SPEED,F,ACCESS
;MotorSpeed = Speed
	MOVFF	SPEED,MOTORSPEED
;Wait 25 ms
	MOVLW	25
	MOVWF	SYSWAITTEMPMS,ACCESS
	CLRF	SYSWAITTEMPMS_H,ACCESS
	RCALL	DELAY_MS
;Next
	MOVF	SPEED,W,ACCESS
	SUBLW	0
;A8: ASM Source was:  BTFSS STATUS, C,ACCESS
	BTFSS	STATUS,0,ACCESS
	BRA	SYSFORLOOP2
SYSFORLOOPEND2:
;Hold speed
;Wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS,ACCESS
	RCALL	DELAY_S
;Loop
	BRA	SYSDOLOOP_S1
SYSDOLOOP_E1:
;Setup routine
;PWM sub
;This will be called when Timer 0 overflows
BASPROGRAMEND:
	SLEEP
	BRA	BASPROGRAMEND

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

;SOURCE: 190_USING_AN_INTERRUPT_TO_MANAGE_THE_PWM_SIGNAL_TO_CONTROL_AN_LEDS_BRIGHTNESS.GCB (79)
INITMOTORCONTROL:
;Clear variables
;MotorSpeed = 0
	CLRF	MOTORSPEED,ACCESS
;PWMCounter = 0
	CLRF	PWMCOUNTER,ACCESS
;Add a handler for the interrupt
;On Interrupt Timer0Overflow Call PWMHandler
;A8: ASM Source was:  BSF PIE3,TMR0IE,ACCESS
	BSF	PIE3,7,ACCESS
;InitTimer0 Osc, PRE0_1 + TMR0_FOSC4 ,  POST0_1
	MOVLW	1
	MOVWF	TMRSOURCE,ACCESS
	MOVLW	64
	MOVWF	TMRPRES,ACCESS
	CLRF	TMRPOST,ACCESS
	RCALL	INITTIMER0178
;StartTimer 0
	CLRF	TMRNUMBER,ACCESS
	BRA	STARTTIMER

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

;OVERLOADED SIGNATURE: BYTE:BYTE:BYTE:, SOURCE: TIMER.H (1360)
INITTIMER0178:
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
	BRA	ELSE10_1
;SET TMRPost.5 ON
	BSF	TMRPOST,5,ACCESS
;ELSE
	BRA	ENDIF10
ELSE10_1:
;SET TMRPost.5 OFF
	BCF	TMRPOST,5,ACCESS
;END IF
ENDIF10:
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

INTERRUPT:
;USE AUTOMATIC CONTEXT SAVE FOR K42 AND K83 WITH MVECEN = OFF.  INTERRUPT PRIORITY NOT SUPPORTED
;STORE SYSTEM VARIABLES
;ON INTERRUPT HANDLERS
;A8: ASM Source was:  BTFSS PIE3,TMR0IE,ACCESS
	BTFSS	PIE3,7,ACCESS
	BRA	NOTTMR0IF
;A8: ASM Source was:  BTFSS PIR3,TMR0IF,ACCESS
	BTFSS	PIR3,7,ACCESS
	BRA	NOTTMR0IF
	RCALL	PWMHANDLER
;A8: ASM Source was:  BCF PIR3,TMR0IF,ACCESS
	BCF	PIR3,7,ACCESS
	BRA	INTERRUPTDONE
NOTTMR0IF:
;USER INTERRUPT ROUTINE
INTERRUPTDONE:
;RESTORE CONTEXT
;RESTORE SYSTEM VARIABLES
	RETFIE	1

;********************************************************************************

;SOURCE: 190_USING_AN_INTERRUPT_TO_MANAGE_THE_PWM_SIGNAL_TO_CONTROL_AN_LEDS_BRIGHTNESS.GCB (93)
PWMHANDLER:
;If MotorSpeed > PWMCounter Then
	MOVF	MOTORSPEED,W,ACCESS
	SUBWF	PWMCOUNTER,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, C,ACCESS
	BTFSC	STATUS,0,ACCESS
	BRA	ELSE3_1
;Set MOTOR On
	BSF	LATC,0,ACCESS
;Else
	BRA	ENDIF3
ELSE3_1:
;Set MOTOR Off
	BCF	LATC,0,ACCESS
;End If
ENDIF3:
;PWMCounter += 1
	INCF	PWMCOUNTER,F,ACCESS
;If PWMCounter = 100 Then PWMCounter = 0
	MOVLW	100
	SUBWF	PWMCOUNTER,W,ACCESS
;A8: ASM Source was:  BTFSC STATUS, Z,ACCESS
	BTFSC	STATUS,2,ACCESS
	CLRF	PWMCOUNTER,ACCESS
	RETURN

;********************************************************************************

;SOURCE: TIMER.H (704)
STARTTIMER:
;IF TMRNumber = 0 then Set T0EN on
	MOVF	TMRNUMBER,F,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF5
BANKSEL	T0CON0
;A8: ASM Source was:  BSF T0CON0,T0EN,BANKED
	BSF	T0CON0,7,BANKED
ENDIF5:
;IF TMRNumber = 1 then Set TMR1ON on
	DECF	TMRNUMBER,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF6
BANKSEL	T1CON
;A8: ASM Source was:  BSF T1CON,TMR1ON,BANKED
	BSF	T1CON,0,BANKED
ENDIF6:
;IF TMRNumber = 2 then Set TMR2ON on
	MOVLW	2
	SUBWF	TMRNUMBER,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF7
BANKSEL	T2CON
;A8: ASM Source was:  BSF T2CON,TMR2ON,BANKED
	BSF	T2CON,7,BANKED
ENDIF7:
;IF TMRNumber = 3 then Set TMR3ON on
	MOVLW	3
	SUBWF	TMRNUMBER,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF8
BANKSEL	T3CON
;A8: ASM Source was:  BSF T3CON,TMR3ON,BANKED
	BSF	T3CON,0,BANKED
ENDIF8:
;IF TMRNumber = 4 then Set TMR4ON on
	MOVLW	4
	SUBWF	TMRNUMBER,W,ACCESS
;A8: ASM Source was:  BTFSS STATUS, Z,ACCESS
	BTFSS	STATUS,2,ACCESS
	BRA	ENDIF9
BANKSEL	T4CON
;A8: ASM Source was:  BSF T4CON,TMR4ON,BANKED
	BSF	T4CON,7,BANKED
ENDIF9:
	BANKSEL	0
	RETURN

;********************************************************************************

	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
