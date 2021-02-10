;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\15_rotate_the_leds_using_the_timer_overflow_event.S"
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
 SAVEPCLATH                       EQU 32                    ; 0X20
 SYSBITVAR0                       EQU 33                    ; 0X21
 SYSBSR                           EQU 34                    ; 0X22
 SYSSTATUS                        EQU 127                    ; 0X7F
 SYSTEMP1                         EQU 35                    ; 0X23
 SYSW                             EQU 126                    ; 0X7E
 TIMEOUT                          EQU 36                    ; 0X24
 TMRNUMBER                        EQU 37                    ; 0X25
 TMRPOST                          EQU 38                    ; 0X26
 TMRPRES                          EQU 39                    ; 0X27
 TMRSOURCE                        EQU 40                    ; 0X28
 TMRVALUE                         EQU 41                    ; 0X29
 TMRVALUE_H                       EQU 42                    ; 0X2A

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
	CALL	BLINK
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
	CALL	INITPPS
;ENABLE INTERRUPTS
;B7: ASM Source was:  BSF INTCON,GIE
	BSF	INTCON,7
;B7: ASM Source was:  BSF INTCON,PEIE
	BSF	INTCON,6

;START OF THE MAIN PROGRAM
;''
;''******************************************************************
;''
;''  Timer0 is a counter implemented in the processor. It may be used to count instruction
;''  cycles or external events, that occur at or below the instruction cycle rate.
;''  In thE pic, Timer0 can be used as either an 8-bit or 16-bit counter, or timer. The
;''  enhanced mid-range core implements only an 8-bit counter.
;''  This lesson configures Timer0 to count instruction cycles and to set a flag when it rolls
;''  over. This frees up the processor to do meaningful work rather than wasting instruction
;''  cycles in a timing loop.
;''  Using a counter provides a convenient method of measuring time or delay loops as it
;''  allows the processor to work on other tasks rather than counting instruction cycles.
;''
;''
;''  LEDs rotate from right to left, similar to Lesson 3, at a rate of ~.5 seconds.
;''
;''
;''  PIC: 16F18855
;''  Compiler: GCB
;''  IDE: GCB@SYN
;''
;''  Board: Xpress Evaluation Board
;''  Date: 13.3.2016
;''
;Chip Settings.
;Set the PPS of the PWM
;Set the PPS for this solution.
;-------------------LATA-----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;LED:   ---------------|D5 |D4 |D3 |D2 |-
;'-----------------------------------------
;'
;Dim TIMEOUT As Byte
;----- Constants
;#DEFINE USART_BAUD_RATE 115200
;#DEFINE USART_TX_BLOCKING
;
;#DEFINE LEDD2 PORTA.0
;#DEFINE LEDD3 PORTA.1
;#DEFINE LEDD4 PORTA.2
;#DEFINE LEDD5 PORTA.3
;Dir     LEDD2 Out
	BCF	TRISA,0
;Dir     LEDD3 Out
	BCF	TRISA,1
;Dir     LEDD4 Out
	BCF	TRISA,2
;Dir     LEDD5 Out
	BCF	TRISA,3
;Set portb.0 as out
;Dir portb.0 Out
	BCF	TRISB,0
;Set the port as an ouput
;Dir porta Out
CLRF	TRISA
;Set the first LED on
;Set LEDD5 On
	BSF	LATA,3
;Initialise the timer.
;Firstly tell the compiler to use a 16bit timer for this demonstration
;#DEFINE TMR0_16BIT
;For this timer we need the following:
;Prescaler
;1:256
;HF int Osc, and
;NOT to sync Timer
;Post scaler
;1:2
;Event will be raised every 1.04s
;InitTimer0 Osc, PRE0_256 + TMR0_HFINTOSC ,  POST0_2
	MOVLW	1
	MOVWF	TMRSOURCE
	MOVLW	104
	MOVWF	TMRPRES
	MOVLW	1
	MOVWF	TMRPOST
	CALL	INITTIMER0178
;Set the type of event
;On Interrupt Timer0Overflow Call blink
BANKSEL	PIE0
;B7: ASM Source was:  BSF PIE0,TMR0IE
	BSF	PIE0,5
;SetTimer ( 0, 0x0bdc )
	BANKSEL	TMRNUMBER
	CLRF	TMRNUMBER
	MOVLW	220
	MOVWF	TMRVALUE
	MOVLW	11
	MOVWF	TMRVALUE_H
	CALL	SETTIMER176
;Start the Timer - you need to start this Timer0!
;StartTimer 0
	CLRF	TMRNUMBER
	CALL	STARTTIMER
;Do Forever
SYSDOLOOP_S1:
;If TimeOut = 1 Then
	DECF	TIMEOUT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF1
;Rotate our LEDs
;Set C Off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate porta Right
	RRF	PORTA,F
;If C = 1 Then porta.3 = 1
;B7: ASM Source was:  BTFSC STATUS,C
	BTFSC	STATUS,0
	BSF	LATA,3
;TimeOut= 0
	CLRF	TIMEOUT
;Set timer to 1 second`
;SetTimer ( 0, 0x0bdc )
	CLRF	TMRNUMBER
	MOVLW	220
	MOVWF	TMRVALUE
	MOVLW	11
	MOVWF	TMRVALUE_H
	CALL	SETTIMER176
;End If
ENDIF1:
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: 15_ROTATE_THE_LEDS_USING_THE_TIMER_OVERFLOW_EVENT.GCB (121)
BLINK:
;TimeOut = 1
	MOVLW	1
	MOVWF	TIMEOUT
;Clear the Timer0 overflow event
;TMR0IF = 0
BANKSEL	PIR0
;B7: ASM Source was:  BCF PIR0,TMR0IF
	BCF	PIR0,5
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: 15_ROTATE_THE_LEDS_USING_THE_TIMER_OVERFLOW_EVENT.GCB (36)
INITPPS:
;UNLOCKPPS
;Macro Source: stdbasic.h (78)
;dim IntState as bit
;IntState = GIE
	BCF	SYSBITVAR0,1
;B7: ASM Source was:  BTFSC INTCON,GIE
	BTFSC	INTCON,7
	BSF	SYSBITVAR0,1
;GIE = 0
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
;PPSLOCK = 0x55
	MOVLW	85
BANKSEL	PPSLOCK
MOVWF	PPSLOCK
;PPSLOCK = 0xAA
	MOVLW	170
MOVWF	PPSLOCK
;PPSLOCKED = 0x00  'unlock PPS
;B7: ASM Source was:  BCF PPSLOCK,PPSLOCKED
	BCF	PPSLOCK,0
;Set the PPS of the RS232 ports.
;RC0->EUSART:TX;
;RC0PPS = 0x0010
	MOVLW	16
BANKSEL	RC0PPS
MOVWF	RC0PPS
;RC1->EUSART:RX;
;RXPPS  = 0x0011
	MOVLW	17
BANKSEL	RXPPS
MOVWF	RXPPS
;//RB0->TMR0:TMR0;
;RB0PPS = 0x18
	MOVLW	24
BANKSEL	RB0PPS
MOVWF	RB0PPS
;LOCKPPS
;Macro Source: stdbasic.h (89)
;PPSLOCK = 0x55
	MOVLW	85
BANKSEL	PPSLOCK
MOVWF	PPSLOCK
;PPSLOCK = 0xAA
	MOVLW	170
MOVWF	PPSLOCK
;PPSLOCKED = 0x01  'lock PPS
;B7: ASM Source was:  BSF PPSLOCK,PPSLOCKED
	BSF	PPSLOCK,0
;GIE = IntState
	BANKSEL	SYSBITVAR0
	BTFSS	SYSBITVAR0,1
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
	BTFSC	SYSBITVAR0,1
;B7: ASM Source was:  BSF INTCON,GIE
	BSF	INTCON,7
	RETURN

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
	GOTO	ELSE20_1
;SET TMRPost.5 ON
	BSF	TMRPOST,5
;ELSE
	GOTO	ENDIF20
ELSE20_1:
;SET TMRPost.5 OFF
	BCF	TMRPOST,5
;END IF
ENDIF20:
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
;Set TMRPost.4 ON '16-bit Timer0
	BSF	TMRPOST,4
;Write the TOCON register
;T0CON0 = TMRPost
	MOVF	TMRPOST,W
MOVWF	T0CON0
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:WORD:, SOURCE: TIMER.H (1049)
SETTIMER176:
;If TMRNumber = 0 Then
	MOVF	TMRNUMBER,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF13
;Handle chips with TMR0H
;TMR0H = TMRValue_H
	MOVF	TMRVALUE_H,W
MOVWF	TMR0H
;TMR0L = TMRValue
	MOVF	TMRVALUE,W
MOVWF	TMR0L
;exit to prevent default setting TMR0L = TMRValue
;exit sub
	RETURN
;End If
ENDIF13:
;If TMRNumber = 1 then
	DECF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF14
;TMR1H = TMRValue_H
	MOVF	TMRVALUE_H,W
BANKSEL	TMR1H
MOVWF	TMR1H
;TMR1L = TMRValue
	BANKSEL	TMRVALUE
	MOVF	TMRVALUE,W
BANKSEL	TMR1L
MOVWF	TMR1L
;End If
ENDIF14:
;If TMRNumber = 2 Then
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF15
;TMR2 = TMRValue
	MOVF	TMRVALUE,W
;B9: ASM Source was:  BANKSEL TMR2
BANKSEL	T2TMR
;B9: ASM Source was:  MOVWF TMR2
MOVWF	T2TMR
;End If
ENDIF15:
;If TMRNumber = 3 then
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF16
;TMR3H = TMRValue_H
	MOVF	TMRVALUE_H,W
BANKSEL	TMR3H
MOVWF	TMR3H
;TMR3L = TMRValue
	BANKSEL	TMRVALUE
	MOVF	TMRVALUE,W
BANKSEL	TMR3L
MOVWF	TMR3L
;End If
ENDIF16:
;If TMRNumber = 4 Then
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF17
;TMR4 = TMRValue
	MOVF	TMRVALUE,W
;B9: ASM Source was:  BANKSEL TMR4
BANKSEL	T4TMR
;B9: ASM Source was:  MOVWF TMR4
MOVWF	T4TMR
;End If
ENDIF17:
;If TMRNumber = 5 then
	MOVLW	5
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF18
;TMR5H = TMRValue_H
	MOVF	TMRVALUE_H,W
BANKSEL	TMR5H
MOVWF	TMR5H
;TMR5L = TMRValue
	BANKSEL	TMRVALUE
	MOVF	TMRVALUE,W
BANKSEL	TMR5L
MOVWF	TMR5L
;End If
ENDIF18:
;If TMRNumber = 6 Then
	MOVLW	6
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF19
;TMR6 = TMRValue
	MOVF	TMRVALUE,W
;B9: ASM Source was:  BANKSEL TMR6
BANKSEL	T6TMR
;B9: ASM Source was:  MOVWF TMR6
MOVWF	T6TMR
;End If
ENDIF19:
BANKSEL	STATUS
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
	GOTO	ENDIF7
BANKSEL	T1CON
;B7: ASM Source was:  BSF T1CON,TMR1ON
	BSF	T1CON,0
ENDIF7:
;IF TMRNumber = 2 then Set TMR2ON on
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF8
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,TMR2ON
	BSF	T2CON,7
ENDIF8:
;IF TMRNumber = 3 then Set TMR3ON on
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF9
BANKSEL	T3CON
;B7: ASM Source was:  BSF T3CON,TMR3ON
	BSF	T3CON,0
ENDIF9:
;IF TMRNumber = 4 then Set TMR4ON on
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF10
BANKSEL	T4CON
;B7: ASM Source was:  BSF T4CON,TMR4ON
	BSF	T4CON,7
ENDIF10:
;IF TMRNumber = 5 then Set TMR5ON on
	MOVLW	5
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF11
BANKSEL	T5CON
;B7: ASM Source was:  BSF T5CON,TMR5ON
	BSF	T5CON,0
ENDIF11:
;IF TMRNumber = 6 then Set TMR6ON on
	MOVLW	6
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF12
BANKSEL	T6CON
;B7: ASM Source was:  BSF T6CON,TMR6ON
	BSF	T6CON,7
ENDIF12:
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
