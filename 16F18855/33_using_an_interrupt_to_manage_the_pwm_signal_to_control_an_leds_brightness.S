;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\33_using_an_interrupt_to_manage_the_pwm_signal_to_control_an_leds_brightness.S"
 SUBTITLE    "02-10-2021"

; Reverse lookup file
; C:\Program Files\Microchip\xc8\v2.31\pic\include\proc\pic16f18855.inc

 #include <xc.inc>

;********************************************************************************
;Explicit PIC-AS constants to resolve the crazyness of the PIC-AS syntax
;These are therefore the same as MPASM
#define BANKED b
#define ACCESS a
#define UPPER low highword

;********************************************************************************
;Explicit CONFIG
 CONFIG FCMEN = ON
 CONFIG CLKOUTEN = OFF
 CONFIG RSTOSC = HFINT32
 CONFIG FEXTOSC = OFF
 CONFIG MCLRE = OFF
 CONFIG WDTE = OFF
 CONFIG LVP = OFF
 CONFIG WRT = OFF
 CONFIG CPD = OFF
 CONFIG CP = OFF
;Inferred CONFIG

;********************************************************************************

;Set aside RAM memory locations for variables. All variables are global.
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 MOTORSPEED                       EQU 32                    ; 0X20
 PWMCOUNTER                       EQU 33                    ; 0X21
 SAVEPCLATH                       EQU 34                    ; 0X22
 SPEED                            EQU 35                    ; 0X23
 SYSBSR                           EQU 36                    ; 0X24
 SYSSTATUS                        EQU 127                    ; 0X7F
 SYSTEMP1                         EQU 37                    ; 0X25
 SYSW                             EQU 126                    ; 0X7E
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 SYSWAITTEMPS                     EQU 116                    ; 0X74
 TMRNUMBER                        EQU 38                    ; 0X26
 TMRPOST                          EQU 39                    ; 0X27
 TMRPRES                          EQU 40                    ; 0X28
 TMRSOURCE                        EQU 41                    ; 0X29

;********************************************************************************

 PSECT   RESETVEC,delta=2, abs
 RESETVEC:
;VECTORS
	ORG	0
	PAGESEL	BASPROGRAMSTART
	GOTO	BASPROGRAMSTART
	ORG	4
INTERRUPT:

;********************************************************************************

;SAVE CONTEXT
	MOVWF	SYSW
	SWAPF	STATUS,W
	MOVWF	SYSSTATUS
	MOVF	BSR,W
BANKSEL	STATUS
	MOVWF	SYSBSR
;STORE SYSTEM VARIABLES
	MOVF	PCLATH,W
	MOVWF	SAVEPCLATH
CLRF	PCLATH
;ON INTERRUPT HANDLERS
BANKSEL	PIE0
;B7: ASM Source was:  BTFSS PIE0,TMR0IE
	BTFSS	PIE0,5
	GOTO	NOTTMR0IF
;B7: ASM Source was:  BTFSS PIR0,TMR0IF
	BTFSS	PIR0,5
	GOTO	NOTTMR0IF
BANKSEL	STATUS
	CALL	PWMHANDLER
BANKSEL	PIR0
;B7: ASM Source was:  BCF PIR0,TMR0IF
	BCF	PIR0,5
	GOTO	INTERRUPTDONE
NOTTMR0IF:
;USER INTERRUPT ROUTINE
INTERRUPTDONE:
;RESTORE CONTEXT
;RESTORE SYSTEM VARIABLES
	BANKSEL	SAVEPCLATH
	MOVF	SAVEPCLATH,W
MOVWF	PCLATH
	MOVF	SYSBSR,W
MOVWF	BSR
	SWAPF	SYSSTATUS,W
MOVWF	STATUS
	SWAPF	SYSW,F
	SWAPF	SYSW,W
	RETFIE

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	34
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	CALL	INITSYS
;ENABLE INTERRUPTS
;B7: ASM Source was:  BSF INTCON,GIE
	BSF	INTCON,7
;B7: ASM Source was:  BSF INTCON,PEIE
	BSF	INTCON,6

;START OF THE MAIN PROGRAM
;''
;''******************************************************************
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
;'' The demo vary the PWM to the LED.
;''
;''
;''  PIC: 16F18855
;''  Compiler: GCB
;''  IDE: GCB@SYN
;''
;''  Board: Xpress Evaluation Board
;''  Date: 13.3.2016
;''
;Dim speed, MotorSpeed, PWMCounter As Byte
;#DEFINE MOTOR PORTA.0
;Dir MOTOR Out
	BCF	TRISA,0
;Call the initialisation routine
;InitMotorControl
	CALL	INITMOTORCONTROL
;Main routine
;Do
SYSDOLOOP_S1:
;Increase speed to full over 2.5 seconds
;For Speed = 0 To 100
	MOVLW	255
	MOVWF	SPEED
SYSFORLOOP1:
	INCF	SPEED,F
;MotorSpeed = Speed
	MOVF	SPEED,W
	MOVWF	MOTORSPEED
;Wait 25 ms
	MOVLW	25
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;Next
	MOVLW	100
	SUBWF	SPEED,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP1
SYSFORLOOPEND1:
;Hold speed
;Wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;Decrease speed to zero over 2.5 seconds
;For Speed = 100 To 0
	MOVLW	101
	MOVWF	SPEED
SYSFORLOOP2:
	DECF	SPEED,F
;MotorSpeed = Speed
	MOVF	SPEED,W
	MOVWF	MOTORSPEED
;Wait 25 ms
	MOVLW	25
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;Next
	MOVF	SPEED,W
	SUBLW	0
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP2
SYSFORLOOPEND2:
;Hold speed
;Wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
;Setup routine
;PWM sub
;This will be called when Timer 0 overflows
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

DELAY_MS:
	INCF	SYSWAITTEMPMS_H, F
DMS_START:
	MOVLW	14
	MOVWF	DELAYTEMP2
DMS_OUTER:
	MOVLW	189
	MOVWF	DELAYTEMP
DMS_INNER:
	DECFSZ	DELAYTEMP, F
	GOTO	DMS_INNER
	DECFSZ	DELAYTEMP2, F
	GOTO	DMS_OUTER
	DECFSZ	SYSWAITTEMPMS, F
	GOTO	DMS_START
	DECFSZ	SYSWAITTEMPMS_H, F
	GOTO	DMS_START
	RETURN

;********************************************************************************

DELAY_S:
DS_START:
	MOVLW	232
	MOVWF	SYSWAITTEMPMS
	MOVLW	3
	MOVWF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
	DECFSZ	SYSWAITTEMPS, F
	GOTO	DS_START
	RETURN

;********************************************************************************

;SOURCE: 33_USING_AN_INTERRUPT_TO_MANAGE_THE_PWM_SIGNAL_TO_CONTROL_AN_LEDS_BRIGHTNESS.GCB (56)
INITMOTORCONTROL:
;Clear variables
;MotorSpeed = 0
	CLRF	MOTORSPEED
;PWMCounter = 0
	CLRF	PWMCOUNTER
;Add a handler for the interrupt
;On Interrupt Timer0Overflow Call PWMHandler
BANKSEL	PIE0
;B7: ASM Source was:  BSF PIE0,TMR0IE
	BSF	PIE0,5
;InitTimer0(Osc, TMR0_FOSC4 + PRE0_1 , POST0_1)
	MOVLW	1
	BANKSEL	TMRSOURCE
	MOVWF	TMRSOURCE
	MOVLW	64
	MOVWF	TMRPRES
	CLRF	TMRPOST
	CALL	INITTIMER0178
;StartTimer 0
	CLRF	TMRNUMBER
	GOTO	STARTTIMER

;********************************************************************************

;SOURCE: SYSTEM.H (129)
INITSYS:
;asm showdebug This code block sets the internal oscillator to ChipMHz
;asm showdebug Default settings for microcontrollers with _OSCCON1_
;Default OSCCON1 typically, NOSC HFINTOSC; NDIV 1 - Common as this simply sets the HFINTOSC
;OSCCON1 = 0x60
	MOVLW	96
BANKSEL	OSCCON1
MOVWF	OSCCON1
;Default value typically, CSWHOLD may proceed; SOSCPWR Low power
;OSCCON3 = 0x00
CLRF	OSCCON3
;Default value typically, MFOEN disabled; LFOEN disabled; ADOEN disabled; SOSCEN disabled; EXTOEN disabled; HFOEN disabled
;OSCEN = 0x00
CLRF	OSCEN
;Default value
;OSCTUNE = 0x00
CLRF	OSCTUNE
;asm showdebug The MCU is a chip family ChipFamily
;asm showdebug OSCCON type is 102
;Set OSCFRQ values for MCUs with OSCSTAT... the 16F18855 MCU family
;OSCFRQ = 0b00000110
	MOVLW	6
MOVWF	OSCFRQ
;asm showdebug _Complete_the_chip_setup_of_BSR,ADCs,ANSEL_and_other_key_setup_registers_or_register_bits
;Ensure all ports are set for digital I/O and, turn off A/D
;SET ADFM OFF
BANKSEL	ADCON0
;B7: ASM Source was:  BCF ADCON0,ADFRM0
	BCF	ADCON0,2
;Switch off A/D Var(ADCON0)
;SET ADCON0.ADON OFF
;B7: ASM Source was:  BCF ADCON0,ADON
	BCF	ADCON0,7
;ANSELA = 0
BANKSEL	ANSELA
CLRF	ANSELA
;ANSELB = 0
CLRF	ANSELB
;ANSELC = 0
CLRF	ANSELC
;Set comparator register bits for many MCUs with register CM2CON0
;C2ON = 0
BANKSEL	CM2CON0
;B7: ASM Source was:  BCF CM2CON0,C2ON
	BCF	CM2CON0,7
;C1ON = 0
;B7: ASM Source was:  BCF CM1CON0,C1ON
	BCF	CM1CON0,7
;
;'Turn off all ports
;PORTA = 0
BANKSEL	PORTA
CLRF	PORTA
;PORTB = 0
CLRF	PORTB
;PORTC = 0
CLRF	PORTC
;PORTE = 0
CLRF	PORTE
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
	ANDWF	T0CON1,W
	MOVWF	SYSTEMP1
	IORWF	TMRPRES,F
;Set the Source bit
;IF TMRSource <> OSC  THEN
	DECF	TMRSOURCE,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ELSE12_1
;SET TMRPost.5 ON
	BSF	TMRPOST,5
;ELSE
	GOTO	ENDIF12
ELSE12_1:
;SET TMRPost.5 OFF
	BCF	TMRPOST,5
;END IF
ENDIF12:
;Write the TOCON register
;T0CON1 = TMRPres
	MOVF	TMRPRES,W
MOVWF	T0CON1
;Assumed for code below Timer0 is 16-bit capable
;Set Postscaler
;Re-Use TMRPost as T0CON0 Temp register
;Keep T0CON0 7:5  and write bits 5:0 to register
;Bits therefore will be cleared!
;TMRPost = (T0CON0 And 224) OR TMRPost
	MOVLW	224
	ANDWF	T0CON0,W
	MOVWF	SYSTEMP1
	IORWF	TMRPOST,F
;Set TO16BIT
;Set TMRPost.4 OFF '8-bit Timer0
	BCF	TMRPOST,4
;Write the TOCON register
;T0CON0 = TMRPost
	MOVF	TMRPOST,W
MOVWF	T0CON0
	RETURN

;********************************************************************************

;SOURCE: 33_USING_AN_INTERRUPT_TO_MANAGE_THE_PWM_SIGNAL_TO_CONTROL_AN_LEDS_BRIGHTNESS.GCB (70)
PWMHANDLER:
;If MotorSpeed > PWMCounter Then
	MOVF	MOTORSPEED,W
	SUBWF	PWMCOUNTER,W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ELSE3_1
;Set MOTOR On
	BSF	LATA,0
;Else
	GOTO	ENDIF3
ELSE3_1:
;Set MOTOR Off
	BCF	LATA,0
;End If
ENDIF3:
;PWMCounter += 1
	INCF	PWMCOUNTER,F
;If PWMCounter = 100 Then PWMCounter = 0
	MOVLW	100
	SUBWF	PWMCOUNTER,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	CLRF	PWMCOUNTER
	RETURN

;********************************************************************************

;SOURCE: TIMER.H (704)
STARTTIMER:
;IF TMRNumber = 0 then Set T0EN on
	MOVF	TMRNUMBER,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
;B7: ASM Source was:  BSF T0CON0,T0EN
	BSF	T0CON0,7
;IF TMRNumber = 1 then Set TMR1ON on
	DECF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF6
BANKSEL	T1CON
;B7: ASM Source was:  BSF T1CON,TMR1ON
	BSF	T1CON,0
ENDIF6:
;IF TMRNumber = 2 then Set TMR2ON on
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF7
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,TMR2ON
	BSF	T2CON,7
ENDIF7:
;IF TMRNumber = 3 then Set TMR3ON on
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF8
BANKSEL	T3CON
;B7: ASM Source was:  BSF T3CON,TMR3ON
	BSF	T3CON,0
ENDIF8:
;IF TMRNumber = 4 then Set TMR4ON on
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF9
BANKSEL	T4CON
;B7: ASM Source was:  BSF T4CON,TMR4ON
	BSF	T4CON,7
ENDIF9:
;IF TMRNumber = 5 then Set TMR5ON on
	MOVLW	5
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF10
BANKSEL	T5CON
;B7: ASM Source was:  BSF T5CON,TMR5ON
	BSF	T5CON,0
ENDIF10:
;IF TMRNumber = 6 then Set TMR6ON on
	MOVLW	6
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF11
BANKSEL	T6CON
;B7: ASM Source was:  BSF T6CON,TMR6ON
	BSF	T6CON,7
ENDIF11:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 1
	ORG	2048
;START OF PROGRAM MEMORY PAGE 2
	ORG	4096
;START OF PROGRAM MEMORY PAGE 3
	ORG	6144
	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
