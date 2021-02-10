;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\17_show_i2c2_devices_to_serial_terminal.S"
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
 HI2C2ACKPOLLSTATE                EQU 35                    ; 0X23
 HI2C2CURRENTMODE                 EQU 36                    ; 0X24
 HI2C2WAITMSSPTIMEOUT             EQU 37                    ; 0X25
 HI2CCURRENTMODE                  EQU 38                    ; 0X26
 HSERPRINTCRLFCOUNT               EQU 39                    ; 0X27
 I2C2BYTE                         EQU 40                    ; 0X28
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
 SYSSTRINGA                       EQU 119                    ; 0X77
 SYSSTRINGA_H                     EQU 120                    ; 0X78
 SYSSTRINGTEMP                    EQU 49                    ; 0X31
 SYSTEMP1                         EQU 50                    ; 0X32
 SYSVALTEMP                       EQU 51                    ; 0X33
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
	CALL	HI2C2INIT
	CALL	INITUSART
	CALL	HI2CINIT
;AUTOMATIC PIN DIRECTION SETTING
	BSF	TRISA,5

;START OF THE MAIN PROGRAM
;''
;''******************************************************************
;''
;''
;''
;''  PIC: 16F18855
;''  Compiler: GCB
;''  IDE: GCB@SYN
;''
;''  Board: Xpress Evaluation Board
;''  Date: 13.3.2016
;''
;----- Configuration
;Chip Settings.
;Set the PPS of the PWM and the RS232 ports.
;Set the PPS for this solution.
;#DEFINE SWITCH_DOWN         0
;#DEFINE SWITCH_UP           1
;#DEFINE SWITCH      PORTA.5
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
;#DEFINE ALARM1  PORTA.7
;#DEFINE ALARM2  PORTA.6
;Dir     ALARM1  In
	BSF	TRISA,7
;Dir     ALARM2  In
	BSF	TRISA,6
;#DEFINE USART_BAUD_RATE 19200
;#DEFINE USART_TX_BLOCKING
;#DEFINE sync SYNC_TX1STA
;----- Define Hardware settings for HWI2C2
;Define I2C settings - CHANGE PORTS if required for your specific device.
;#DEFINE HI2C2_BAUD_RATE 400
;#DEFINE HI2C2_DATA PORTC.3
;#DEFINE HI2C2_CLOCK PORTC.4
;Initialise I2C Master
;I2C pins need to be input for SSP2 module
;Dir HI2C2_DATA In
	BSF	TRISC,3
;Dir HI2C2_CLOCK In
	BSF	TRISC,4
;MASTER Second Port
;HI2C2Mode Master
	MOVLW	12
	MOVWF	HI2C2CURRENTMODE
	CALL	HI2C2MODE
;Dim DISPLAYNEWLINE As Byte
;----- Main body of program commences here.
;Now assumes Serial Terminal is operational
;Dim DeviceID As Byte
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "Hardware I2C2 "
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT315
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
	CALL	HSERPRINT315
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
	CALL	HSERPRINT315
;HSerPrint " "
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT315
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
	CALL	HSERPRINT315
;HSerPrint ": "
	MOVLW	LOW STRINGTABLE4
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE4) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT315
;End If
ENDIF2:
;HSerPrint " "
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT315
;HI2C2Start
	CALL	HI2C2START
;If HI2C2WaitMSSPTimeout <> TRUE Then
	INCF	HI2C2WAITMSSPTIMEOUT,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF3
;HI2C2Send ( deviceID )
	MOVF	DEVICEID,W
	MOVWF	I2C2BYTE
	CALL	HI2C2SEND
;If HI2C2AckpollState = FALSE Then
	MOVF	HI2C2ACKPOLLSTATE,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ELSE5_1
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
	CALL	HSERPRINT315
;Else
	GOTO	ENDIF5
ELSE5_1:
;HSerPrint "--"
	MOVLW	LOW STRINGTABLE5
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE5) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT315
;End If
ENDIF5:
;HI2C2Send ( 0)
	CLRF	I2C2BYTE
	CALL	HI2C2SEND
;End If
ENDIF3:
;HI2C2Stop
	CALL	HI2C2STOP
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
	CALL	HSERPRINT315
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
;Wait While switch = On
SYSWAITLOOP1:
	BTFSC	PORTA,5
	GOTO	SYSWAITLOOP1
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
;End
	GOTO	BASPROGRAMEND
;----- Support methods.  Subroutines and Functions
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

;SOURCE: HWI2C2.H (379)
HI2C2INIT:
;HI2C2CurrentMode = 0
	CLRF	HI2C2CURRENTMODE
;Initialise the I2C module
	RETURN

;********************************************************************************

;SOURCE: HWI2C2.H (115)
HI2C2MODE:
;set SSP2STAT_SMP on
BANKSEL	SSP2STAT
;B7: ASM Source was:  BSF SSP2STAT,SSP2STAT_SMP
	BSF	SSP2STAT,7
;set SSP2CON1_CKP on
;B7: ASM Source was:  BSF SSP2CON1,SSP2CON1_CKP
	BSF	SSP2CON1,4
;set SSP2CON1_WCOL Off
;B7: ASM Source was:  BCF SSP2CON1,SSP2CON1_WCOL
	BCF	SSP2CON1,7
;Select mode and clock
;If HI2C2CurrentMode = Master Then
	MOVLW	12
	BANKSEL	HI2C2CURRENTMODE
	SUBWF	HI2C2CURRENTMODE,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF9
;set SSP2CON1_SSPM3 on
BANKSEL	SSP2CON1
;B7: ASM Source was:  BSF SSP2CON1,SSP2CON1_SSPM3
	BSF	SSP2CON1,3
;set SSP2CON1_SSPM2 off
;B7: ASM Source was:  BCF SSP2CON1,SSP2CON1_SSPM2
	BCF	SSP2CON1,2
;set SSP2CON1_SSPM1 off
;B7: ASM Source was:  BCF SSP2CON1,SSP2CON1_SSPM1
	BCF	SSP2CON1,1
;set SSP2CON1_SSPM0 off
;B7: ASM Source was:  BCF SSP2CON1,SSP2CON1_SSPM0
	BCF	SSP2CON1,0
;SSP2ADD = HI2C2_BAUD_TEMP and 127
	MOVLW	19
MOVWF	SSP2ADD
;end if
ENDIF9:
;if HI2C2CurrentMode = Slave then
	BANKSEL	HI2C2CURRENTMODE
	MOVF	HI2C2CURRENTMODE,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF10
;set SSP2CON1_SSPM3 off
BANKSEL	SSP2CON1
;B7: ASM Source was:  BCF SSP2CON1,SSP2CON1_SSPM3
	BCF	SSP2CON1,3
;set SSP2CON1_SSPM2 on
;B7: ASM Source was:  BSF SSP2CON1,SSP2CON1_SSPM2
	BSF	SSP2CON1,2
;set SSP2CON1_SSPM1 on
;B7: ASM Source was:  BSF SSP2CON1,SSP2CON1_SSPM1
	BSF	SSP2CON1,1
;set SSP2CON1_SSPM0 off
;B7: ASM Source was:  BCF SSP2CON1,SSP2CON1_SSPM0
	BCF	SSP2CON1,0
;end if
ENDIF10:
;if HI2C2CurrentMode = Slave10 then
	MOVLW	3
	BANKSEL	HI2C2CURRENTMODE
	SUBWF	HI2C2CURRENTMODE,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF11
;set SSP2CON1_SSPM3 off
BANKSEL	SSP2CON1
;B7: ASM Source was:  BCF SSP2CON1,SSP2CON1_SSPM3
	BCF	SSP2CON1,3
;set SSP2CON1_SSPM2 on
;B7: ASM Source was:  BSF SSP2CON1,SSP2CON1_SSPM2
	BSF	SSP2CON1,2
;set SSP2CON1_SSPM1 on
;B7: ASM Source was:  BSF SSP2CON1,SSP2CON1_SSPM1
	BSF	SSP2CON1,1
;set SSP2CON1_SSPM0 on
;B7: ASM Source was:  BSF SSP2CON1,SSP2CON1_SSPM0
	BSF	SSP2CON1,0
;end if
ENDIF11:
;Enable I2C
;set SSP2CON1_SSPEN on
BANKSEL	SSP2CON1
;B7: ASM Source was:  BSF SSP2CON1,SSP2CON1_SSPEN
	BSF	SSP2CON1,5
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C2.H (275)
HI2C2SEND:
RETRYHI2C2SEND:
;Clear WCOL
;SET SSP2CON1_WCOL OFF
BANKSEL	SSP2CON1
;B7: ASM Source was:  BCF SSP2CON1,SSP2CON1_WCOL
	BCF	SSP2CON1,7
;Load data to send
;SSP2BUF = I2C2Byte
	BANKSEL	I2C2BYTE
	MOVF	I2C2BYTE,W
BANKSEL	SSP2BUF
MOVWF	SSP2BUF
;HI2C2WaitMSSP
BANKSEL	STATUS
	CALL	HI2C2WAITMSSP
;if SSP2CON2_ACKSTAT =  1 then
BANKSEL	SSP2CON2
;B7: ASM Source was:  BTFSS SSP2CON2,SSP2CON2_ACKSTAT
	BTFSS	SSP2CON2,6
	GOTO	ELSE14_1
;HI2C2AckPollState = true
	MOVLW	255
	BANKSEL	HI2C2ACKPOLLSTATE
	MOVWF	HI2C2ACKPOLLSTATE
;else
	GOTO	ENDIF14
ELSE14_1:
;HI2C2AckPollState = false
	BANKSEL	HI2C2ACKPOLLSTATE
	CLRF	HI2C2ACKPOLLSTATE
;end if
ENDIF14:
;If SSP2CON1_WCOL  = On Then
BANKSEL	SSP2CON1
;B7: ASM Source was:  BTFSS SSP2CON1,SSP2CON1_WCOL
	BTFSS	SSP2CON1,7
	GOTO	ENDIF15
;If HI2C2CurrentMode <= 10 Then Goto RetryHI2C2Send
	BANKSEL	HI2C2CURRENTMODE
	MOVF	HI2C2CURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	RETRYHI2C2SEND
;End If
ENDIF15:
;Release clock (only needed by slave)
;If HI2C2CurrentMode <= 10 Then Set SSP2CON1_CKP On
	BANKSEL	HI2C2CURRENTMODE
	MOVF	HI2C2CURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	ENDIF16
BANKSEL	SSP2CON1
;B7: ASM Source was:  BSF SSP2CON1,SSP2CON1_CKP
	BSF	SSP2CON1,4
ENDIF16:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C2.H (170)
HI2C2START:
;Master mode
;If HI2C2CurrentMode > 10 Then
	MOVF	HI2C2CURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ELSE12_1
;Set SSP2CON2_SEN On
BANKSEL	SSP2CON2
;B7: ASM Source was:  BSF SSP2CON2,SSP2CON2_SEN
	BSF	SSP2CON2,0
;HI2C2WaitMSSP
BANKSEL	STATUS
	CALL	HI2C2WAITMSSP
;Slave mode
;Else
	GOTO	ENDIF12
ELSE12_1:
;Wait Until SSP2STAT_S = On
SYSWAITLOOP2:
BANKSEL	SSP2STAT
;B7: ASM Source was:  BTFSS SSP2STAT,SSP2STAT_S
	BTFSS	SSP2STAT,3
	GOTO	SYSWAITLOOP2
;End If
ENDIF12:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C2.H (212)
HI2C2STOP:
;Master mode
;If HI2C2CurrentMode > 10 Then
	MOVF	HI2C2CURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ELSE13_1
;wait while SSP2STAT_R_NOT_W = 1   'wait for completion of activities
SYSWAITLOOP3:
BANKSEL	SSP2STAT
;B7: ASM Source was:  BTFSC SSP2STAT,SSP2STAT_R_NOT_W
	BTFSC	SSP2STAT,2
	GOTO	SYSWAITLOOP3
;Set SSP2CON2_PEN On
;B7: ASM Source was:  BSF SSP2CON2,SSP2CON2_PEN
	BSF	SSP2CON2,2
;HI2C2WaitMSSP
BANKSEL	STATUS
	CALL	HI2C2WAITMSSP
;Slave mode
;Else
	GOTO	ENDIF13
ELSE13_1:
;Wait Until SSP2STAT_P = On
SYSWAITLOOP4:
BANKSEL	SSP2STAT
;B7: ASM Source was:  BTFSS SSP2STAT,SSP2STAT_P
	BTFSS	SSP2STAT,4
	GOTO	SYSWAITLOOP4
;End If
ENDIF13:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C2.H (357)
HI2C2WAITMSSP:
;adapted for 18f - v0.94
;HI2C2WaitMSSPTimeout = 0
	CLRF	HI2C2WAITMSSPTIMEOUT
HI2C2WAITMSSPWAIT:
;HI2C2WaitMSSPTimeout++
	BANKSEL	HI2C2WAITMSSPTIMEOUT
	INCF	HI2C2WAITMSSPTIMEOUT,F
;if HI2C2WaitMSSPTimeout < 255 then
	MOVLW	255
	SUBWF	HI2C2WAITMSSPTIMEOUT,W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF18
;'Support for SSP2IF
;if SSP2IF = 0 then goto HI2C2WaitMSSPWait
BANKSEL	PIR3
;B7: ASM Source was:  BTFSS PIR3,SSP2IF
	BTFSS	PIR3,2
	GOTO	HI2C2WAITMSSPWAIT
;SSP2IF = 0
;B7: ASM Source was:  BCF PIR3,SSP2IF
	BCF	PIR3,2
;end if
ENDIF18:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (698)
HI2CINIT:
;asm showdebug  This method sets the variable `HI2CCurrentMode`, and, if required calls the method `SI2CInit` to set up new MSSP modules - aka K42s family chips
;HI2CCurrentMode = 0
	CLRF	HI2CCURRENTMODE
;Initialise the I2C module
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: STRING:BYTE:, SOURCE: USART.H (1382)
HSERPRINT315:
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
	GOTO	ENDIF23
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
	CALL	HSERSEND305
;next
	MOVF	PRINTLEN,W
	SUBWF	SYSPRINTTEMP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP4
SYSFORLOOPEND4:
;End If
ENDIF23:
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
	CALL	HSERSEND305
;HSerSend(10,comport)
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND305
;end Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (848)
HSERSEND305:
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	DECF	COMPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF26
;USART_TX_BLOCKING
;Wait While TXIF = Off
SYSWAITLOOP5:
BANKSEL	PIR3
;B7: ASM Source was:  BTFSS PIR3,TXIF
	BTFSS	PIR3,4
	GOTO	SYSWAITLOOP5
;ensure any previous operation has completed
;Wait until TRMT = 1
SYSWAITLOOP6:
BANKSEL	TX1STA
;B7: ASM Source was:  BTFSS TX1STA,TRMT
	BTFSS	TX1STA,1
	GOTO	SYSWAITLOOP6
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
ENDIF26:
	RETURN

;********************************************************************************

;SOURCE: 17_SHOW_I2C2_DEVICES_TO_SERIAL_TERMINAL.GCB (28)
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
;RC0->EUSART:TX;
;RC0PPS = 0x0010
	MOVLW	16
BANKSEL	RC0PPS
MOVWF	RC0PPS
;RC3->MSSP2:SDA2;
;RC3PPS = 0x0017
	MOVLW	23
MOVWF	RC3PPS
;RC3->MSSP2:SDA2;
;SSP2DATPPS = 0x0013
	MOVLW	19
BANKSEL	SSP2DATPPS
MOVWF	SSP2DATPPS
;RC4->MSSP2:SCL2;
;SSP2CLKPPS = 0x0014
	MOVLW	20
MOVWF	SSP2CLKPPS
;RC4->MSSP2:SCL2;
;RC4PPS = 0x0016
	MOVLW	22
BANKSEL	RC4PPS
MOVWF	RC4PPS
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
	RETLW	14
	RETLW	72	;H
	RETLW	97	;A
	RETLW	114	;R
	RETLW	100	;D
	RETLW	119	;W
	RETLW	97	;A
	RETLW	114	;R
	RETLW	101	;E
	RETLW	32	; 
	RETLW	73	;I
	RETLW	50	;2
	RETLW	67	;C
	RETLW	50	;2
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
	GOTO	ENDIF20
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F
ENDIF20:
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
	GOTO	ENDIF22
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F
ENDIF22:
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
