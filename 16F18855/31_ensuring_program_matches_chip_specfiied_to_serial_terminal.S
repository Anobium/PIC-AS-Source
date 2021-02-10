;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\31_ensuring_program_matches_chip_specfiied_to_serial_terminal.S"
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
 ASC                              EQU 32                    ; 0X20
 COMPORT                          EQU 33                    ; 0X21
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 HSERPRINTCRLFCOUNT               EQU 34                    ; 0X22
 LTRIM                            EQU 9113                    ; 0X2399
 MID                              EQU 9072                    ; 0X2370
 PRINTLEN                         EQU 35                    ; 0X23
 RTRIM                            EQU 9031                    ; 0X2347
 SERDATA                          EQU 36                    ; 0X24
 STRINGPOINTER                    EQU 37                    ; 0X25
 SYSARRAYTEMP1                    EQU 38                    ; 0X26
 SYSARRAYTEMP2                    EQU 39                    ; 0X27
 SYSBYTETEMPA                     EQU 117                    ; 0X75
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSCALCTEMPA                     EQU 117                    ; 0X75
 SYSCHAR                          EQU 40                    ; 0X28
 SYSCHARCOUNT                     EQU 41                    ; 0X29
 SYSCHARLT                        EQU 42                    ; 0X2A
 SYSCHARLTCOUNT                   EQU 43                    ; 0X2B
 SYSCHARRT                        EQU 44                    ; 0X2C
 SYSCHARRTCOUNT                   EQU 45                    ; 0X2D
 SYSCHARSTART                     EQU 46                    ; 0X2E
 SYSPRINTDATAHANDLER              EQU 47                    ; 0X2F
 SYSPRINTDATAHANDLER_H            EQU 48                    ; 0X30
 SYSPRINTTEMP                     EQU 49                    ; 0X31
 SYSREPEATTEMP1                   EQU 50                    ; 0X32
 SYSSTRINGA                       EQU 119                    ; 0X77
 SYSSTRINGA_H                     EQU 120                    ; 0X78
 SYSSTRINGLENGTH                  EQU 118                    ; 0X76
 SYSSTRINGPARAM1                  EQU 9154                    ; 0X23C2
 SYSSTRINGTEMP                    EQU 51                    ; 0X33
 SYSSYSINSTRING2HANDLER           EQU 52                    ; 0X34
 SYSSYSINSTRING2HANDLER_H         EQU 53                    ; 0X35
 SYSSYSINSTRING3HANDLER           EQU 54                    ; 0X36
 SYSSYSINSTRING3HANDLER_H         EQU 55                    ; 0X37
 SYSSYSINSTRINGAHANDLER           EQU 56                    ; 0X38
 SYSSYSINSTRINGAHANDLER_H         EQU 57                    ; 0X39
 SYSSYSINSTRINGHANDLER            EQU 58                    ; 0X3A
 SYSSYSINSTRINGHANDLER_H          EQU 59                    ; 0X3B
 SYSTEMP1                         EQU 60                    ; 0X3C
 SYSTEMP2                         EQU 61                    ; 0X3D
 SYSTEMPARRAY                     EQU 8990                    ; 0X231E
 SYSTEMPLT                        EQU 62                    ; 0X3E
 SYSTEMPRT                        EQU 63                    ; 0X3F
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 SYSWAITTEMPS                     EQU 116                    ; 0X74
 TRIM                             EQU 8949                    ; 0X22F5

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 4
 AFSR0_H                          EQU 5
 SYSMID_0                         EQU 1440

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

;START OF THE MAIN PROGRAM
;'' This demonstration is for Great Cow BASIC
;''
;'' This demonstration how you can check your program is intented for a specific Microcontroller
;''
;''************************************************************************
;''
;''  PIC: 16F18855
;''  Compiler: GCB
;''  IDE: GCB@SYN
;''
;''  Board: Xpress Evaluation Board
;''
;''
;''
;''@author  EvanV
;''@licence GPL
;''@version 1.00
;''@date    22.02.2017
;''***
;----- Configuration
;Chip Settings.
;Generated by PIC PPS Tool for Great Cow Basic
;PPS Tool version: 0.0.5.5
;PinManager data: 07/03/2017
;
;Template comment at the start of the config file
;
;Template comment at the end of the config file
;----- Constants
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
;#DEFINE Potentiometer       PORTA.4
;Dir     Potentiometer In
	BSF	TRISA,4
;#DEFINE SWITCH_DOWN         0
;#DEFINE SWITCH_UP           1
;#DEFINE SWITCH              PORTA.5
;Dir SWITCH                  In
	BSF	TRISA,5
;----- Variables
;No Variables specified in this example. All byte variables are defined upon use.
;----- Quick Command Reference:
;[todo]
;----- Main body of program commences here.
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint  ChipNameStr + " Great Cow BASIC Demo"
	MOVLW	LOW SYSSTRINGPARAM1
MOVWF	FSR1L
	MOVLW	HIGH SYSSTRINGPARAM1
MOVWF	FSR1H
	CLRF	SYSSTRINGLENGTH
	MOVLW	LOW STRINGTABLE68
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE68) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRINGPART
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE1) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRINGPART
	MOVLW	LOW SYSSTRINGPARAM1
MOVWF	FSR0L
	MOVLW	HIGH SYSSTRINGPARAM1
MOVWF	FSR0H
	MOVF	SYSSTRINGLENGTH,W
MOVWF	INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;Wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;If Trim("16F18855") <> ChipNameStr Then
	MOVLW	LOW STRINGTABLE2
	MOVWF	SYSSYSINSTRINGHANDLER
	MOVLW	(HIGH STRINGTABLE2) | 128
	MOVWF	SYSSYSINSTRINGHANDLER_H
	CALL	FN_TRIM
	MOVLW	LOW SYSTEMPARRAY
MOVWF	FSR1L
	MOVLW	HIGH SYSTEMPARRAY
MOVWF	FSR1H
	MOVLW	LOW STRINGTABLE68
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE68) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRING
	MOVLW	LOW TRIM
MOVWF	FSR0L
	MOVLW	HIGH TRIM
MOVWF	FSR0H
	MOVLW	LOW SYSTEMPARRAY
MOVWF	FSR1L
	MOVLW	HIGH SYSTEMPARRAY
MOVWF	FSR1H
	CALL	SYSCOMPEQUALSTRING
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ELSE1_1
;HSerPrint "Wrong Microcontroller program intended for 16F18855"
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;Wait While TRUE
SYSWAITLOOP1:
	GOTO	SYSWAITLOOP1
;Else
	GOTO	ENDIF1
ELSE1_1:
;HSerPrint "The Microcontroller program intended for the "+ChipNameStr
	MOVLW	LOW SYSSTRINGPARAM1
MOVWF	FSR1L
	MOVLW	HIGH SYSSTRINGPARAM1
MOVWF	FSR1H
	CLRF	SYSSTRINGLENGTH
	MOVLW	LOW STRINGTABLE4
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE4) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRINGPART
	MOVLW	LOW STRINGTABLE68
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE68) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRINGPART
	MOVLW	LOW SYSSTRINGPARAM1
MOVWF	FSR0L
	MOVLW	HIGH SYSSTRINGPARAM1
MOVWF	FSR0H
	MOVF	SYSSTRINGLENGTH,W
MOVWF	INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;Wait While TRUE
SYSWAITLOOP2:
	GOTO	SYSWAITLOOP2
;End If
ENDIF1:
;End
	GOTO	BASPROGRAMEND
;----- Support methods.  Subroutines and Functions
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: STRING.H (523)
FN_ASC:
;Asc = 0
	CLRF	ASC
;Get length of string, don't try _asc ing if it's empty
;SysCharCount = SysInStringA(0)
	MOVF	SYSSYSINSTRINGAHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGAHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SYSCHARCOUNT
;If SysCharCount = 0 Then Exit Function
	MOVF	SYSCHARCOUNT,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	RETURN
;if Syschar > SysCharCount Then Exit Function
	MOVF	SYSCHAR,W
	SUBWF	SYSCHARCOUNT,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	RETURN
;Get first char of string, only first character is of interest, Syschar if provided
;Asc = SysInStringA( Syschar )
	MOVF	SYSCHAR,W
	ADDWF	SYSSYSINSTRINGAHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSSYSINSTRINGAHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	ASC
	RETURN

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
	GOTO	ENDIF9
;Write Data
;for SysPrintTemp = 1 to PrintLen
	CLRF	SYSPRINTTEMP
	MOVLW	1
	SUBWF	PRINTLEN,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOPEND2
SYSFORLOOP2:
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
	GOTO	SYSFORLOOP2
SYSFORLOOPEND2:
;End If
ENDIF9:
;CR
	RETURN

;********************************************************************************

;SOURCE: USART.H (1538)
HSERPRINTCRLF:
;repeat HSerPrintCRLFCount
	MOVF	HSERPRINTCRLFCOUNT,W
	MOVWF	SYSREPEATTEMP1
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	GOTO	SYSREPEATLOOPEND1
SYSREPEATLOOP1:
;HSerSend(13,comport)
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND284
;HSerSend(10,comport)
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND284
;end Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (848)
HSERSEND284:
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	DECF	COMPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF23
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
ENDIF23:
	RETURN

;********************************************************************************

;SOURCE: 31_ENSURING_PROGRAM_MATCHES_CHIP_SPECFIIED_TO_SERIAL_TERMINAL.GCB (32)
INITPPS:
;Module: EUSART
;TX > RC0
;RC0PPS = 0x0010
	MOVLW	16
BANKSEL	RC0PPS
MOVWF	RC0PPS
;RC0 > TX (bi-directional)
;TXPPS = 0x0010
	MOVLW	16
BANKSEL	TXPPS
MOVWF	TXPPS
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

;SOURCE: STRING.H (456)
FN_LTRIM:
;Get length of string, return empty string.  If you dont do this you will return an uninitialize value... ooops
;Ltrim = ""
	MOVLW	LOW LTRIM
MOVWF	FSR1L
	MOVLW	HIGH LTRIM
MOVWF	FSR1H
	MOVLW	LOW STRINGTABLE36
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE36) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRING
;SysCharLTCount = SysInString2(0)
	MOVF	SYSSYSINSTRING2HANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRING2HANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SYSCHARLTCOUNT
;If SysCharLTCount = 0 Then Exit Function
	MOVF	SYSCHARLTCOUNT,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	RETURN
;find first non white space in the string
;SysCharLT = 0
	CLRF	SYSCHARLT
;For SysTempLT = 1 to SysCharLTCount
	CLRF	SYSTEMPLT
	MOVLW	1
	SUBWF	SYSCHARLTCOUNT,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOPEND1
SYSFORLOOP1:
	INCF	SYSTEMPLT,F
;if Asc(Mid (SysInString2, SysTempLT , 1)) <> 32 then
	MOVF	SYSSYSINSTRING2HANDLER,W
	MOVWF	SYSSYSINSTRINGHANDLER
	MOVF	SYSSYSINSTRING2HANDLER_H,W
	MOVWF	SYSSYSINSTRINGHANDLER_H
	MOVF	SYSTEMPLT,W
	MOVWF	SYSCHARSTART
	MOVLW	1
	MOVWF	SYSCHARCOUNT
	CALL	FN_MID
	MOVLW	LOW MID
	MOVWF	SYSSYSINSTRINGAHANDLER
	MOVLW	HIGH MID
	MOVWF	SYSSYSINSTRINGAHANDLER_H
	MOVLW	1
	MOVWF	SYSCHAR
	CALL	FN_ASC
	MOVLW	32
	SUBWF	ASC,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF4
;SysCharLT = SysTempLT
	MOVF	SYSTEMPLT,W
	MOVWF	SYSCHARLT
;goto FoundNonSpaceChar1
	GOTO	FOUNDNONSPACECHAR1
;end if
ENDIF4:
;Next
	MOVF	SYSCHARLTCOUNT,W
	SUBWF	SYSTEMPLT,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP1
SYSFORLOOPEND1:
FOUNDNONSPACECHAR1:
;if SysCharLT <> 0 then
	MOVF	SYSCHARLT,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF6
;Ltrim = Mid (SysInString2, SysCharLT )
	MOVF	SYSSYSINSTRING2HANDLER,W
	MOVWF	SYSSYSINSTRINGHANDLER
	MOVF	SYSSYSINSTRING2HANDLER_H,W
	MOVWF	SYSSYSINSTRINGHANDLER_H
	MOVF	SYSCHARLT,W
	MOVWF	SYSCHARSTART
	MOVLW	255
	MOVWF	SYSCHARCOUNT
	CALL	FN_MID
	MOVLW	LOW LTRIM
MOVWF	FSR1L
	MOVLW	HIGH LTRIM
MOVWF	FSR1H
	MOVLW	LOW MID
MOVWF	FSR0L
	MOVLW	HIGH MID
MOVWF	FSR0H
	CALL	SYSCOPYSTRING
;Exit Function
	RETURN
;end if
ENDIF6:
	RETURN

;********************************************************************************

;SOURCE: STRING.H (393)
FN_MID:
;Empty input?
;If SysInString(0) = 0 Then
	MOVF	SYSSYSINSTRINGHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF12
;Mid(0) = 0
	BANKSEL	SYSMID_0
	CLRF	SYSMID_0
;Exit Function
BANKSEL	STATUS
	RETURN
;End If
ENDIF12:
;Starting position too low?
;If SysCharStart < 1 Then SysCharStart = 1
	MOVLW	1
	SUBWF	SYSCHARSTART,W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF13
	MOVLW	1
	MOVWF	SYSCHARSTART
ENDIF13:
;Starting position too high?
;If SysCharStart > SysInString(0) Then
	MOVF	SYSSYSINSTRINGHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	SYSCHARSTART,W
	SUBWF	INDF0,W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF14
;Mid(0) = 0
	BANKSEL	SYSMID_0
	CLRF	SYSMID_0
;Exit Function
BANKSEL	STATUS
	RETURN
;End If
ENDIF14:
;Input length too high?
;SysCharStart -= 1
	DECF	SYSCHARSTART,F
;SysStringTemp = SysInString(0) - SysCharStart 'Max number of characters
	MOVF	SYSSYSINSTRINGHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	SYSCHARSTART,W
	SUBWF	INDF0,W
	MOVWF	SYSSTRINGTEMP
;If SysCharCount > SysStringTemp Then
	MOVF	SYSCHARCOUNT,W
	SUBWF	SYSSTRINGTEMP,W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF15
;SysCharCount = SysStringTemp
	MOVF	SYSSTRINGTEMP,W
	MOVWF	SYSCHARCOUNT
;End If
ENDIF15:
;Copy characters
;For SysStringTemp = 1 To SysCharCount
	CLRF	SYSSTRINGTEMP
	MOVLW	1
	SUBWF	SYSCHARCOUNT,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOPEND3
SYSFORLOOP3:
	INCF	SYSSTRINGTEMP,F
;Mid(SysStringTemp) = SysInString(SysCharStart + SysStringTemp)
	MOVF	SYSSTRINGTEMP,W
	ADDWF	SYSCHARSTART,W
	MOVWF	SYSTEMP1
	ADDWF	SYSSYSINSTRINGHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSSYSINSTRINGHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SYSARRAYTEMP1
	MOVWF	SYSARRAYTEMP2
	MOVLW	LOW(MID)
	ADDWF	SYSSTRINGTEMP,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	CLRF	SYSTEMP1
	MOVLW	HIGH(MID)
	ADDWFC	SYSTEMP1,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	SYSARRAYTEMP2,W
MOVWF	INDF0
;Next
	MOVF	SYSCHARCOUNT,W
	SUBWF	SYSSTRINGTEMP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP3
SYSFORLOOPEND3:
;Mid(0) = SysCharCount
	MOVF	SYSCHARCOUNT,W
	BANKSEL	SYSMID_0
	MOVWF	SYSMID_0
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: STRING.H (425)
FN_RTRIM:
;Get length of string, return empty string.  If you dont do this you will return an uninitialize value... ooops
;RTrim = ""
	MOVLW	LOW RTRIM
MOVWF	FSR1L
	MOVLW	HIGH RTRIM
MOVWF	FSR1H
	MOVLW	LOW STRINGTABLE36
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE36) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRING
;SysCharRTCount = SysInString3(0)
	MOVF	SYSSYSINSTRING3HANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRING3HANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SYSCHARRTCOUNT
;If SysCharRTCount = 0 Then Exit Function
	MOVF	SYSCHARRTCOUNT,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	RETURN
;find first non white space in the string from the Right
;SysCharRT = 0
	CLRF	SYSCHARRT
;For SysTempRT = SysCharRTCount to 1 step -1
	INCF	SYSCHARRTCOUNT,W
	MOVWF	SYSTEMPRT
	MOVLW	1
	SUBWF	SYSCHARRTCOUNT,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOPEND4
SYSFORLOOP4:
	DECF	SYSTEMPRT,F
;was Asc(Mid (SysInString3, SysTempRT , 1))
;if SysInString3(SysTempRT) <> 32 then
	MOVF	SYSTEMPRT,W
	ADDWF	SYSSYSINSTRING3HANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSSYSINSTRING3HANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVLW	32
	SUBWF	INDF0,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF20
;SysCharRT = SysTempRT
	MOVF	SYSTEMPRT,W
	MOVWF	SYSCHARRT
;goto FoundNonSpaceChar2
	GOTO	FOUNDNONSPACECHAR2
;end if
ENDIF20:
;Next
	MOVF	SYSTEMPRT,W
	SUBLW	1
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP4
SYSFORLOOPEND4:
FOUNDNONSPACECHAR2:
;if SysCharRT <> 0 then
	MOVF	SYSCHARRT,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF22
;Rtrim = Mid (SysInString3, 1, SysCharRT )
	MOVF	SYSSYSINSTRING3HANDLER,W
	MOVWF	SYSSYSINSTRINGHANDLER
	MOVF	SYSSYSINSTRING3HANDLER_H,W
	MOVWF	SYSSYSINSTRINGHANDLER_H
	MOVLW	1
	MOVWF	SYSCHARSTART
	MOVF	SYSCHARRT,W
	MOVWF	SYSCHARCOUNT
	CALL	FN_MID
	MOVLW	LOW RTRIM
MOVWF	FSR1L
	MOVLW	HIGH RTRIM
MOVWF	FSR1H
	MOVLW	LOW MID
MOVWF	FSR0L
	MOVLW	HIGH MID
MOVWF	FSR0H
	CALL	SYSCOPYSTRING
;Exit Function
	RETURN
;end if
ENDIF22:
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (1674)
SYSCOMPEQUALSTRING:
;Dim SysByteTempA As Byte
;Dim SysByteTempX As Byte
;SysByteTempX = 0
	CLRF	SYSBYTETEMPX
;Check length matches
;movf INDF0, W
	MOVF	INDF0, W
;movwf SysByteTempA
	MOVWF	SYSBYTETEMPA
;subwf INDF1, W
	SUBWF	INDF1, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Check if empty
;movf SysByteTempA, F
	MOVF	SYSBYTETEMPA, F
;btfsc STATUS, Z
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
;goto SCEStrTrue
	GOTO	SCESTRTRUE
;Check each char, exit if not equal
SYSSTRINGCOMP:
;Move to next char
;addfsr 0, 1
	ADDFSR	0, 1
;addfsr 1, 1
	ADDFSR	1, 1
;Compare, exit if <>
;movf INDF0, W
	MOVF	INDF0, W
;subwf INDF1, W
	SUBWF	INDF1, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;decfsz SysByteTempA, F
	DECFSZ	SYSBYTETEMPA, F
;goto SysStringComp
	GOTO	SYSSTRINGCOMP
SCESTRTRUE:
;comf SysByteTempX, F
	COMF	SYSBYTETEMPX, F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (1276)
SYSCOPYSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get and copy length
;movf INDF0, W
	MOVF	INDF0, W
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;movwf INDF1
MOVWF	INDF1
;goto SysCopyStringCheck
	GOTO	SYSCOPYSTRINGCHECK
;When appending, add length to counter
SYSCOPYSTRINGPART:
;movf INDF0, W
	MOVF	INDF0, W
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;addwf SysStringLength, F
	ADDWF	SYSSTRINGLENGTH, F
SYSCOPYSTRINGCHECK:
;Exit if length = 0
;movf SysCalcTempA,F
	MOVF	SYSCALCTEMPA,F
;btfsc STATUS,Z
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
;return
	RETURN
SYSSTRINGCOPY:
;Increment pointers
;addfsr 0, 1
	ADDFSR	0, 1
;addfsr 1, 1
	ADDFSR	1, 1
;Copy character
;movf INDF0, W
	MOVF	INDF0, W
;movwf INDF1
MOVWF	INDF1
;decfsz SysCalcTempA, F
	DECFSZ	SYSCALCTEMPA, F
;goto SysStringCopy
	GOTO	SYSSTRINGCOPY
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (1473)
SYSREADSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;call SysStringTables
	CALL	SYSSTRINGTABLES
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;movwf INDF1
MOVWF	INDF1
;goto SysStringReadCheck
	GOTO	SYSSTRINGREADCHECK
SYSREADSTRINGPART:
;Get length
;call SysStringTables
	CALL	SYSSTRINGTABLES
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;addwf SysStringLength,F
	ADDWF	SYSSTRINGLENGTH,F
;Check length
SYSSTRINGREADCHECK:
;If length is 0, exit
;movf SysCalcTempA,F
	MOVF	SYSCALCTEMPA,F
;btfsc STATUS,Z
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
;return
	RETURN
;Copy
SYSSTRINGREAD:
;Get char
;call SysStringTables
	CALL	SYSSTRINGTABLES
;Set char
;addfsr 1,1
	ADDFSR	1,1
;movwf INDF1
MOVWF	INDF1
;decfsz SysCalcTempA, F
	DECFSZ	SYSCALCTEMPA, F
;goto SysStringRead
	GOTO	SYSSTRINGREAD
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
	RETLW	21
	RETLW	32	; 
	RETLW	71	;G
	RETLW	114	;R
	RETLW	101	;E
	RETLW	97	;A
	RETLW	116	;T
	RETLW	32	; 
	RETLW	67	;C
	RETLW	111	;O
	RETLW	119	;W
	RETLW	32	; 
	RETLW	66	;B
	RETLW	65	;A
	RETLW	83	;S
	RETLW	73	;I
	RETLW	67	;C
	RETLW	32	; 
	RETLW	68	;D
	RETLW	101	;E
	RETLW	109	;M
	RETLW	111	;O

	ALIGN	2;X3

STRINGTABLE2:
	RETLW	8
	RETLW	49	;1
	RETLW	54	;6
	RETLW	70	;F
	RETLW	49	;1
	RETLW	56	;8
	RETLW	56	;8
	RETLW	53	;5
	RETLW	53	;5

	ALIGN	2;X3

STRINGTABLE3:
	RETLW	51
	RETLW	87	;W
	RETLW	114	;R
	RETLW	111	;O
	RETLW	110	;N
	RETLW	103	;G
	RETLW	32	; 
	RETLW	77	;M
	RETLW	105	;I
	RETLW	99	;C
	RETLW	114	;R
	RETLW	111	;O
	RETLW	99	;C
	RETLW	111	;O
	RETLW	110	;N
	RETLW	116	;T
	RETLW	114	;R
	RETLW	111	;O
	RETLW	108	;L
	RETLW	108	;L
	RETLW	101	;E
	RETLW	114	;R
	RETLW	32	; 
	RETLW	112	;P
	RETLW	114	;R
	RETLW	111	;O
	RETLW	103	;G
	RETLW	114	;R
	RETLW	97	;A
	RETLW	109	;M
	RETLW	32	; 
	RETLW	105	;I
	RETLW	110	;N
	RETLW	116	;T
	RETLW	101	;E
	RETLW	110	;N
	RETLW	100	;D
	RETLW	101	;E
	RETLW	100	;D
	RETLW	32	; 
	RETLW	102	;F
	RETLW	111	;O
	RETLW	114	;R
	RETLW	32	; 
	RETLW	49	;1
	RETLW	54	;6
	RETLW	70	;F
	RETLW	49	;1
	RETLW	56	;8
	RETLW	56	;8
	RETLW	53	;5
	RETLW	53	;5

	ALIGN	2;X3

STRINGTABLE4:
	RETLW	45
	RETLW	84	;T
	RETLW	104	;H
	RETLW	101	;E
	RETLW	32	; 
	RETLW	77	;M
	RETLW	105	;I
	RETLW	99	;C
	RETLW	114	;R
	RETLW	111	;O
	RETLW	99	;C
	RETLW	111	;O
	RETLW	110	;N
	RETLW	116	;T
	RETLW	114	;R
	RETLW	111	;O
	RETLW	108	;L
	RETLW	108	;L
	RETLW	101	;E
	RETLW	114	;R
	RETLW	32	; 
	RETLW	112	;P
	RETLW	114	;R
	RETLW	111	;O
	RETLW	103	;G
	RETLW	114	;R
	RETLW	97	;A
	RETLW	109	;M
	RETLW	32	; 
	RETLW	105	;I
	RETLW	110	;N
	RETLW	116	;T
	RETLW	101	;E
	RETLW	110	;N
	RETLW	100	;D
	RETLW	101	;E
	RETLW	100	;D
	RETLW	32	; 
	RETLW	102	;F
	RETLW	111	;O
	RETLW	114	;R
	RETLW	32	; 
	RETLW	116	;T
	RETLW	104	;H
	RETLW	101	;E
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE36:
	RETLW	0

	ALIGN	2;X3

STRINGTABLE68:
	RETLW	8
	RETLW	49	;1
	RETLW	54	;6
	RETLW	70	;F
	RETLW	49	;1
	RETLW	56	;8
	RETLW	56	;8
	RETLW	53	;5
	RETLW	53	;5

	ALIGN	2;X3

;********************************************************************************

;SOURCE: STRING.H (452)
FN_TRIM:
;trim = rtrim(ltrim(SysInString))
	MOVF	SYSSYSINSTRINGHANDLER,W
	MOVWF	SYSSYSINSTRING2HANDLER
	MOVF	SYSSYSINSTRINGHANDLER_H,W
	MOVWF	SYSSYSINSTRING2HANDLER_H
	CALL	FN_LTRIM
	MOVLW	LOW LTRIM
	MOVWF	SYSSYSINSTRING3HANDLER
	MOVLW	HIGH LTRIM
	MOVWF	SYSSYSINSTRING3HANDLER_H
	CALL	FN_RTRIM
	MOVLW	LOW TRIM
MOVWF	FSR1L
	MOVLW	HIGH TRIM
MOVWF	FSR1H
	MOVLW	LOW RTRIM
MOVWF	FSR0L
	MOVLW	HIGH RTRIM
MOVWF	FSR0H
	GOTO	SYSCOPYSTRING

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
