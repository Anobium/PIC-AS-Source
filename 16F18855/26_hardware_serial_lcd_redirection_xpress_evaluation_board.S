;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\26_hardware_serial_lcd_redirection_xpress_evaluation_board.S"
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
 ANSIXPOS                         EQU 32                    ; 0X20
 ANSIYPOS                         EQU 33                    ; 0X21
 CHR                              EQU 9159                    ; 0X23C7
 COMPORT                          EQU 34                    ; 0X22
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 LCDCRSR                          EQU 35                    ; 0X23
 OUTVALUETEMP                     EQU 36                    ; 0X24
 PRINTLEN                         EQU 37                    ; 0X25
 SERDATA                          EQU 38                    ; 0X26
 SERPRINTVAL                      EQU 39                    ; 0X27
 STRINGPOINTER                    EQU 40                    ; 0X28
 SYSBITVAR0                       EQU 41                    ; 0X29
 SYSBYTETEMPA                     EQU 117                    ; 0X75
 SYSBYTETEMPB                     EQU 121                    ; 0X79
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSCALCTEMPX                     EQU 112                    ; 0X70
 SYSCHAR                          EQU 42                    ; 0X2A
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSPRINTDATAHANDLER              EQU 43                    ; 0X2B
 SYSPRINTDATAHANDLER_H            EQU 44                    ; 0X2C
 SYSPRINTTEMP                     EQU 45                    ; 0X2D
 SYSSTRINGA                       EQU 119                    ; 0X77
 SYSSTRINGA_H                     EQU 120                    ; 0X78
 SYSTEMP1                         EQU 46                    ; 0X2E
 SYSTEMP2                         EQU 47                    ; 0X2F
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 SYSWAITTEMPS                     EQU 116                    ; 0X74
 XPOS                             EQU 48                    ; 0X30
 YPOS                             EQU 49                    ; 0X31

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 4
 AFSR0_H                          EQU 5
 SYSCHR_0                         EQU 1575
 SYSCHR_1                         EQU 1576

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
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program redirects the normal LCD output to an ANSI serial terminal.
;''On the Microchip MPLab Xpress Evaluation Board
;''It requires the inclusion of the support file "LCD2SerialRedirect.h".
;''
;''@author  TheoL plus works of EvanV and C.A.Roper
;''@licence GPL
;''@version 1.1
;''@date    29.06.2016
;''********************************************************************************
;----- Configuration
;----- Define Hardware settings
;Set the PPS of the RS232 port to USB.
;Set the PPS for this solution.
;#DEFINE USART_BAUD_RATE 19200
;#DEFINE USART_TX_BLOCKING
;Required to LCD to Serial redirection
;#DEFINE LCD_IO 0
;Dim YPOS, XPOS As Byte
;Wait 500 ms
	MOVLW	244
	MOVWF	SYSWAITTEMPMS
	MOVLW	1
	MOVWF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;----- Main body of program commences here.
;Do Forever
SYSDOLOOP_S1:
;Bell Character
;Print CHR(7)
	MOVLW	7
	MOVWF	SYSCHAR
	CALL	FN_CHR
	MOVLW	LOW CHR
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH CHR
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT300
;CLS
	CALL	ANSIERASECREEN
;Print "START TEST"
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT300
;Locate 1,0
	MOVLW	1
	MOVWF	ANSIYPOS
	CLRF	ANSIXPOS
	CALL	ANSI_REV
;Print "DISPLAY ON"
	MOVLW	LOW STRINGTABLE2
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE2) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT300
;Wait 3 s
	MOVLW	3
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;Locate 0,0
	CLRF	ANSIYPOS
	CLRF	ANSIXPOS
	CALL	ANSI_REV
;For ypos = 0 To 1
	MOVLW	255
	MOVWF	YPOS
SYSFORLOOP1:
	INCF	YPOS,F
;For xpos = 0 To 16
	MOVLW	255
	MOVWF	XPOS
SYSFORLOOP2:
	INCF	XPOS,F
;Locate ypos, xpos
	MOVF	YPOS,W
	MOVWF	ANSIYPOS
	MOVF	XPOS,W
	MOVWF	ANSIXPOS
	CALL	ANSI_REV
;Print "*"
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT300
;flush HSerPrint buffer
;Print ""
	MOVLW	LOW STRINGTABLE4
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE4) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT300
;Wait 100 ms
	MOVLW	100
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;Next
	MOVLW	16
	SUBWF	XPOS,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP2
SYSFORLOOPEND2:
;Next
	MOVLW	1
	SUBWF	YPOS,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP1
SYSFORLOOPEND1:
;CLS
	CALL	ANSIERASECREEN
;Locate 0,0
	CLRF	ANSIYPOS
	CLRF	ANSIXPOS
	CALL	ANSI_REV
;LCDCursor LCDON
	MOVLW	12
	MOVWF	LCDCRSR
	CALL	HSERLCDCURSOR
;Print "END TEST"
	MOVLW	LOW STRINGTABLE5
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE5) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT300
;Wait 3 s
	MOVLW	3
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: LCD2SERIALREDIRECT.H (55)
ANSI:
;HSerSend 27
	MOVLW	27
	MOVWF	SERDATA
	CALL	HSERSEND289
;HSerPrint "["
	MOVLW	LOW STRINGTABLE6
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE6) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT300
;HSerPrint ANSIypos
	MOVF	ANSIYPOS,W
	MOVWF	SERPRINTVAL
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT301
;HSerSend 59
	MOVLW	59
	MOVWF	SERDATA
	CALL	HSERSEND289
;HSerPrint ANSIxpos
	MOVF	ANSIXPOS,W
	MOVWF	SERPRINTVAL
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT301
;HSerPrint "H"
	MOVLW	LOW STRINGTABLE7
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE7) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	GOTO	HSERPRINT300

;********************************************************************************

;SOURCE: LCD2SERIALREDIRECT.H (77)
ANSIERASECREEN:
;HSerSend 27
	MOVLW	27
	MOVWF	SERDATA
	CALL	HSERSEND289
;HSerPrint "["
	MOVLW	LOW STRINGTABLE6
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE6) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT300
;HSerPrint "2"
	MOVLW	LOW STRINGTABLE8
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE8) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT300
;HSerPrint "J"
	MOVLW	LOW STRINGTABLE9
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE9) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT300
;Ansi ( 0, 0 )
	CLRF	ANSIXPOS
	CLRF	ANSIYPOS
	CALL	ANSI
;HSerSend 27
	MOVLW	27
	MOVWF	SERDATA
	CALL	HSERSEND289
;HSerPrint "["
	MOVLW	LOW STRINGTABLE6
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE6) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT300
;HSerPrint "?"
	MOVLW	LOW STRINGTABLE10
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE10) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT300
;HSerPrint "25"
	MOVLW	LOW STRINGTABLE11
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE11) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT300
;HSerPrint "l"
	MOVLW	LOW STRINGTABLE12
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE12) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	GOTO	HSERPRINT300

;********************************************************************************

;SOURCE: LCD2SERIALREDIRECT.H (65)
ANSI_REV:
;ANSIypos = ANSIypos + 1
	INCF	ANSIYPOS,F
;HSerSend 27
	MOVLW	27
	MOVWF	SERDATA
	CALL	HSERSEND289
;HSerPrint "["
	MOVLW	LOW STRINGTABLE6
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE6) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT300
;HSerPrint ANSIypos
	MOVF	ANSIYPOS,W
	MOVWF	SERPRINTVAL
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT301
;HSerSend 59
	MOVLW	59
	MOVWF	SERDATA
	CALL	HSERSEND289
;HSerPrint ANSIxpos
	MOVF	ANSIXPOS,W
	MOVWF	SERPRINTVAL
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT301
;HSerPrint "H"
	MOVLW	LOW STRINGTABLE7
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE7) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	GOTO	HSERPRINT300

;********************************************************************************

;SOURCE: STRING.H (536)
FN_CHR:
;Empty input?
;If SysChar < 0 Then
	MOVLW	0
	SUBWF	SYSCHAR,W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF6
;Chr(0) = 0
	BANKSEL	SYSCHR_0
	CLRF	SYSCHR_0
;Exit Function
BANKSEL	STATUS
	RETURN
;End If
ENDIF6:
;Chr(0) = 1
	MOVLW	1
	BANKSEL	SYSCHR_0
	MOVWF	SYSCHR_0
;Copy characters
;Chr(1) = SysChar
	BANKSEL	SYSCHAR
	MOVF	SYSCHAR,W
	BANKSEL	SYSCHR_1
	MOVWF	SYSCHR_1
BANKSEL	STATUS
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

;SOURCE: LCD2SERIALREDIRECT.H (125)
HSERLCDCURSOR:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: STRING:BYTE:, SOURCE: USART.H (1382)
HSERPRINT300:
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
	GOTO	ENDIF7
;Write Data
;for SysPrintTemp = 1 to PrintLen
	CLRF	SYSPRINTTEMP
	MOVLW	1
	SUBWF	PRINTLEN,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOPEND3
SYSFORLOOP3:
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
	CALL	HSERSEND290
;next
	MOVF	PRINTLEN,W
	SUBWF	SYSPRINTTEMP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP3
SYSFORLOOPEND3:
;End If
ENDIF7:
;CR
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (1405)
HSERPRINT301:
;OutValueTemp = 0
	CLRF	OUTVALUETEMP
;IF SerPrintVal >= 100 Then
	MOVLW	100
	SUBWF	SERPRINTVAL,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	ENDIF10
;OutValueTemp = SerPrintVal / 100
	MOVF	SERPRINTVAL,W
	MOVWF	SYSBYTETEMPA
	MOVLW	100
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPA,W
	MOVWF	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	MOVLW	48
	ADDWF	OUTVALUETEMP,W
	MOVWF	SERDATA
	CALL	HSERSEND290
;End If
ENDIF10:
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	MOVF	OUTVALUETEMP,W
	MOVWF	SYSBYTETEMPB
	CLRF	SYSBYTETEMPA
	CALL	SYSCOMPLESSTHAN
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP1
	MOVF	SERPRINTVAL,W
	MOVWF	SYSBYTETEMPA
	MOVLW	10
	MOVWF	SYSBYTETEMPB
	CALL	SYSCOMPLESSTHAN
	COMF	SYSBYTETEMPX,F
	MOVF	SYSTEMP1,W
	IORWF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP2
	BTFSS	SYSTEMP2,0
	GOTO	ENDIF11
;OutValueTemp = SerPrintVal / 10
	MOVF	SERPRINTVAL,W
	MOVWF	SYSBYTETEMPA
	MOVLW	10
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPA,W
	MOVWF	OUTVALUETEMP
;SerPrintVal = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SERPRINTVAL
;HSerSend(OutValueTemp + 48 ,comport )
	MOVLW	48
	ADDWF	OUTVALUETEMP,W
	MOVWF	SERDATA
	CALL	HSERSEND290
;End If
ENDIF11:
;HSerSend(SerPrintVal + 48 ,comport)
	MOVLW	48
	ADDWF	SERPRINTVAL,W
	MOVWF	SERDATA
	CALL	HSERSEND290
;CR
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:, SOURCE: USART.H (759)
HSERSEND289:
;Registers/Bits determined by #samevar at top of library
;USART_TX_BLOCKING
;Wait While TXIF = Off
SYSWAITLOOP1:
BANKSEL	PIR3
;B7: ASM Source was:  BTFSS PIR3,TXIF
	BTFSS	PIR3,4
	GOTO	SYSWAITLOOP1
;ensure any previous operation has completed
;Wait until TRMT = 1
SYSWAITLOOP2:
BANKSEL	TX1STA
;B7: ASM Source was:  BTFSS TX1STA,TRMT
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP2
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
	GOTO	DELAY_MS

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (848)
HSERSEND290:
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	DECF	COMPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF12
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
ENDIF12:
	RETURN

;********************************************************************************

;SOURCE: 26_HARDWARE_SERIAL_LCD_REDIRECTION_XPRESS_EVALUATION_BOARD.GCB (24)
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
;RC0 <- EUSART:TX;
;RC0PPS = 0x0010
	MOVLW	16
BANKSEL	RC0PPS
MOVWF	RC0PPS
;RC1 -> EUSART:RX;
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

;SOURCE: SYSTEM.H (3035)
SYSCOMPLESSTHAN:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;bsf STATUS, C
;B7: ASM Source was:  BSF STATUS, C
	BSF	STATUS,0
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W
;subwf SysByteTempA, W
	SUBWF	SYSBYTETEMPA, W
;btfss STATUS, C
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
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
	RETLW	10
	RETLW	83	;S
	RETLW	84	;T
	RETLW	65	;A
	RETLW	82	;R
	RETLW	84	;T
	RETLW	32	; 
	RETLW	84	;T
	RETLW	69	;E
	RETLW	83	;S
	RETLW	84	;T

	ALIGN	2;X3

STRINGTABLE2:
	RETLW	10
	RETLW	68	;D
	RETLW	73	;I
	RETLW	83	;S
	RETLW	80	;P
	RETLW	76	;L
	RETLW	65	;A
	RETLW	89	;Y
	RETLW	32	; 
	RETLW	79	;O
	RETLW	78	;N

	ALIGN	2;X3

STRINGTABLE3:
	RETLW	1
	RETLW	42	;*

	ALIGN	2;X3

STRINGTABLE4:
	RETLW	0

	ALIGN	2;X3

STRINGTABLE5:
	RETLW	8
	RETLW	69	;E
	RETLW	78	;N
	RETLW	68	;D
	RETLW	32	; 
	RETLW	84	;T
	RETLW	69	;E
	RETLW	83	;S
	RETLW	84	;T

	ALIGN	2;X3

STRINGTABLE6:
	RETLW	1
	RETLW	91	;[

	ALIGN	2;X3

STRINGTABLE7:
	RETLW	1
	RETLW	72	;H

	ALIGN	2;X3

STRINGTABLE8:
	RETLW	1
	RETLW	50	;2

	ALIGN	2;X3

STRINGTABLE9:
	RETLW	1
	RETLW	74	;J

	ALIGN	2;X3

STRINGTABLE10:
	RETLW	1
	RETLW	63	;?

	ALIGN	2;X3

STRINGTABLE11:
	RETLW	2
	RETLW	50	;2
	RETLW	53	;5

	ALIGN	2;X3

STRINGTABLE12:
	RETLW	1
	RETLW	108	;L

	ALIGN	2;X3

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
