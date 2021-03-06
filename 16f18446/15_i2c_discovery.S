;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18446
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\microchip_low_pin_count_demo_board\pickit2_board\16f18446\15_i2c_discovery.S"
 SUBTITLE    "02-10-2021"

; Reverse lookup file
; C:\Program Files\Microchip\xc8\v2.31\pic\include\proc\pic16f18446.inc

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
 CONFIG WRTSAF = OFF
 CONFIG WRTD = OFF
 CONFIG WRTB = OFF
 CONFIG CP = OFF
;Inferred CONFIG

;********************************************************************************

;Set aside RAM memory locations for variables. All variables are global.
 COMPORT                          EQU 32                    ; 0X20
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 DEVICEID                         EQU 33                    ; 0X21
 DISPLAYNEWLINE                   EQU 34                    ; 0X22
 HI2CACKPOLLSTATE                 EQU 35                    ; 0X23
 HI2CCURRENTMODE                  EQU 36                    ; 0X24
 HI2CWAITMSSPTIMEOUT              EQU 37                    ; 0X25
 HSERPRINTCRLFCOUNT               EQU 38                    ; 0X26
 I2CBYTE                          EQU 39                    ; 0X27
 PRINTLEN                         EQU 40                    ; 0X28
 SERDATA                          EQU 41                    ; 0X29
 STRINGPOINTER                    EQU 42                    ; 0X2A
 SYSBYTETEMPA                     EQU 117                    ; 0X75
 SYSBYTETEMPB                     EQU 121                    ; 0X79
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSPRINTDATAHANDLER              EQU 43                    ; 0X2B
 SYSPRINTDATAHANDLER_H            EQU 44                    ; 0X2C
 SYSPRINTTEMP                     EQU 45                    ; 0X2D
 SYSREPEATTEMP1                   EQU 46                    ; 0X2E
 SYSSTRINGA                       EQU 119                    ; 0X77
 SYSSTRINGA_H                     EQU 120                    ; 0X78
 SYSSTRINGTEMP                    EQU 47                    ; 0X2F
 SYSTEMP1                         EQU 48                    ; 0X30
 SYSVALTEMP                       EQU 49                    ; 0X31
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 SYSWAITTEMPS                     EQU 116                    ; 0X74
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
	CALL	HI2CINIT
;AUTOMATIC PIN DIRECTION SETTING
	BSF	TRISA,3

;START OF THE MAIN PROGRAM
;''A demonstration program for GCGB and GCB.
;''--------------------------------------------------------------------------------------------------------------------------------
;''This program searches for I2C devices and display their adresses to the attached PC terminal.
;''This program uses the hardware implementation of I2C for the Microchip microprocessors.
;''The microprocessor must have a suitable I2C module.
;''The hardware serial connections are shown in the program.
;''
;'' Great Cow BASIC Header block Header block
;''
;''@author  Chris Roper
;''@licence GPL
;''@version 1.00
;''@date    03/05/2018
;''********************************************************************
;----- Configuration
;Config UART
;#DEFINE USART_BLOCKING
;#DEFINE USART_BAUD_RATE 19200
;Wait 500 ms
	MOVLW	244
	MOVWF	SYSWAITTEMPMS
	MOVLW	1
	MOVWF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;Define I2C settings - CHANGE PORTS TO MATCH PPS
;#DEFINE HI2C_BAUD_RATE 400
;#DEFINE HI2C_DATA PORTB.4
;#DEFINE HI2C_CLOCK PORTB.6
;Initialise I2C Slave
;I2C pins need to be input for SSP module
;Dir HI2C_DATA In
	BSF	TRISB,4
;Dir HI2C_CLOCK In
	BSF	TRISB,6
;MASTER
;HI2CMode Master
	MOVLW	12
	MOVWF	HI2CCURRENTMODE
	CALL	HI2CMODE
;#DEFINE SWITCH_DOWN         0
;#DEFINE SWITCH_UP           1
;#DEFINE SWITCH      PORTA.3
;----- Main body of program commences here.
;Now assumes Serial Terminal is operational
;Dim DeviceID As Byte
;Dim DISPLAYNEWLINE As Byte
;Do
SYSDOLOOP_S1:
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "Hardware I2C "
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;HSerPrint ChipNameStr
	MOVLW	LOW STRINGTABLE69
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE69) | 128
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
;Now assumes Serial Terminal is operational
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "   "
	MOVLW	LOW STRINGTABLE2
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE2) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;Create a horizontal row of numbers
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
;Create a vertical column of numbers
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
;If DisplayNewLine > 0 Then
	MOVF	DISPLAYNEWLINE,W
	SUBLW	0
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF5
;HSerPrint " "
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;End If
ENDIF5:
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
;Do an initial Start
;HI2CStart
	CALL	HI2CSTART
;If HI2CWaitMSSPTimeout <> TRUE Then
	INCF	HI2CWAITMSSPTIMEOUT,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ELSE3_1
;Send to address to device
;HI2CSend ( deviceID )
	MOVF	DEVICEID,W
	MOVWF	I2CBYTE
	CALL	HI2CSEND
;Did device fail to respond?
;If HI2CAckpollState = FALSE Then
	MOVF	HI2CACKPOLLSTATE,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ELSE6_1
;HI2CSend ( 0 )
	CLRF	I2CBYTE
	CALL	HI2CSEND
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
	GOTO	ENDIF6
ELSE6_1:
;HSerPrint "--"
	MOVLW	LOW STRINGTABLE4
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE4) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT294
;End If
ENDIF6:
;Do a stop.
;HI2CStop
	CALL	HI2CSTOP
;Else
	GOTO	ENDIF3
ELSE3_1:
;Some thing is not correct.... Clock or Data line disconnect?
;HSerPrint "! "
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
	BTFSC	PORTA,3
	GOTO	SYSWAITLOOP1
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
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

;SOURCE: HWI2C.H (698)
HI2CINIT:
;asm showdebug  This method sets the variable `HI2CCurrentMode`, and, if required calls the method `SI2CInit` to set up new MSSP modules - aka K42s family chips
;HI2CCurrentMode = 0
	CLRF	HI2CCURRENTMODE
;Initialise the I2C module
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (249)
HI2CMODE:
;asm showdebug  This method sets the variable `HI2CCurrentMode`, and, if required, sets the SSPCON1.bits
;#ifdef var(SSPCON1) added to separate from newer i2C module which does not have an SSPCON1
;set SSPSTAT.SMP on
BANKSEL	SSP1STAT
;B7: ASM Source was:  BSF SSP1STAT,SMP
	BSF	SSP1STAT,7
;set SSPCON1.CKP on
;B7: ASM Source was:  BSF SSP1CON1,CKP
	BSF	SSP1CON1,4
;set SSPCON1.WCOL Off
;B7: ASM Source was:  BCF SSP1CON1,WCOL
	BCF	SSP1CON1,7
;Select mode and clock
;If HI2CCurrentMode = Master Then
	MOVLW	12
	BANKSEL	HI2CCURRENTMODE
	SUBWF	HI2CCURRENTMODE,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF13
;set SSPCON1.SSPM3 on
BANKSEL	SSP1CON1
;B7: ASM Source was:  BSF SSP1CON1,SSPM3
	BSF	SSP1CON1,3
;set SSPCON1.SSPM2 off
;B7: ASM Source was:  BCF SSP1CON1,SSPM2
	BCF	SSP1CON1,2
;set SSPCON1.SSPM1 off
;B7: ASM Source was:  BCF SSP1CON1,SSPM1
	BCF	SSP1CON1,1
;set SSPCON1.SSPM0 off
;B7: ASM Source was:  BCF SSP1CON1,SSPM0
	BCF	SSP1CON1,0
;SSPADD = HI2C_BAUD_TEMP and 127
	MOVLW	19
MOVWF	SSP1ADD
;end if
ENDIF13:
;if HI2CCurrentMode = Slave then
	BANKSEL	HI2CCURRENTMODE
	MOVF	HI2CCURRENTMODE,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF14
;set SSPCON1.SSPM3 off
BANKSEL	SSP1CON1
;B7: ASM Source was:  BCF SSP1CON1,SSPM3
	BCF	SSP1CON1,3
;set SSPCON1.SSPM2 on
;B7: ASM Source was:  BSF SSP1CON1,SSPM2
	BSF	SSP1CON1,2
;set SSPCON1.SSPM1 on
;B7: ASM Source was:  BSF SSP1CON1,SSPM1
	BSF	SSP1CON1,1
;set SSPCON1.SSPM0 off
;B7: ASM Source was:  BCF SSP1CON1,SSPM0
	BCF	SSP1CON1,0
;end if
ENDIF14:
;if HI2CCurrentMode = Slave10 then
	MOVLW	3
	BANKSEL	HI2CCURRENTMODE
	SUBWF	HI2CCURRENTMODE,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF15
;set SSPCON1.SSPM3 off
BANKSEL	SSP1CON1
;B7: ASM Source was:  BCF SSP1CON1,SSPM3
	BCF	SSP1CON1,3
;set SSPCON1.SSPM2 on
;B7: ASM Source was:  BSF SSP1CON1,SSPM2
	BSF	SSP1CON1,2
;set SSPCON1.SSPM1 on
;B7: ASM Source was:  BSF SSP1CON1,SSPM1
	BSF	SSP1CON1,1
;set SSPCON1.SSPM0 on
;B7: ASM Source was:  BSF SSP1CON1,SSPM0
	BSF	SSP1CON1,0
;end if
ENDIF15:
;Enable I2C
;set SSPCON1.SSPEN on
BANKSEL	SSP1CON1
;B7: ASM Source was:  BSF SSP1CON1,SSPEN
	BSF	SSP1CON1,5
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (416)
HI2CSEND:
;asm showdebug  This method sets the registers and register bits to send I2C data
RETRYHI2CSEND:
;Clear WCOL
;SET SSPCON1.WCOL OFF
BANKSEL	SSP1CON1
;B7: ASM Source was:  BCF SSP1CON1,WCOL
	BCF	SSP1CON1,7
;Load data to send
;SSPBUF = I2CByte
	BANKSEL	I2CBYTE
	MOVF	I2CBYTE,W
BANKSEL	SSP1BUF
MOVWF	SSP1BUF
;HI2CWaitMSSP
BANKSEL	STATUS
	CALL	HI2CWAITMSSP
;if ACKSTAT =  1 then
BANKSEL	SSP1CON2
;B7: ASM Source was:  BTFSS SSP1CON2,ACKSTAT
	BTFSS	SSP1CON2,6
	GOTO	ELSE18_1
;HI2CAckPollState = true
	MOVLW	255
	BANKSEL	HI2CACKPOLLSTATE
	MOVWF	HI2CACKPOLLSTATE
;else
	GOTO	ENDIF18
ELSE18_1:
;HI2CAckPollState = false
	BANKSEL	HI2CACKPOLLSTATE
	CLRF	HI2CACKPOLLSTATE
;end if
ENDIF18:
;If SSPCON1.WCOL = On Then
BANKSEL	SSP1CON1
;B7: ASM Source was:  BTFSS SSP1CON1,WCOL
	BTFSS	SSP1CON1,7
	GOTO	ENDIF19
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	BANKSEL	HI2CCURRENTMODE
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	RETRYHI2CSEND
;End If
ENDIF19:
;Release clock (only needed by slave)
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	BANKSEL	HI2CCURRENTMODE
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	ENDIF20
BANKSEL	SSP1CON1
;B7: ASM Source was:  BSF SSP1CON1,CKP
	BSF	SSP1CON1,4
ENDIF20:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (304)
HI2CSTART:
;asm showdebug  This method sets the registers and register bits to generate the I2C  START signal
;If HI2CCurrentMode > 10 Then
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ELSE16_1
;Master_mode operational
;Set SEN On
BANKSEL	SSP1CON2
;B7: ASM Source was:  BSF SSP1CON2,SEN
	BSF	SSP1CON2,0
;HI2CWaitMSSP
BANKSEL	STATUS
	CALL	HI2CWAITMSSP
;for device with SEN_SSP1CON2 and therefore devices including the 18FxxK40
;Else
	GOTO	ENDIF16
ELSE16_1:
;Slave mode operational
;Wait Until SSPSTAT.S = On
SYSWAITLOOP2:
BANKSEL	SSP1STAT
;B7: ASM Source was:  BTFSS SSP1STAT,S
	BTFSS	SSP1STAT,3
	GOTO	SYSWAITLOOP2
;End If
ENDIF16:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (351)
HI2CSTOP:
;Master_mode
;If HI2CCurrentMode > 10 Then
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ELSE17_1
;set SSPIE OFF; disable SSP interrupt, tested by Anobium but not implemented.
;wait while R_NOT_W = 1   'wait for completion of activities
SYSWAITLOOP3:
BANKSEL	SSP1STAT
;B7: ASM Source was:  BTFSC SSP1STAT,R_NOT_W
	BTFSC	SSP1STAT,2
	GOTO	SYSWAITLOOP3
;Set SSPCON2.PEN On
;B7: ASM Source was:  BSF SSP1CON2,PEN
	BSF	SSP1CON2,2
;HI2CWaitMSSP
BANKSEL	STATUS
	CALL	HI2CWAITMSSP
;Slave mode
;Else
	GOTO	ENDIF17
ELSE17_1:
;Wait Until SSPSTAT.P = On
SYSWAITLOOP4:
BANKSEL	SSP1STAT
;B7: ASM Source was:  BTFSS SSP1STAT,P
	BTFSS	SSP1STAT,4
	GOTO	SYSWAITLOOP4
;End If
ENDIF17:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (502)
HI2CWAITMSSP:
;HI2CWaitMSSPTimeout = 0
	CLRF	HI2CWAITMSSPTIMEOUT
HI2CWAITMSSPWAIT:
;HI2CWaitMSSPTimeout++
	BANKSEL	HI2CWAITMSSPTIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,F
;if HI2CWaitMSSPTimeout < 255 then
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF22
;'Support for SSP1IF
;if SSP1IF = 0 then goto HI2CWaitMSSPWait
BANKSEL	PIR3
;B7: ASM Source was:  BTFSS PIR3,SSP1IF
	BTFSS	PIR3,0
	GOTO	HI2CWAITMSSPWAIT
;SSP1IF = 0
;B7: ASM Source was:  BCF PIR3,SSP1IF
	BCF	PIR3,0
;exit Sub
BANKSEL	STATUS
	RETURN
;'Support for SSPIF
;if SSPIF = 0 then goto HI2CWaitMSSPWait
BANKSEL	PIR3
;B7: ASM Source was:  BTFSS PIR3,SSP1IF
	BTFSS	PIR3,0
	GOTO	HI2CWAITMSSPWAIT
;SSPIF = 0
;B7: ASM Source was:  BCF PIR3,SSP1IF
	BCF	PIR3,0
;exit Sub
BANKSEL	STATUS
	RETURN
;end if
ENDIF22:
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
	GOTO	ENDIF10
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
ENDIF10:
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
	GOTO	ENDIF25
;USART_BLOCKING and NOT USART_TX_BLOCKING
;Wait While TXIF = Off
SYSWAITLOOP5:
BANKSEL	PIR3
;B7: ASM Source was:  BTFSS PIR3,TX1IF
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
ENDIF25:
	RETURN

;********************************************************************************

;SOURCE: 15_I2C_DISCOVERY.GCB (22)
INITPPS:
;Module: EUSART1
;TX1  > RB7
;RB7PPS     = 0x000F
	MOVLW	15
BANKSEL	RB7PPS
MOVWF	RB7PPS
;RB5  > RX1
;RX1DTPPS   = 0x000D
	MOVLW	13
;B9: ASM Source was:  BANKSEL RX1DTPPS
BANKSEL	RX1PPS
;B9: ASM Source was:  MOVWF RX1DTPPS
MOVWF	RX1PPS
;Module: MSSP1
;SDA1 > RB4
;RB4PPS     = 0x0014
	MOVLW	20
BANKSEL	RB4PPS
MOVWF	RB4PPS
;RB4  > SDA1 (bi-directional)
;SSP1DATPPS = 0x000C
	MOVLW	12
BANKSEL	SSP1DATPPS
MOVWF	SSP1DATPPS
;SCL1 > RB6
;RB6PPS     = 0x0013
	MOVLW	19
BANKSEL	RB6PPS
MOVWF	RB6PPS
;RB6  > SCL1 (bi-directional)
;SSP1CLKPPS = 0x000E
	MOVLW	14
BANKSEL	SSP1CLKPPS
MOVWF	SSP1CLKPPS
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
;B7: ASM Source was:  BCF ADCON0,ADFM0
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
;C2EN = 0
BANKSEL	CM2CON0
;B7: ASM Source was:  BCF CM2CON0,C2EN
	BCF	CM2CON0,7
;C1EN = 0
;B7: ASM Source was:  BCF CM1CON0,C1EN
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
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE2:
	RETLW	3
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
	RETLW	45	;-
	RETLW	45	;-

	ALIGN	2;X3

STRINGTABLE5:
	RETLW	2
	RETLW	33	;!
	RETLW	32	; 

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

STRINGTABLE69:
	RETLW	8
	RETLW	49	;1
	RETLW	54	;6
	RETLW	70	;F
	RETLW	49	;1
	RETLW	56	;8
	RETLW	52	;4
	RETLW	52	;4
	RETLW	54	;6

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
	GOTO	ENDIF7
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F
ENDIF7:
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
	GOTO	ENDIF9
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F
ENDIF9:
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
;START OF PROGRAM MEMORY PAGE 4
	ORG	8192
;START OF PROGRAM MEMORY PAGE 5
	ORG	10240
;START OF PROGRAM MEMORY PAGE 6
	ORG	12288
;START OF PROGRAM MEMORY PAGE 7
	ORG	14336
	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
