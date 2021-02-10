;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\32_show_i2c_devices_to_serial_terminal_using_software_i2c.S"
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
 DEVICEID                         EQU 33                    ; 0X21
 DISPLAYNEWLINE                   EQU 34                    ; 0X22
 HSERPRINTCRLFCOUNT               EQU 35                    ; 0X23
 I2CACK                           EQU 36                    ; 0X24
 I2CACKPOLLSTATE                  EQU 37                    ; 0X25
 I2CBYTE                          EQU 38                    ; 0X26
 I2CMATCH                         EQU 39                    ; 0X27
 I2CSTATE                         EQU 40                    ; 0X28
 PRINTLEN                         EQU 41                    ; 0X29
 SERDATA                          EQU 42                    ; 0X2A
 STRINGPOINTER                    EQU 43                    ; 0X2B
 SYSBITVAR0                       EQU 44                    ; 0X2C
 SYSBYTETEMPA                     EQU 117                    ; 0X75
 SYSBYTETEMPB                     EQU 121                    ; 0X79
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSPRINTDATAHANDLER              EQU 45                    ; 0X2D
 SYSPRINTDATAHANDLER_H            EQU 46                    ; 0X2E
 SYSPRINTTEMP                     EQU 47                    ; 0X2F
 SYSREPEATTEMP1                   EQU 48                    ; 0X30
 SYSREPEATTEMP2                   EQU 49                    ; 0X31
 SYSSTRINGA                       EQU 119                    ; 0X77
 SYSSTRINGA_H                     EQU 120                    ; 0X78
 SYSSTRINGTEMP                    EQU 50                    ; 0X32
 SYSTEMP1                         EQU 51                    ; 0X33
 SYSVALTEMP                       EQU 52                    ; 0X34
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 SYSWAITTEMPS                     EQU 116                    ; 0X74
 SYSWAITTEMPUS                    EQU 117                    ; 0X75
 SYSWAITTEMPUS_H                  EQU 118                    ; 0X76
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
	CALL	INITI2C
;AUTOMATIC PIN DIRECTION SETTING
	BSF	TRISA,5

;START OF THE MAIN PROGRAM
;''
;''******************************************************************
;''
;''  Note: This is software I2C therefore, NO PPS for MSSP/I2C should be used
;''
;''  PIC: 16F18855
;''  Compiler: GCB
;''  IDE: GCB@SYN
;''
;''  Date: 13.3.2016
;''
;----- Configuration
;Chip Settings.
;Generated by PIC PPS Tool for Great Cow Basic
;PPS Tool version: 0.0.5.2
;PinManager data: 09/02/2017
;
;Template comment at the start of the config file
;
;Template comment at the end of the config file
;----- Define Hardware configuration for software I2C
;Define I2C settings - CHANGE PORTS
;#DEFINE I2C_MODE Master
;#DEFINE I2C_DATA PORTC.3
;#DEFINE I2C_CLOCK PORTC.4
;#DEFINE I2C_DISABLE_INTERRUPTS On
;THIS CONFIG OF THE SERIAL PORT WORKS WITH A  MAX232 (or equiv) THEN TO PC
;USART settings - CHANGE PORTS if required
;#DEFINE USART_BAUD_RATE 19200
;Dir PORTc.6 Out
	BCF	TRISC,6
;Dir PORTc.7 In
	BSF	TRISC,7
;#DEFINE USART_TX_BLOCKING
;Wait 500 ms
	MOVLW	244
	MOVWF	SYSWAITTEMPMS
	MOVLW	1
	MOVWF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;----- Variables
;Dim DISPLAYNEWLINE As Byte
;#DEFINE SWITCH_DOWN         0
;#DEFINE SWITCH_UP           1
;#DEFINE SWITCH      PORTA.5
;Dim DeviceID As Byte
;----- Main body of program commences here.
;Now assumes Serial Terminal is operational
;Do Forever
SYSDOLOOP_S1:
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "Software I2C "
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
;HSerPrint "     "
	MOVLW	LOW STRINGTABLE2
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE2) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;For DeviceID = 0 To 15
	MOVLW	255
	MOVWF	DEVICEID
SYSFORLOOP1:
	INCF	DEVICEID,F
;HSerPrint Hex(deviceID)
	MOVF	DEVICEID,W
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
	SUBWF	DEVICEID,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP1
SYSFORLOOPEND1:
;For DeviceID = 0 To 255
	MOVLW	255
	MOVWF	DEVICEID
SYSFORLOOP2:
	INCF	DEVICEID,F
;DisplayNewLine = DeviceID % 16
	MOVF	DEVICEID,W
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
;HSerPrint Hex(DeviceID)
	MOVF	DEVICEID,W
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
;I2CStart
	CALL	I2CSTART
;I2CSend ( deviceID )
	MOVF	DEVICEID,W
	MOVWF	I2CBYTE
	CALL	I2CSEND
;If I2CSendState = TRUE  Then
	INCF	I2CACKPOLLSTATE,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ELSE3_1
;HSerPrint   Hex(deviceID)
	MOVF	DEVICEID,W
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
;HSerPrint "--"
	MOVLW	LOW STRINGTABLE5
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE5) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;End If
ENDIF3:
;I2CSend ( 0 )
	CLRF	I2CBYTE
	CALL	I2CSEND
;I2CStop
	CALL	I2CSTOP
;Next
	MOVLW	255
	SUBWF	DEVICEID,W
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
;HSerPrint   "End of Search"
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
;Wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;Wait While switch = On
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
	GOTO	ENDIF11
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
ENDIF11:
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
	GOTO	ENDIF16
;USART_TX_BLOCKING
;Wait While TXIF = Off
SYSWAITLOOP4:
BANKSEL	PIR3
;B7: ASM Source was:  BTFSS PIR3,TXIF
	BTFSS	PIR3,4
	GOTO	SYSWAITLOOP4
;ensure any previous operation has completed
;Wait until TRMT = 1
SYSWAITLOOP5:
BANKSEL	TX1STA
;B7: ASM Source was:  BTFSS TX1STA,TRMT
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP5
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
ENDIF16:
	RETURN

;********************************************************************************

;SOURCE: I2C.H (317)
I2CSEND:
;I2C_CLOCK_LOW                 'begin with SCL=0
	BCF	TRISC,4
	BCF	LATC,4
;wait I2C_END_DELAY            'let port settle
	MOVLW	2
	MOVWF	DELAYTEMP
DELAYUS6:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS6
	NOP
;repeat 8                      '8 data bits
	MOVLW	8
	MOVWF	SYSREPEATTEMP2
SYSREPEATLOOP2:
;if I2CByte.7 = ON then      'put most significant bit on SDA line
	BTFSS	I2CBYTE,7
	GOTO	ELSE14_1
;I2C_DATA_HIGH
	BSF	TRISC,3
;else
	GOTO	ENDIF14
ELSE14_1:
;I2C_DATA_LOW
	BCF	TRISC,3
	BCF	LATC,3
;end if
ENDIF14:
;rotate I2CByte left         'shift in bit for the next time
	RLF	I2CBYTE,F
;I2C_CLOCK_HIGH              'now clock it in
	BSF	TRISC,4
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SYSWAITLOOP2:
	BTFSS	PORTC,4
	GOTO	SYSWAITLOOP2
;wait I2C_CLOCK_DELAY        'clock pulse width given here
	MOVLW	2
	MOVWF	DELAYTEMP
DELAYUS7:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS7
	NOP
;I2C_CLOCK_LOW               'done clocking that bit
	BCF	TRISC,4
	BCF	LATC,4
;wait I2C_END_DELAY          'time between clock pulses
	MOVLW	2
	MOVWF	DELAYTEMP
DELAYUS8:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS8
	NOP
;end repeat                    'then do next bit
	DECFSZ	SYSREPEATTEMP2,F
	GOTO	SYSREPEATLOOP2
SYSREPEATLOOPEND2:
;wait I2C_BIT_DELAY            'pad timing just a little
	MOVLW	5
	MOVWF	DELAYTEMP
DELAYUS9:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS9
;I2C_DATA_HIGH                 'idle SDA to let Slave respond
	BSF	TRISC,3
;wait I2C_END_DELAY            'let SDA port line settle
	MOVLW	2
	MOVWF	DELAYTEMP
DELAYUS10:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS10
	NOP
;I2C_CLOCK_HIGH                'clock for the ACK/NAK bit
	BSF	TRISC,4
;wait while I2C_CLOCK = OFF    'permit clock stretching here
SYSWAITLOOP3:
	BTFSS	PORTC,4
	GOTO	SYSWAITLOOP3
;restored 'I2CSendState' variable for backwards compatibility
;if I2C_DATA then              'read 9th bit in from Slave
	BTFSS	PORTC,3
	GOTO	ELSE15_1
;I2CAck = FALSE              'return a NAK to the program
	CLRF	I2CACK
;I2CSendState =  FALSE        'state of target device with respect. Retained for backwards compatibility
	CLRF	I2CACKPOLLSTATE
;else
	GOTO	ENDIF15
ELSE15_1:
;I2CAck = TRUE               'else, return an ACK to the program
	MOVLW	255
	MOVWF	I2CACK
;I2CSendState =  TRUE        'state of target device with respect. Retained for backwards compatibility
	MOVLW	255
	MOVWF	I2CACKPOLLSTATE
;end if
ENDIF15:
;I2C_CLOCK_LOW                 'may be more bytes to clock out
	BCF	TRISC,4
	BCF	LATC,4
;wait I2C_END_DELAY            'so keep idling both
	MOVLW	2
	MOVWF	DELAYTEMP
DELAYUS11:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS11
	NOP
;I2C_DATA_LOW                  'SCL and SDA low
	BCF	TRISC,3
	BCF	LATC,3
;wait I2C_BIT_DELAY            'wait the usual bit length
	MOVLW	5
	MOVWF	DELAYTEMP
DELAYUS12:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS12
	RETURN

;********************************************************************************

;SOURCE: I2C.H (182)
I2CSTART:
;I2C_DATA_HIGH                 'SDA and SCL idle high
	BSF	TRISC,3
;I2C_CLOCK_HIGH
	BSF	TRISC,4
;wait I2C_END_DELAY            'let settle a while
	MOVLW	2
	MOVWF	DELAYTEMP
DELAYUS1:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS1
	NOP
;I2C_DATA_LOW                  'then, SDA low while SCL still high
	BCF	TRISC,3
	BCF	LATC,3
;wait I2C_CLOCK_DELAY          'for this amount of time
	MOVLW	2
	MOVWF	DELAYTEMP
DELAYUS2:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS2
	NOP
;I2C_CLOCK_LOW                 'end with SCL low, ready to clock
	BCF	TRISC,4
	BCF	LATC,4
	RETURN

;********************************************************************************

;SOURCE: I2C.H (230)
I2CSTOP:
;I2C_CLOCK_LOW                 'begin with SCL=0 and SDA=0
	BCF	TRISC,4
	BCF	LATC,4
;I2C_DATA_LOW
	BCF	TRISC,3
	BCF	LATC,3
;wait I2C_END_DELAY            'let ports settle
	MOVLW	2
	MOVWF	DELAYTEMP
DELAYUS3:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS3
	NOP
;I2C_CLOCK_HIGH                'make SCL=1 first
	BSF	TRISC,4
;wait I2C_CLOCK_DELAY          'hold for normal clock width time
	MOVLW	2
	MOVWF	DELAYTEMP
DELAYUS4:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS4
	NOP
;I2C_DATA_HIGH                 'then make SDA=1 afterwards
	BSF	TRISC,3
;wait I2C_END_DELAY            'hold for normal between-time
	MOVLW	2
	MOVWF	DELAYTEMP
DELAYUS5:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS5
	NOP
;back idling with SCL=1 and SDA=1 at this point
	RETURN

;********************************************************************************

;SOURCE: I2C.H (167)
INITI2C:
;Moved to prevent variable defintion when not required
;dim I2COldState, I2CState, I2CMatch, I2CTemp as byte
;dim I2CCount alias I2CState
;I2C_DATA_HIGH                   'release SDA (open drain floats high)
	BSF	TRISC,3
;I2C_CLOCK_HIGH                  'release SCL (open drain floats high)
	BSF	TRISC,4
;I2CMatch = FALSE                'address doesn't match (Slave mode)
	CLRF	I2CMATCH
	RETURN

;********************************************************************************

;SOURCE: 32_SHOW_I2C_DEVICES_TO_SERIAL_TERMINAL_USING_SOFTWARE_I2C.GCB (27)
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
;Module: EUSART
;TX > RC0
;RC0PPS = 0x0010
	MOVLW	16
BANKSEL	RC0PPS
MOVWF	RC0PPS
;RC0 > TX (bi-directional)
;TXPPS = 0x0008
	MOVLW	8
BANKSEL	TXPPS
MOVWF	TXPPS
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
	RETLW	13
	RETLW	83	;S
	RETLW	111	;O
	RETLW	102	;F
	RETLW	116	;T
	RETLW	119	;W
	RETLW	97	;A
	RETLW	114	;R
	RETLW	101	;E
	RETLW	32	; 
	RETLW	73	;I
	RETLW	50	;2
	RETLW	67	;C
	RETLW	32	; 

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
	RETLW	13
	RETLW	69	;E
	RETLW	110	;N
	RETLW	100	;D
	RETLW	32	; 
	RETLW	111	;O
	RETLW	102	;F
	RETLW	32	; 
	RETLW	83	;S
	RETLW	101	;E
	RETLW	97	;A
	RETLW	114	;R
	RETLW	99	;C
	RETLW	104	;H

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
