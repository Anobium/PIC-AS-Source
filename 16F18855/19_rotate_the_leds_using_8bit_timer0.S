;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\19_rotate_the_leds_using_8bit_timer0.S"
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
 SYSTEMP1                         EQU 32                    ; 0X20
 TMRNUMBER                        EQU 33                    ; 0X21
 TMRPOST                          EQU 34                    ; 0X22
 TMRPRES                          EQU 35                    ; 0X23
 TMRSOURCE                        EQU 36                    ; 0X24
 TMRVALUE                         EQU 37                    ; 0X25
 TMRVALUE_H                       EQU 38                    ; 0X26

;********************************************************************************

 PSECT   RESETVEC,delta=2, abs
 RESETVEC:
;VECTORS
	ORG	0
	PAGESEL	BASPROGRAMSTART
	GOTO	BASPROGRAMSTART
	ORG	4
	RETFIE

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
	ORG	5
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	CALL	INITSYS

;START OF THE MAIN PROGRAM
;''
;''******************************************************************
;''
;''  Timer0 is a counter implemented in the processor. It may be used to count instruction
;''  cycles or external events, that occur at or below the instruction cycle rate.
;''  In the PIC18, Timer0 can be used as either an 8-bit or 16-bit counter, or timer. The
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
;' -------------------LATA-----------------
;' Bit#:  -7---6---5---4---3---2---1---0---
;' LED:   ---------------|D5 |D4 |D3 |D1 |-
;'-----------------------------------------
;'
;Dir porta Out
CLRF	TRISA
;porta = b'00000001'
	MOVLW	1
MOVWF	PORTA
;Setup the timer.
;params    Source, Prescaler                , Postscaler
;InitTimer0 Osc, PRE0_16384 + TMR0_HFINTOSC   , POST0_11
	MOVLW	1
	MOVWF	TMRSOURCE
	MOVLW	110
	MOVWF	TMRPRES
	MOVLW	10
	MOVWF	TMRPOST
	CALL	INITTIMER0176
;Start the Timer by writing to TMR0ON bit
;StartTimer 0
	CLRF	TMRNUMBER
	CALL	STARTTIMER
;Set the Timer start value
;SetTimer ( 0, 0xB1 )
	CLRF	TMRNUMBER
	MOVLW	177
	MOVWF	TMRVALUE
	CLRF	TMRVALUE_H
	CALL	SETTIMER173
;Do
SYSDOLOOP_S1:
;Wait While TMR0IF = 0
SYSWAITLOOP1:
BANKSEL	PIR0
;B7: ASM Source was:  BTFSS PIR0,TMR0IF
	BTFSS	PIR0,5
	GOTO	SYSWAITLOOP1
;Clearing IF flag.
;TMR0IF = 0
;B7: ASM Source was:  BCF PIR0,TMR0IF
	BCF	PIR0,5
;Set the carry flag
;C = 0
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate porta Right
BANKSEL	PORTA
	RRF	PORTA,F
;If C = 1 Then porta.3 = 1
;B7: ASM Source was:  BTFSC STATUS,C
	BTFSC	STATUS,0
	BSF	LATA,3
;Clear the timer to Zero.
;ClearTimer 0
	CLRF	TMRNUMBER
	CALL	CLEARTIMER
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: TIMER.H (858)
CLEARTIMER:
;if TMRNumber = 0 then TMR0L = 0
	MOVF	TMRNUMBER,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
CLRF	TMR0L
;don't clear the TMR0H PR0/MATCH register !
;If TMRNumber = 1 Then
	DECF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF10
;TMR1H = 0
BANKSEL	TMR1H
CLRF	TMR1H
;TMR1L = 0
CLRF	TMR1L
;End If
ENDIF10:
;If TMRNumber = 2 Then TMR2 = 0
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF11
;B9: ASM Source was:  BANKSEL TMR2
BANKSEL	T2TMR
;B9: ASM Source was:  CLRF TMR2
CLRF	T2TMR
ENDIF11:
;If TMRNumber = 3 then
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF12
;TMR3H = 0
BANKSEL	TMR3H
CLRF	TMR3H
;TMR3L = 0
CLRF	TMR3L
;End If
ENDIF12:
;If TMRNumber = 4 Then TMR4 = 0
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF13
;B9: ASM Source was:  BANKSEL TMR4
BANKSEL	T4TMR
;B9: ASM Source was:  CLRF TMR4
CLRF	T4TMR
ENDIF13:
;If TMRNumber = 5 then
	MOVLW	5
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF14
;TMR5H = 0
BANKSEL	TMR5H
CLRF	TMR5H
;TMR5L = 0
CLRF	TMR5L
;End If
ENDIF14:
;If TMRNumber = 6 Then TMR6 = 0
	MOVLW	6
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF15
;B9: ASM Source was:  BANKSEL TMR6
BANKSEL	T6TMR
;B9: ASM Source was:  CLRF TMR6
CLRF	T6TMR
ENDIF15:
BANKSEL	STATUS
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
	ANDWF	T0CON1,W
	MOVWF	SYSTEMP1
	IORWF	TMRPRES,F
;Set the Source bit
;IF TMRSource <> OSC  THEN
	DECF	TMRSOURCE,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ELSE24_1
;SET TMRPost.5 ON
	BSF	TMRPOST,5
;ELSE
	GOTO	ENDIF24
ELSE24_1:
;SET TMRPost.5 OFF
	BCF	TMRPOST,5
;END IF
ENDIF24:
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

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: TIMER.H (1028)
SETTIMER173:
;Dim TMRValue as word
;If TMRNumber = 0 Then
	MOVF	TMRNUMBER,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF16
;TMRValue_H = [byte]TMRValue
	MOVF	TMRVALUE,W
	MOVWF	TMRVALUE_H
;[byte]TMRValue = 0
	CLRF	TMRVALUE
;end if
ENDIF16:
;SetTimer ( TMRNumber, [word]TMRValue )
	GOTO	SETTIMER174

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:WORD:, SOURCE: TIMER.H (1049)
SETTIMER174:
;If TMRNumber = 0 Then
	MOVF	TMRNUMBER,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF17
;Handle chips with TMR0H
;Use default 8-bit mode therefore _TMR0_16BIT_ not defined
;Added to resolve using 8bit Timer0 with enhance timer
;High byte is timer0 register of interest
;TMR0H = TMRValue_H
	MOVF	TMRVALUE_H,W
MOVWF	TMR0H
;End If
ENDIF17:
;If TMRNumber = 1 then
	DECF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF18
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
ENDIF18:
;If TMRNumber = 2 Then
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF19
;TMR2 = TMRValue
	MOVF	TMRVALUE,W
;B9: ASM Source was:  BANKSEL TMR2
BANKSEL	T2TMR
;B9: ASM Source was:  MOVWF TMR2
MOVWF	T2TMR
;End If
ENDIF19:
;If TMRNumber = 3 then
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF20
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
ENDIF20:
;If TMRNumber = 4 Then
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF21
;TMR4 = TMRValue
	MOVF	TMRVALUE,W
;B9: ASM Source was:  BANKSEL TMR4
BANKSEL	T4TMR
;B9: ASM Source was:  MOVWF TMR4
MOVWF	T4TMR
;End If
ENDIF21:
;If TMRNumber = 5 then
	MOVLW	5
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF22
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
ENDIF22:
;If TMRNumber = 6 Then
	MOVLW	6
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF23
;TMR6 = TMRValue
	MOVF	TMRVALUE,W
;B9: ASM Source was:  BANKSEL TMR6
BANKSEL	T6TMR
;B9: ASM Source was:  MOVWF TMR6
MOVWF	T6TMR
;End If
ENDIF23:
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
	GOTO	ENDIF3
BANKSEL	T1CON
;B7: ASM Source was:  BSF T1CON,TMR1ON
	BSF	T1CON,0
ENDIF3:
;IF TMRNumber = 2 then Set TMR2ON on
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF4
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,TMR2ON
	BSF	T2CON,7
ENDIF4:
;IF TMRNumber = 3 then Set TMR3ON on
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF5
BANKSEL	T3CON
;B7: ASM Source was:  BSF T3CON,TMR3ON
	BSF	T3CON,0
ENDIF5:
;IF TMRNumber = 4 then Set TMR4ON on
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF6
BANKSEL	T4CON
;B7: ASM Source was:  BSF T4CON,TMR4ON
	BSF	T4CON,7
ENDIF6:
;IF TMRNumber = 5 then Set TMR5ON on
	MOVLW	5
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF7
BANKSEL	T5CON
;B7: ASM Source was:  BSF T5CON,TMR5ON
	BSF	T5CON,0
ENDIF7:
;IF TMRNumber = 6 then Set TMR6ON on
	MOVLW	6
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF8
BANKSEL	T6CON
;B7: ASM Source was:  BSF T6CON,TMR6ON
	BSF	T6CON,7
ENDIF8:
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
