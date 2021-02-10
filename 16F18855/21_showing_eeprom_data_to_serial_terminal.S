;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\21_showing_eeprom_data_to_serial_terminal.S"
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
 COMPORT                          EQU 32                    ; 0X20
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 DISPLAYNEWLINE                   EQU 33                    ; 0X21
 EEDATA                           EQU 34                    ; 0X22
 EEDATAVALUE                      EQU 35                    ; 0X23
 EEPROMADDRESS                    EQU 36                    ; 0X24
 HSERPRINTCRLFCOUNT               EQU 37                    ; 0X25
 INDATA                           EQU 38                    ; 0X26
 OUTDATA                          EQU 39                    ; 0X27
 PRINTLEN                         EQU 40                    ; 0X28
 RANDOM                           EQU 41                    ; 0X29
 RANDOMSEED                       EQU 42                    ; 0X2A
 RANDOMSEED_H                     EQU 43                    ; 0X2B
 RANDOMTEMP                       EQU 44                    ; 0X2C
 RANDOMTEMP_H                     EQU 45                    ; 0X2D
 SERDATA                          EQU 46                    ; 0X2E
 STRINGPOINTER                    EQU 47                    ; 0X2F
 SYSBITVAR0                       EQU 48                    ; 0X30
 SYSBYTETEMPA                     EQU 117                    ; 0X75
 SYSBYTETEMPB                     EQU 121                    ; 0X79
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSEEADDRESS                     EQU 49                    ; 0X31
 SYSEEADDRESS_H                   EQU 50                    ; 0X32
 SYSEEPROMADDRESS                 EQU 51                    ; 0X33
 SYSEEPROMADDRESS_H               EQU 52                    ; 0X34
 SYSPRINTDATAHANDLER              EQU 53                    ; 0X35
 SYSPRINTDATAHANDLER_H            EQU 54                    ; 0X36
 SYSPRINTTEMP                     EQU 55                    ; 0X37
 SYSREPEATTEMP1                   EQU 56                    ; 0X38
 SYSREPEATTEMP2                   EQU 57                    ; 0X39
 SYSSTRINGA                       EQU 119                    ; 0X77
 SYSSTRINGA_H                     EQU 120                    ; 0X78
 SYSSTRINGTEMP                    EQU 58                    ; 0X3A
 SYSTEMP1                         EQU 59                    ; 0X3B
 SYSTEMP1_H                       EQU 60                    ; 0X3C
 SYSTEMP2                         EQU 61                    ; 0X3D
 SYSTEMP2_H                       EQU 62                    ; 0X3E
 SYSVALTEMP                       EQU 63                    ; 0X3F
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 _HEXPICAS                        EQU 124                    ; 0X7C

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 4
 AFSR0_H                          EQU 5
 SYS_HEXPICAS_0                   EQU 124
 SYS_HEXPICAS_1                   EQU 125
 SYS_HEXPICAS_2                   EQU 126

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
	CALL	INITPPS
	CALL	INITUSART
	CALL	INITRANDOM
;AUTOMATIC PIN DIRECTION SETTING
	BSF	TRISA,5

;START OF THE MAIN PROGRAM
;''
;''******************************************************************
;'' Lesson 13 - "EEPROM"
;''
;'' This lesson will provide code for writing and reading a single byte onto
;'' the on-board EEPROM. EEPROM is non-volatile memory, meaning that it does
;'' not lose its value when power is shut off. This is unlike RAM, which will
;'' lose its value when no power is applied. The EEPROM is useful for storing
;'' variables that must still be present during no power.
;'' It is also convenient to use if the entire RAM space is used up.
;'' Writes and reads to the EEPROM are practically instant and are much faster
;'' than program memory operations.
;'' This will show the value of the EEPROM on the serial Terminal.
;'' You can experiment by changing the variable 'Outdata' from Random function to a specific range.  Enjoy.
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
;Set the PPS of the PWM and the RS232 ports.
;Set the PPS for this solution.
;Dim DISPLAYNEWLINE, OUTDATA, INDATA As Byte
;#DEFINE USART_BAUD_RATE 19200
;#DEFINE USART_TX_BLOCKING
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
;#DEFINE SWITCH_DOWN         0
;#DEFINE SWITCH_UP           1
;#DEFINE SWITCH              PORTA.5
;Now assumes Serial Terminal is operational
;Dim EEPromAddress As Byte
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "EEPROM Test and Show EEProm Results"
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;Do Forever
SYSDOLOOP_S1:
;Set LEDD2 Off
	BCF	LATA,0
;Set LEDD3 Off
	BCF	LATA,1
;Set LEDD4 Off
	BCF	LATA,2
;Set LEDD5 Off
	BCF	LATA,3
;HSerPrint "     "
	MOVLW	LOW STRINGTABLE2
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE2) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;For EEPromAddress = 0 To 15
	MOVLW	255
	MOVWF	EEPROMADDRESS
SYSFORLOOP1:
	INCF	EEPROMADDRESS,F
;HSerPrint Hex(EEPromAddress)
	MOVF	EEPROMADDRESS,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;HSerPrint " "
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;Next
	MOVLW	15
	SUBWF	EEPROMADDRESS,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP1
SYSFORLOOPEND1:
;For EEPromAddress = 0 To 255
	MOVLW	255
	MOVWF	EEPROMADDRESS
SYSFORLOOP2:
	INCF	EEPROMADDRESS,F
;DisplayNewLine = EEPromAddress % 16
	MOVF	EEPROMADDRESS,W
	MOVWF	SYSBYTETEMPA
	MOVLW	16
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPX,W
	MOVWF	DISPLAYNEWLINE
;If DisplayNewLine = 0 Then
	MOVF	DISPLAYNEWLINE,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF2
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint Hex(EEPromAddress)
	MOVF	EEPROMADDRESS,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;HSerPrint ": "
	MOVLW	LOW STRINGTABLE4
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE4) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;End If
ENDIF2:
;HSerPrint " "
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;Outdata = Random
	CALL	FN_RANDOM
	MOVF	RANDOM,W
	MOVWF	OUTDATA
;Outdata = EEPromAddress
;EPWrite ( EEPromAddress, Outdata )
	MOVF	EEPROMADDRESS,W
	MOVWF	SYSEEADDRESS
	CLRF	SYSEEADDRESS_H
	MOVF	OUTDATA,W
	MOVWF	EEDATA
	CALL	NVMADR_EPWRITE
;EPRead  ( EEPromAddress, Indata )
	MOVF	EEPROMADDRESS,W
	MOVWF	SYSEEADDRESS
	CLRF	SYSEEADDRESS_H
	CALL	NVMADR_EPREAD
	MOVF	EEDATAVALUE,W
	MOVWF	INDATA
;If Outdata = Indata Then
	SUBWF	OUTDATA,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ELSE3_1
;HSerPrint  Hex(Indata)
	MOVF	INDATA,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;Else
	GOTO	ENDIF3
ELSE3_1:
;HSerPrint  "--"
	MOVLW	LOW STRINGTABLE5
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE5) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;End If
ENDIF3:
;Next
	MOVLW	255
	SUBWF	EEPROMADDRESS,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP2
SYSFORLOOPEND2:
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint   "End of EEProm Program and Display"
	MOVLW	LOW STRINGTABLE6
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE6) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;Set LEDD2 On
	BSF	LATA,0
;Set LEDD3 On
	BSF	LATA,1
;Set LEDD4 On
	BSF	LATA,2
;Set LEDD5 On
	BSF	LATA,3
;Wait While SWITCH = On
SYSWAITLOOP1:
	BTFSC	PORTA,5
	GOTO	SYSWAITLOOP1
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
;End
	GOTO	BASPROGRAMEND
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

;OVERLOADED SIGNATURE: STRING:BYTE:, SOURCE: USART.H (1382)
HSERPRINT294:
;PrintLen = PrintData(0)
	MOVF	SYSPRINTDATAHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSPRINTDATAHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	PRINTLEN
;If PrintLen <> 0 then
	MOVF	PRINTLEN,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF14
;Write Data
;for SysPrintTemp = 1 to PrintLen
	CLRF	SYSPRINTTEMP
	MOVLW	1
	SUBWF	PRINTLEN,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOPEND4
SYSFORLOOP4:
	INCF	SYSPRINTTEMP,F
;HSerSend(PrintData(SysPrintTemp),comport )
	MOVF	SYSPRINTTEMP,W
	ADDWF	SYSPRINTDATAHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSPRINTDATAHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SERDATA
	CALL	HSERSEND284
;next
	MOVF	PRINTLEN,W
	SUBWF	SYSPRINTTEMP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP4
SYSFORLOOPEND4:
;End If
ENDIF14:
;CR
	RETURN

;********************************************************************************

;SOURCE: USART.H (1538)
HSERPRINTCRLF:
;repeat HSerPrintCRLFCount
	MOVF	HSERPRINTCRLFCOUNT,W
	MOVWF	SYSREPEATTEMP2
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	GOTO	SYSREPEATLOOPEND2
SYSREPEATLOOP2:
;HSerSend(13,comport)
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND284
;HSerSend(10,comport)
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND284
;end Repeat
	DECFSZ	SYSREPEATTEMP2,F
	GOTO	SYSREPEATLOOP2
SYSREPEATLOOPEND2:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (848)
HSERSEND284:
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	DECF	COMPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF17
;USART_TX_BLOCKING
;Wait While TXIF = Off
SYSWAITLOOP3:
BANKSEL	PIR3
;B7: ASM Source was:  BTFSS PIR3,TXIF
	BTFSS	PIR3,4
	GOTO	SYSWAITLOOP3
;ensure any previous operation has completed
;Wait until TRMT = 1
SYSWAITLOOP4:
BANKSEL	TX1STA
;B7: ASM Source was:  BTFSS TX1STA,TRMT
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP4
;Write the data byte to the USART.
;Sets register to value of SerData - where register could be TXREG or TXREG1 or U1TXB set via the #samevar
;TXREG = SerData
	BANKSEL	SERDATA
	MOVF	SERDATA,W
;B9: ASM Source was:  BANKSEL TXREG
BANKSEL	TX1REG
;B9: ASM Source was:  MOVWF TXREG
MOVWF	TX1REG
;Add USART_DELAY after the byte is sent by the USART module
;Wait USART_DELAY
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
BANKSEL	STATUS
	CALL	DELAY_MS
;end if
ENDIF17:
	RETURN

;********************************************************************************

;SOURCE: 21_SHOWING_EEPROM_DATA_TO_SERIAL_TERMINAL.GCB (41)
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
;LOCKPPS
;Macro Source: stdbasic.h (89)
;PPSLOCK = 0x55
	MOVLW	85
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

;SOURCE: RANDOM.H (28)
INITRANDOM:
;Dim RandomSeed As Word
;RandomSeed = RandStart
	MOVLW	157
	MOVWF	RANDOMSEED
	MOVLW	236
	MOVWF	RANDOMSEED_H
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

;SOURCE: USART.H (539)
INITUSART:
;asm showdebug Values_calculated_in_the_script
;asm showdebug _SPBRGH_TEMP=_ SPBRGH_TEMP
;asm showdebug _SPBRGL_TEMP=_ SPBRGL_TEMP
;asm showdebug _BRG16_TEMP=_ BRG16_TEMP
;asm showdebug _BRGH_TEMP=_ BRGH_TEMP
;Set baud rate for legacy chips
;SPBRG = SPBRGL_TEMP
	MOVLW	159
;B9: ASM Source was:  BANKSEL SPBRG
BANKSEL	SP1BRGL
;B9: ASM Source was:  MOVWF SPBRG
MOVWF	SP1BRGL
;Set baud rate for chips with BRG16 bit
;SPBRGH = SPBRGH_TEMP
	MOVLW	1
MOVWF	SP1BRGH
;SPBRGL = SPBRGL_TEMP
	MOVLW	159
MOVWF	SP1BRGL
;BRG16: 16-bit Baud Rate Generator bit
;1 = 16-bit Baud Rate Generator is used
;0 = 8-bit Baud Rate Generator is used
;BRG16 = BRG16_TEMP
;B7: ASM Source was:  BSF BAUD1CON,BRG16
	BSF	BAUD1CON,3
;Set High Baud Rate Select bit
;BRGH = BRGH_TEMP
;B7: ASM Source was:  BSF TX1STA,BRGH
	BSF	TX1STA,2
;Enable async and TX mode for most non K42
;Set SYNC Off
;Set TXEN On
;Changed to canskip to silently exit when no USART
;[canskip]SYNC=0
;B7: ASM Source was:  BCF TX1STA,SYNC_TX1STA
	BCF	TX1STA,4
;[canskip]TXEN=1
;B7: ASM Source was:  BSF TX1STA,TXEN
	BSF	TX1STA,5
;SPEN=1
;B7: ASM Source was:  BSF RC1STA,SPEN
	BSF	RC1STA,7
;Enable TX and RX
;CREN=1
;B7: ASM Source was:  BSF RC1STA,CREN
	BSF	RC1STA,4
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: EEPROM.H (428)
NVMADR_EPREAD:
;Dim SysEEPromAddress As Word
;SysEEPromAddress = SysEEAddress + 0x7000
	MOVLW	0
	ADDWF	SYSEEADDRESS,W
	MOVWF	SYSEEPROMADDRESS
	MOVLW	112
	ADDWFC	SYSEEADDRESS_H,W
	MOVWF	SYSEEPROMADDRESS_H
;NVMADRH = SysEEPromAddress_h
BANKSEL	NVMADRH
MOVWF	NVMADRH
;NVMADRL = SysEEPromAddress
	BANKSEL	SYSEEPROMADDRESS
	MOVF	SYSEEPROMADDRESS,W
BANKSEL	NVMADRL
MOVWF	NVMADRL
;NVMREGS = 1
;B7: ASM Source was:  BSF NVMCON1,NVMREGS
	BSF	NVMCON1,6
;RD = 1
;B7: ASM Source was:  BSF NVMCON1,RD
	BSF	NVMCON1,0
;NOP     ' NOPs may be required for latency at high frequencies
	NOP
;NOP
	NOP
;NOP
	NOP
;NOP
	NOP
;EEDataValue = NVMDATL
	MOVF	NVMDATL,W
	BANKSEL	EEDATAVALUE
	MOVWF	EEDATAVALUE
	RETURN

;********************************************************************************

;SOURCE: EEPROM.H (284)
NVMADR_EPWRITE:
;dim IntState as bit
;IntState = GIE
	BCF	SYSBITVAR0,1
;B7: ASM Source was:  BTFSC INTCON,GIE
	BTFSC	INTCON,7
	BSF	SYSBITVAR0,1
;Dim SysEEPromAddress As Word
;ALL 16F NVMREGS Devices Except 18FxxK40/K42
;SysEEPromAddress = SysEEAddress + 0x7000
	MOVLW	0
	ADDWF	SYSEEADDRESS,W
	MOVWF	SYSEEPROMADDRESS
	MOVLW	112
	ADDWFC	SYSEEADDRESS_H,W
	MOVWF	SYSEEPROMADDRESS_H
;NVMADRH =SysEEPromAddress_h
BANKSEL	NVMADRH
MOVWF	NVMADRH
;NVMADRL =SysEEPromAddress
	BANKSEL	SYSEEPROMADDRESS
	MOVF	SYSEEPROMADDRESS,W
BANKSEL	NVMADRL
MOVWF	NVMADRL
;NVMDATL = EEData
	BANKSEL	EEDATA
	MOVF	EEDATA,W
BANKSEL	NVMDATL
MOVWF	NVMDATL
;NVMREGS = 1
;B7: ASM Source was:  BSF NVMCON1,NVMREGS
	BSF	NVMCON1,6
;FREE =0b'0'
;B7: ASM Source was:  BCF NVMCON1,FREE
	BCF	NVMCON1,4
;WREN= 0b'1'
;B7: ASM Source was:  BSF NVMCON1,WREN
	BSF	NVMCON1,2
;GIE = 0
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
;NVMCON2 = 0x55
	MOVLW	85
MOVWF	NVMCON2
;NVMCON2 = 0xAA
	MOVLW	170
MOVWF	NVMCON2
;WR = 1
;B7: ASM Source was:  BSF NVMCON1,WR
	BSF	NVMCON1,1
;NOP     ' NOPs may be required for latency at high frequencies
	NOP
;NOP
	NOP
;NOP
	NOP
;NOP
	NOP
;NOP
	NOP
;wait while WR = 1
SYSWAITLOOP2:
;B7: ASM Source was:  BTFSC NVMCON1,WR
	BTFSC	NVMCON1,1
	GOTO	SYSWAITLOOP2
;WREN= 0b'0'
;B7: ASM Source was:  BCF NVMCON1,WREN
	BCF	NVMCON1,2
;Restore interrupt to initial  State
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

;SOURCE: RANDOM.H (34)
FN_RANDOM:
;Repeat 7
	MOVLW	7
	MOVWF	SYSREPEATTEMP1
SYSREPEATLOOP1:
;Dim RandomTemp As Word
;Dim RandomSeed As Word
;RandomTemp = RandomSeed
	MOVF	RANDOMSEED,W
	MOVWF	RANDOMTEMP
	MOVF	RANDOMSEED_H,W
	MOVWF	RANDOMTEMP_H
;Rotate RandomTemp Left Simple
	RLF	RANDOMTEMP_H,W
	RLF	RANDOMTEMP,F
	RLF	RANDOMTEMP_H,F
;Taps at 16, 15, 13, 11, And with b'1101 0100 0000 0000' = D800
;RandomSeed = RandomTemp XOR (Not (RandomSeed And 1) + 1 And 0xB400)
	MOVLW	1
	ANDWF	RANDOMSEED,W
	MOVWF	SYSTEMP1
	CLRF	SYSTEMP1_H
	COMF	SYSTEMP1,W
	MOVWF	SYSTEMP2
	COMF	SYSTEMP1_H,W
	MOVWF	SYSTEMP2_H
	MOVLW	1
	ADDWF	SYSTEMP2,W
	MOVWF	SYSTEMP1
	MOVLW	0
	ADDWFC	SYSTEMP2_H,W
	MOVWF	SYSTEMP1_H
	CLRF	SYSTEMP2
	MOVLW	180
	ANDWF	SYSTEMP1_H,W
	MOVWF	SYSTEMP2_H
	MOVF	RANDOMTEMP,W
	XORWF	SYSTEMP2,W
	MOVWF	RANDOMSEED
	MOVF	RANDOMTEMP_H,W
	XORWF	SYSTEMP2_H,W
	MOVWF	RANDOMSEED_H
;Random = Random Xor RandomSeed_H
	MOVF	RANDOM,W
	XORWF	RANDOMSEED_H,W
	MOVWF	RANDOM
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2644)
SYSDIVSUB:
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;Check for div/0
;movf SysByteTempB, F
	MOVF	SYSBYTETEMPB, F
;btfsc STATUS, Z
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
;return
	RETURN
;Main calc routine
;SysByteTempX = 0
	CLRF	SYSBYTETEMPX
;SysDivLoop = 8
	MOVLW	8
	MOVWF	SYSDIVLOOP
SYSDIV8START:
;bcf STATUS, C
;B7: ASM Source was:  BCF STATUS, C
	BCF	STATUS,0
;rlf SysByteTempA, F
	RLF	SYSBYTETEMPA, F
;rlf SysByteTempX, F
	RLF	SYSBYTETEMPX, F
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W
;subwf SysByteTempX, F
	SUBWF	SYSBYTETEMPX, F
;bsf SysByteTempA, 0
	BSF	SYSBYTETEMPA, 0
;btfsc STATUS, C
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
;goto Div8NotNeg
	GOTO	DIV8NOTNEG
;bcf SysByteTempA, 0
	BCF	SYSBYTETEMPA, 0
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W
;addwf SysByteTempX, F
	ADDWF	SYSBYTETEMPX, F
DIV8NOTNEG:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv8Start
	GOTO	SYSDIV8START
	RETURN

;********************************************************************************

SYSSTRINGTABLES:
	MOVF	SYSSTRINGA_H,W
MOVWF	PCLATH
	MOVF	SYSSTRINGA,W
	INCF	SYSSTRINGA,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SYSSTRINGA_H,F
MOVWF	PCL

STRINGTABLE1:
	RETLW	35
	RETLW	69	;E
	RETLW	69	;E
	RETLW	80	;P
	RETLW	82	;R
	RETLW	79	;O
	RETLW	77	;M
	RETLW	32	; 
	RETLW	84	;T
	RETLW	101	;E
	RETLW	115	;S
	RETLW	116	;T
	RETLW	32	; 
	RETLW	97	;A
	RETLW	110	;N
	RETLW	100	;D
	RETLW	32	; 
	RETLW	83	;S
	RETLW	104	;H
	RETLW	111	;O
	RETLW	119	;W
	RETLW	32	; 
	RETLW	69	;E
	RETLW	69	;E
	RETLW	80	;P
	RETLW	114	;R
	RETLW	111	;O
	RETLW	109	;M
	RETLW	32	; 
	RETLW	82	;R
	RETLW	101	;E
	RETLW	115	;S
	RETLW	117	;U
	RETLW	108	;L
	RETLW	116	;T
	RETLW	115	;S

	ALIGN	2;X3

STRINGTABLE2:
	RETLW	5
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE3:
	RETLW	1
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE4:
	RETLW	2
	RETLW	58	;:
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE5:
	RETLW	2
	RETLW	45	;-
	RETLW	45	;-

	ALIGN	2;X3

STRINGTABLE6:
	RETLW	33
	RETLW	69	;E
	RETLW	110	;N
	RETLW	100	;D
	RETLW	32	; 
	RETLW	111	;O
	RETLW	102	;F
	RETLW	32	; 
	RETLW	69	;E
	RETLW	69	;E
	RETLW	80	;P
	RETLW	114	;R
	RETLW	111	;O
	RETLW	109	;M
	RETLW	32	; 
	RETLW	80	;P
	RETLW	114	;R
	RETLW	111	;O
	RETLW	103	;G
	RETLW	114	;R
	RETLW	97	;A
	RETLW	109	;M
	RETLW	32	; 
	RETLW	97	;A
	RETLW	110	;N
	RETLW	100	;D
	RETLW	32	; 
	RETLW	68	;D
	RETLW	105	;I
	RETLW	115	;S
	RETLW	112	;P
	RETLW	108	;L
	RETLW	97	;A
	RETLW	121	;Y

	ALIGN	2;X3

;********************************************************************************

;SOURCE: PICAS.H (7)
FN__HEXPICAS:
;_HexPICAS(0) = 2
	MOVLW	2
	MOVWF	SYS_HEXPICAS_0
;dim SysStringTemp as byte
;Low nibble
;SysStringTemp = SysValTemp And 0x0F
	MOVLW	15
	ANDWF	SYSVALTEMP,W
	MOVWF	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	SUBLW	9
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF8
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F
ENDIF8:
;_HexPICAS(2) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W
	MOVWF	SYS_HEXPICAS_2
;Get high nibble
;For SysStringTemp = 1 to 4
	CLRF	SYSSTRINGTEMP
SYSFORLOOP3:
	INCF	SYSSTRINGTEMP,F
;Rotate SysValTemp Right
	RRF	SYSVALTEMP,F
;Next
	MOVLW	4
	SUBWF	SYSSTRINGTEMP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP3
SYSFORLOOPEND3:
;SysStringTemp = SysValTemp And 0x0F
	MOVLW	15
	ANDWF	SYSVALTEMP,W
	MOVWF	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	SUBLW	9
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF10
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F
ENDIF10:
;_HexPICAS(1) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W
	MOVWF	SYS_HEXPICAS_1
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
