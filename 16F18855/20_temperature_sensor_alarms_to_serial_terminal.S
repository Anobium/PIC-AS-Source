;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\20_temperature_sensor_alarms_to_serial_terminal.S"
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
 BITIN                            EQU 32                    ; 0X20
 BYTENUM                          EQU 33                    ; 0X21
 BYTETOBIN                        EQU 9150                    ; 0X23BE
 CHECK_SWITCH                     EQU 34                    ; 0X22
 CHR                              EQU 9159                    ; 0X23C7
 COMPORT                          EQU 35                    ; 0X23
 DATA                             EQU 36                    ; 0X24
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 DIG                              EQU 37                    ; 0X25
 DSDATA                           EQU 38                    ; 0X26
 DSDATA_H                         EQU 39                    ; 0X27
 EMC_TEMP                         EQU 40                    ; 0X28
 EMC_TEMP_H                       EQU 41                    ; 0X29
 FNLSR                            EQU 42                    ; 0X2A
 FNLSR_E                          EQU 45                    ; 0X2D
 FNLSR_H                          EQU 43                    ; 0X2B
 FNLSR_U                          EQU 44                    ; 0X2C
 FRACT                            EQU 46                    ; 0X2E
 HI                               EQU 47                    ; 0X2F
 HI2C2ACKPOLLSTATE                EQU 48                    ; 0X30
 HI2C2BYTE                        EQU 49                    ; 0X31
 HI2C2CURRENTMODE                 EQU 50                    ; 0X32
 HI2C2WAITMSSPTIMEOUT             EQU 51                    ; 0X33
 HI2CCURRENTMODE                  EQU 52                    ; 0X34
 HI2CGETACK                       EQU 53                    ; 0X35
 HSERPRINTCRLFCOUNT               EQU 54                    ; 0X36
 I2C2BYTE                         EQU 55                    ; 0X37
 LO                               EQU 56                    ; 0X38
 NUMBITS                          EQU 57                    ; 0X39
 OLDSTATUS                        EQU 58                    ; 0X3A
 OUTVALUETEMP                     EQU 59                    ; 0X3B
 PRINTLEN                         EQU 60                    ; 0X3C
 PRINTVALUE                       EQU 61                    ; 0X3D
 SERDATA                          EQU 62                    ; 0X3E
 SERPRINTVAL                      EQU 63                    ; 0X3F
 SHOWDEGREECHAR                   EQU 64                    ; 0X40
 SIGNBIT                          EQU 65                    ; 0X41
 STR                              EQU 9144                    ; 0X23B8
 STRINGPOINTER                    EQU 66                    ; 0X42
 SYSBITVAR0                       EQU 67                    ; 0X43
 SYSBITVAR1                       EQU 68                    ; 0X44
 SYSBITVAR2                       EQU 69                    ; 0X45
 SYSBYTETEMPA                     EQU 117                    ; 0X75
 SYSBYTETEMPB                     EQU 121                    ; 0X79
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSCALCTEMPA                     EQU 117                    ; 0X75
 SYSCALCTEMPX                     EQU 112                    ; 0X70
 SYSCALCTEMPX_H                   EQU 113                    ; 0X71
 SYSCHAR                          EQU 70                    ; 0X46
 SYSCHARCOUNT                     EQU 71                    ; 0X47
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSDIVMULTA                      EQU 119                    ; 0X77
 SYSDIVMULTA_H                    EQU 120                    ; 0X78
 SYSDIVMULTB                      EQU 123                    ; 0X7B
 SYSDIVMULTB_H                    EQU 124                    ; 0X7C
 SYSDIVMULTX                      EQU 114                    ; 0X72
 SYSDIVMULTX_H                    EQU 115                    ; 0X73
 SYSFNBYTE1                       EQU 72                    ; 0X48
 SYSPRINTDATAHANDLER              EQU 73                    ; 0X49
 SYSPRINTDATAHANDLER_H            EQU 74                    ; 0X4A
 SYSPRINTTEMP                     EQU 75                    ; 0X4B
 SYSREPEATTEMP1                   EQU 76                    ; 0X4C
 SYSREPEATTEMP2                   EQU 77                    ; 0X4D
 SYSREPEATTEMP3                   EQU 78                    ; 0X4E
 SYSSTRDATA                       EQU 79                    ; 0X4F
 SYSSTRINGA                       EQU 119                    ; 0X77
 SYSSTRINGA_H                     EQU 120                    ; 0X78
 SYSSTRINGLENGTH                  EQU 118                    ; 0X76
 SYSSTRINGTEMP                    EQU 80                    ; 0X50
 SYSTEMP1                         EQU 81                    ; 0X51
 SYSTEMP1_H                       EQU 82                    ; 0X52
 SYSTEMP2                         EQU 83                    ; 0X53
 SYSTEMP3                         EQU 84                    ; 0X54
 SYSVALTEMP                       EQU 85                    ; 0X55
 SYSVALTEMP_H                     EQU 86                    ; 0X56
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 SYSWAITTEMPS                     EQU 116                    ; 0X74
 SYSWORDTEMPA                     EQU 117                    ; 0X75
 SYSWORDTEMPA_H                   EQU 118                    ; 0X76
 SYSWORDTEMPB                     EQU 121                    ; 0X79
 SYSWORDTEMPB_H                   EQU 122                    ; 0X7A
 SYSWORDTEMPX                     EQU 112                    ; 0X70
 SYSWORDTEMPX_H                   EQU 113                    ; 0X71
 TEMPC_100                        EQU 87                    ; 0X57
 TEMPC_100_H                      EQU 88                    ; 0X58
 WHOLE                            EQU 89                    ; 0X59
 _EMC_DATA                        EQU 90                    ; 0X5A
 _EMC_REG                         EQU 91                    ; 0X5B
 _HEXPICAS                        EQU 9140                    ; 0X23B4

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 4
 AFSR0_H                          EQU 5
 SYSCHR_0                         EQU 1575
 SYSCHR_1                         EQU 1576
 SYSFNLSRWORD                     EQU 42
 SYSFNLSRWORD_H                   EQU 43
 SYSSTR_0                         EQU 1512
 SYS_HEXPICAS_0                   EQU 1508
 SYS_HEXPICAS_1                   EQU 1509
 SYS_HEXPICAS_2                   EQU 1510

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
;'' This demonstration will show the tempature sensor on the serial terminal.  The sensor used I2C.
;''
;'' It also shows many parameter from the sensor.
;''
;'' The EMC1001 controls the two output pins (marked on the Xpress board as ALARM1 and ALARM2)
;'' according to two different sets of rules.
;'' While both pins are open drain, the Xpress evaluation board comes with a pull up resistor only
;'' for the ALARM1 output. If you intend to use the second output you will have to mount a second
;'' pull up resistor yourself (a ~10K ohm resistor will do).
;''
;'' The ALARM1 output is activated (pulled low) only when Ttherm is passed (>85°C by default).
;'' You can change this value by writing to the Therm Limit register (0x20).
;'' Note: This is an 8-bit (integer) value.
;''
;'' The ALARM2 output is activated (pulled low) when the temperature is above Th or below Tl. After appropriate configuration.
;'' By default this output is not enabled.
;'' Write to the Configuration register (0x03) the appropirate value (0x05 for example) to activate.
;''
;'' You can also verify the device has detected the temperature conditions by reading the STATUS register (0x01).
;'' Bit 6 and bit 5 are set when Thigh and Tlow respectively are violated (equiv ALARM2), while bit 0 is set when the THERM limit is exceeded (equiv. ALARM1)
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
;Set the PPS of the PWM and the RS232 ports.
;Set the PPS for this solution.
;#DEFINE USART_BAUD_RATE 19200
;#DEFINE USART_TX_BLOCKING
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
;Dim HI, LO, EMC_TEMP_H, SIGNBIT, WHOLE, FRACT, DIG, SHOWDEGREECHAR, DATA, OLDSTATUS As Byte
;showDegreeChar = FALSE
	CLRF	SHOWDEGREECHAR
;----- Main body of program commences here.
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "Great Cow Basic @2016": HSerPrintCRLF
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "Xpress Demo Board": HSerPrintCRLF
	MOVLW	LOW STRINGTABLE2
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE2) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;HSerPrint "09 Temperature": HSerPrintCRLF 3
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
	MOVLW	3
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;Wait 1 s
	MOVLW	1
	MOVWF	SYSWAITTEMPS
	CALL	DELAY_S
;slave device address
;#DEFINE EMC1001_ADDRESS     0x70
;Dim emc_temp As Word
;EMC1001_Write ( EMC1001_TEMP_LIMIT_HI_H , 30)
	MOVLW	5
	MOVWF	_EMC_REG
	MOVLW	30
	MOVWF	_EMC_DATA
	CALL	EMC1001_WRITE
;EMC1001_Write ( EMC1001_TEMP_LIMIT_LO_H , 22)
	MOVLW	7
	MOVWF	_EMC_REG
	MOVLW	22
	MOVWF	_EMC_DATA
	CALL	EMC1001_WRITE
;EMC1001_Write ( EMC1001_TEMP_THERM_LIMIT, 30)
	MOVLW	32
	MOVWF	_EMC_REG
	MOVLW	30
	MOVWF	_EMC_DATA
	CALL	EMC1001_WRITE
;EMC1001_Write ( EMC1001_TEMP_THERM_HYSTERIS, 0x01)
	MOVLW	33
	MOVWF	_EMC_REG
	MOVLW	1
	MOVWF	_EMC_DATA
	CALL	EMC1001_WRITE
;EMC1001_Write ( EMC1001_TEMP_SMBus_Timeout, 0xFF)
	MOVLW	34
	MOVWF	_EMC_REG
	MOVLW	255
	MOVWF	_EMC_DATA
	CALL	EMC1001_WRITE
;Initiliase the character set.  If button is pressed at start... show the character
;If SWITCH = SWITCH_DOWN Then
	BTFSC	PORTA,5
	GOTO	ENDIF1
;showDegreeChar = TRUE
	MOVLW	255
	MOVWF	SHOWDEGREECHAR
;End If
ENDIF1:
;Do
SYSDOLOOP_S1:
;Optionally, Send a bell alert to the terminal
;HSerSend 7
;Read Product ID register
;EMC1001_Read( EMC1001_TEMP_PROD_ID ,  data )
	MOVLW	253
	MOVWF	_EMC_REG
	CALL	EMC1001_READ
	MOVF	_EMC_DATA,W
	MOVWF	DATA
;If ( HI2C2WaitMSSPTimeout <> TRUE )  Then
	INCF	HI2C2WAITMSSPTIMEOUT,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF2
;HSerPrint "Product ID:         EMC1001"
	MOVLW	LOW STRINGTABLE4
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE4) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;If data <> 0 Then
	MOVF	DATA,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF14
;HSerPrint "-"
	MOVLW	LOW STRINGTABLE5
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE5) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;HSerPrintByteCRLF data
	MOVF	DATA,W
	MOVWF	PRINTVALUE
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTBYTECRLF
;End If
ENDIF14:
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;End If
ENDIF2:
;Read Manufacturer ID register
;EMC1001_Read( EMC1001_TEMP_MANUFACTURE_ID,  data )
	MOVLW	254
	MOVWF	_EMC_REG
	CALL	EMC1001_READ
	MOVF	_EMC_DATA,W
	MOVWF	DATA
;If ( HI2C2WaitMSSPTimeout <> TRUE )  Then
	INCF	HI2C2WAITMSSPTIMEOUT,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF3
;HSerPrint "Manufacturer ID:    0x"
	MOVLW	LOW STRINGTABLE6
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE6) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;HSerPrint Hex(data)
	MOVF	DATA,W
	MOVWF	SYSVALTEMP
	CALL	FN__HEXPICAS
	MOVLW	LOW _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH _HEXPICAS
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;End If
ENDIF3:
;Read Revision register
;EMC1001_Read( EMC1001_TEMP_REV_NUMBER,  data )
	MOVLW	255
	MOVWF	_EMC_REG
	CALL	EMC1001_READ
	MOVF	_EMC_DATA,W
	MOVWF	DATA
;If ( HI2C2WaitMSSPTimeout <> TRUE )  Then
	INCF	HI2C2WAITMSSPTIMEOUT,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF4
;HSerPrint "Revision:           "
	MOVLW	LOW STRINGTABLE7
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE7) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;HSerPrintByteCRLF data
	MOVF	DATA,W
	MOVWF	PRINTVALUE
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTBYTECRLF
;End If
ENDIF4:
;Read temp registers
;EMC1001_Read( EMC1001_TEMP_HI,  hi )
	CLRF	_EMC_REG
	CALL	EMC1001_READ
	MOVF	_EMC_DATA,W
	MOVWF	HI
;EMC1001_Read( EMC1001_TEMP_LO,  lo )
	MOVLW	2
	MOVWF	_EMC_REG
	CALL	EMC1001_READ
	MOVF	_EMC_DATA,W
	MOVWF	LO
;If ( HI2C2WaitMSSPTimeout <> TRUE )  Then
	INCF	HI2C2WAITMSSPTIMEOUT,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF5
;emc_temp = 0
	CLRF	EMC_TEMP
	CLRF	EMC_TEMP_H
;emc_temp_h = hi
	MOVF	HI,W
	MOVWF	EMC_TEMP_H
;If ( HI2C2WaitMSSPTimeout <> TRUE )  Then
	INCF	HI2C2WAITMSSPTIMEOUT,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF15
;emc_temp = emc_temp + lo
	MOVF	LO,W
	ADDWF	EMC_TEMP,F
	MOVLW	0
	ADDWFC	EMC_TEMP_H,F
;HSerPrint "The temperature is: "
	MOVLW	LOW STRINGTABLE8
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE8) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;The sensor is read as a 8 bit value therefore each unit equates to 0.25 of a degree
;Dim DSdata As Word
;Dim TempC_100 As Word
;DSdata = emc_temp
	MOVF	EMC_TEMP,W
	MOVWF	DSDATA
	MOVF	EMC_TEMP_H,W
	MOVWF	DSDATA_H
;SignBit = DSdata.15
	CLRF	SIGNBIT
	BTFSC	DSDATA_H,7
	INCF	SIGNBIT,F
;If SignBit = 0 Then Goto Positive
	MOVF	SIGNBIT,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	POSITIVE
;its negative!
;take twos comp
;DSdata = ( DSdata # 0xffff ) + 1
	MOVLW	255
	XORWF	DSDATA,W
	MOVWF	SYSTEMP1
	MOVLW	255
	XORWF	DSDATA_H,W
	MOVWF	SYSTEMP1_H
	MOVLW	1
	ADDWF	SYSTEMP1,W
	MOVWF	DSDATA
	MOVLW	0
	ADDWFC	SYSTEMP1_H,W
	MOVWF	DSDATA_H
POSITIVE:
;TempC_100 =  FnLSR ( DSdata, 6 )
	MOVF	DSDATA,W
	MOVWF	SYSWORDTEMPB
	MOVF	DSDATA_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVLW	6
	MOVWF	NUMBITS
	CALL	FN_FNLSR106
	MOVF	SYSFNLSRWORD,W
	MOVWF	TEMPC_100
	MOVF	SYSFNLSRWORD_H,W
	MOVWF	TEMPC_100_H
;TempC_100 = ( TempC_100 * 25 )
	MOVF	TEMPC_100,W
	MOVWF	SYSWORDTEMPA
	MOVF	TEMPC_100_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	25
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSMULTSUB16
	MOVF	SYSWORDTEMPX,W
	MOVWF	TEMPC_100
	MOVF	SYSWORDTEMPX_H,W
	MOVWF	TEMPC_100_H
;Whole = TempC_100 / 100
	MOVF	TEMPC_100,W
	MOVWF	SYSWORDTEMPA
	MOVF	TEMPC_100_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	100
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	MOVWF	WHOLE
;Fract = TempC_100 % 100
	MOVF	TEMPC_100,W
	MOVWF	SYSWORDTEMPA
	MOVF	TEMPC_100_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	100
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPX,W
	MOVWF	FRACT
;If SignBit = 0 Then Goto DisplayTemp
	MOVF	SIGNBIT,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	DISPLAYTEMP
;HSerPrint "-"
	MOVLW	LOW STRINGTABLE5
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE5) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
DISPLAYTEMP:
;HSerPrint Str(Whole)
	MOVF	WHOLE,W
	MOVWF	SYSVALTEMP
	CLRF	SYSVALTEMP_H
	CALL	FN_STR
	MOVLW	LOW STR
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH STR
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;HSerPrint "."
	MOVLW	LOW STRINGTABLE9
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE9) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;To ensure the decimal part is two digits
;Dig = Fract / 10
	MOVF	FRACT,W
	MOVWF	SYSBYTETEMPA
	MOVLW	10
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPA,W
	MOVWF	DIG
;HSerPrint Dig
	MOVWF	SERPRINTVAL
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT319
;Dig = Fract % 10
	MOVF	FRACT,W
	MOVWF	SYSBYTETEMPA
	MOVLW	10
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPX,W
	MOVWF	DIG
;HSerPrint Dig
	MOVWF	SERPRINTVAL
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT319
;If showDegreeChar = TRUE Then
	INCF	SHOWDEGREECHAR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF20
;HSerPrint CHR(0xB0)
	MOVLW	176
	MOVWF	SYSCHAR
	CALL	FN_CHR
	MOVLW	LOW CHR
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH CHR
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;End If
ENDIF20:
;HSerPrint "C"
	MOVLW	LOW STRINGTABLE10
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE10) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;End If
ENDIF15:
;End If
ENDIF5:
;Read Conversion register
;EMC1001_Read( EMC1001_CONV_RATE ,  data )
	MOVLW	4
	MOVWF	_EMC_REG
	CALL	EMC1001_READ
	MOVF	_EMC_DATA,W
	MOVWF	DATA
;If ( HI2C2WaitMSSPTimeout <> TRUE )  Then
	INCF	HI2C2WAITMSSPTIMEOUT,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF6
;HSerPrint "Conversion rate is: "
	MOVLW	LOW STRINGTABLE11
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE11) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;HSerPrintByteCRLF data
	MOVF	DATA,W
	MOVWF	PRINTVALUE
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTBYTECRLF
;End If
ENDIF6:
;Read Hi limit register
;EMC1001_Read(EMC1001_TEMP_LIMIT_HI_H,  data )
	MOVLW	5
	MOVWF	_EMC_REG
	CALL	EMC1001_READ
	MOVF	_EMC_DATA,W
	MOVWF	DATA
;If ( HI2C2WaitMSSPTimeout <> TRUE )  Then
	INCF	HI2C2WAITMSSPTIMEOUT,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF7
;HSerPrint "High limit is:      "
	MOVLW	LOW STRINGTABLE12
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE12) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;HSerPrint data
	MOVF	DATA,W
	MOVWF	SERPRINTVAL
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT319
;If showDegreeChar = TRUE Then
	INCF	SHOWDEGREECHAR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF16
;HSerPrint CHR(0xB0)
	MOVLW	176
	MOVWF	SYSCHAR
	CALL	FN_CHR
	MOVLW	LOW CHR
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH CHR
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;End If
ENDIF16:
;HSerPrint "C"
	MOVLW	LOW STRINGTABLE10
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE10) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;End If
ENDIF7:
;Read Low Limit register
;EMC1001_Read( EMC1001_TEMP_LIMIT_LO_H,  data )
	MOVLW	7
	MOVWF	_EMC_REG
	CALL	EMC1001_READ
	MOVF	_EMC_DATA,W
	MOVWF	DATA
;If ( HI2C2WaitMSSPTimeout <> TRUE )  Then
	INCF	HI2C2WAITMSSPTIMEOUT,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF8
;HSerPrint "Low limit is:       "
	MOVLW	LOW STRINGTABLE13
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE13) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;HSerPrint data
	MOVF	DATA,W
	MOVWF	SERPRINTVAL
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT319
;If showDegreeChar = TRUE Then
	INCF	SHOWDEGREECHAR,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF17
;HSerPrint CHR(0xB0)
	MOVLW	176
	MOVWF	SYSCHAR
	CALL	FN_CHR
	MOVLW	LOW CHR
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH CHR
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;End If
ENDIF17:
;HSerPrint "C"
	MOVLW	LOW STRINGTABLE10
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE10) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;End If
ENDIF8:
;Read Status register
;EMC1001_Read( EMC1001_TEMP_STATUS,  data )
	MOVLW	1
	MOVWF	_EMC_REG
	CALL	EMC1001_READ
	MOVF	_EMC_DATA,W
	MOVWF	DATA
;If ( HI2C2WaitMSSPTimeout <> TRUE )  Then
	INCF	HI2C2WAITMSSPTIMEOUT,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	GOTO	ENDIF9
;HSerPrint "Status is:          "
	MOVLW	LOW STRINGTABLE14
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE14) | 128
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;HSerPrint ByteToBin ( data )
	MOVF	DATA,W
	MOVWF	BYTENUM
	CALL	FN_BYTETOBIN
	MOVLW	LOW BYTETOBIN
	MOVWF	SYSPRINTDATAHANDLER
	MOVLW	HIGH BYTETOBIN
	MOVWF	SYSPRINTDATAHANDLER_H
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT318
;HSerPrintCRLF
	MOVLW	1
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;End If
ENDIF9:
;oldStatus = data
	MOVF	DATA,W
	MOVWF	OLDSTATUS
;Do While check_switch = check_switch
	CALL	FN_CHECK_SWITCH
	MOVF	CHECK_SWITCH,W
	MOVWF	SYSFNBYTE1
SYSDOLOOP_S2:
	CALL	FN_CHECK_SWITCH
	MOVF	CHECK_SWITCH,W
	SUBWF	SYSFNBYTE1,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSDOLOOP_E2
;SetWith ( LEDD2 , FnNotBit ( LEDD2 ) )
;Macro Source: stdbasic.h (369)
;if Source then
	CLRF	BITIN
	BTFSC	PORTA,0
	INCF	BITIN,F
	CALL	FN_FNNOTBIT
	BTFSS	SYSBITVAR2,0
	GOTO	ELSE10_1
;TargetBit = 1
	BSF	LATA,0
;else
	GOTO	ENDIF10
ELSE10_1:
;TargetBit = 0
	BCF	LATA,0
;end if
ENDIF10:
;Wait 100 ms
	MOVLW	100
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;Alarms
;SetWith ( LEDD4 , FnEquBit ( ALARM1 ) )
;Macro Source: stdbasic.h (369)
;if Source then
	CLRF	BITIN
	BTFSC	PORTA,7
	INCF	BITIN,F
	CALL	FN_FNEQUBIT
	BTFSS	SYSBITVAR1,7
	GOTO	ELSE11_1
;TargetBit = 1
	BSF	LATA,2
;else
	GOTO	ENDIF11
ELSE11_1:
;TargetBit = 0
	BCF	LATA,2
;end if
ENDIF11:
;SetWith ( LEDD5 , FnEquBit ( ALARM2 ) )
;Macro Source: stdbasic.h (369)
;if Source then
	CLRF	BITIN
	BTFSC	PORTA,6
	INCF	BITIN,F
	CALL	FN_FNEQUBIT
	BTFSS	SYSBITVAR1,7
	GOTO	ELSE12_1
;TargetBit = 1
	BSF	LATA,3
;else
	GOTO	ENDIF12
ELSE12_1:
;TargetBit = 0
	BCF	LATA,3
;end if
ENDIF12:
;EMC1001_Read( EMC1001_TEMP_STATUS,  data )
	MOVLW	1
	MOVWF	_EMC_REG
	CALL	EMC1001_READ
	MOVF	_EMC_DATA,W
	MOVWF	DATA
;If data <> oldStatus Then
	MOVF	OLDSTATUS,W
	SUBWF	DATA,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;Exit to show all the information
;Exit Do
	GOTO	SYSDOLOOP_E2
;End If
;Loop
	GOTO	SYSDOLOOP_S2
SYSDOLOOP_E2:
;HSerPrintCRLF 2
	MOVLW	2
	MOVWF	HSERPRINTCRLFCOUNT
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINTCRLF
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
;----- Support methods.  Subroutines and Functions
;global variable - if button is held down, we don't want to keep on switching directions
;Dim previous_state As BIT
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

;SOURCE: STRING.H (551)
FN_BYTETOBIN:
;ByteToBin = ""
	MOVLW	LOW BYTETOBIN
MOVWF	FSR1L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR1H
	MOVLW	LOW STRINGTABLE47
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE47) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRING
;Repeat 8
	MOVLW	8
	MOVWF	SYSREPEATTEMP2
SYSREPEATLOOP2:
;If ByteNum.7 = 1 Then
	BTFSS	BYTENUM,7
	GOTO	ELSE48_1
;ByteToBin = ByteToBin +"1"
	MOVLW	LOW BYTETOBIN
MOVWF	FSR1L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR1H
	CLRF	SYSSTRINGLENGTH
	MOVLW	LOW BYTETOBIN
MOVWF	FSR0L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR0H
	CALL	SYSCOPYSTRINGPART
	MOVLW	LOW STRINGTABLE48
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE48) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRINGPART
	MOVLW	LOW BYTETOBIN
MOVWF	FSR0L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR0H
	MOVF	SYSSTRINGLENGTH,W
MOVWF	INDF0
;Else
	GOTO	ENDIF48
ELSE48_1:
;ByteToBin = ByteToBin +"0"
	MOVLW	LOW BYTETOBIN
MOVWF	FSR1L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR1H
	CLRF	SYSSTRINGLENGTH
	MOVLW	LOW BYTETOBIN
MOVWF	FSR0L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR0H
	CALL	SYSCOPYSTRINGPART
	MOVLW	LOW STRINGTABLE49
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE49) & 127
	MOVWF	SYSSTRINGA_H
	CALL	SYSREADSTRINGPART
	MOVLW	LOW BYTETOBIN
MOVWF	FSR0L
	MOVLW	HIGH BYTETOBIN
MOVWF	FSR0H
	MOVF	SYSSTRINGLENGTH,W
MOVWF	INDF0
;End If
ENDIF48:
;Rotate ByteNum Left
	RLF	BYTENUM,F
;End Repeat
	DECFSZ	SYSREPEATTEMP2,F
	GOTO	SYSREPEATLOOP2
SYSREPEATLOOPEND2:
	RETURN

;********************************************************************************

;SOURCE: 20_TEMPERATURE_SENSOR_ALARMS_TO_SERIAL_TERMINAL.GCB (275)
FN_CHECK_SWITCH:
;switch is normally open to 5V ...when pressed, RA3 is connected to GND
;If (SWITCH = SWITCH_DOWN) Then
	BTFSC	PORTA,5
	GOTO	ELSE28_1
;debounce by delaying and checking if switch is still pressed
;Wait 1 ms
	MOVLW	1
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;If ( (previous_state =  SWITCH_DOWN) & (SWITCH = SWITCH_DOWN) ) Then
	CLRF	SYSBYTETEMPX
	BTFSS	SYSBITVAR0,0
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP1
	CLRF	SYSBYTETEMPX
	BTFSS	PORTA,5
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP2
	MOVF	SYSTEMP1,W
	ANDWF	SYSTEMP2,W
	MOVWF	SYSTEMP3
	BTFSS	SYSTEMP3,0
	GOTO	ELSE29_1
;don't toggle
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;Else
	GOTO	ENDIF29
ELSE29_1:
;check if still down
;If (SWITCH = SWITCH_DOWN) Then
	BTFSC	PORTA,5
	GOTO	ELSE30_1
;previous_state = SWITCH_DOWN
	BCF	SYSBITVAR0,0
;reverse the LEDs
;check_switch = TRUE
	MOVLW	255
	MOVWF	CHECK_SWITCH
;Exit Function
	RETURN
;Else
	GOTO	ENDIF30
ELSE30_1:
;switch not properly held down
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0
;don't reverse
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;End If
ENDIF30:
;End If
ENDIF29:
;Else
	GOTO	ENDIF28
ELSE28_1:
;switch not pressed
;previous_state = SWITCH_UP
	BSF	SYSBITVAR0,0
;don't reverse
;check_switch = FALSE
	CLRF	CHECK_SWITCH
;Exit Function
	RETURN
;End If
ENDIF28:
	RETURN

;********************************************************************************

;SOURCE: STRING.H (536)
FN_CHR:
;Empty input?
;If SysChar < 0 Then
	MOVLW	0
	SUBWF	SYSCHAR,W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF47
;Chr(0) = 0
	BANKSEL	SYSCHR_0
	CLRF	SYSCHR_0
;Exit Function
BANKSEL	STATUS
	RETURN
;End If
ENDIF47:
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

;SOURCE: EMC1001.H (46)
EMC1001_READ:
;HI2C2Start
	CALL	HI2C2START
;Hi2C2Send ( EMC1001_ADDRESS )
	MOVLW	112
	MOVWF	I2C2BYTE
	CALL	HI2C2SEND
;HI2C2Send ( _emc_reg )
	MOVF	_EMC_REG,W
	MOVWF	I2C2BYTE
	CALL	HI2C2SEND
;HI2C2ReStart
	CALL	HI2C2RESTART
;HI2C2Send( EMC1001_ADDRESS + 1 )         ;set the read flag
	MOVLW	113
	MOVWF	I2C2BYTE
	CALL	HI2C2SEND
;HI2C2Receive( _emc_Data, NACK )           ;read one byte and conclude
	CLRF	HI2CGETACK
	CALL	HI2C2RECEIVE
	MOVF	HI2C2BYTE,W
	MOVWF	_EMC_DATA
;HI2C2Stop
	GOTO	HI2C2STOP

;********************************************************************************

;SOURCE: EMC1001.H (61)
EMC1001_WRITE:
;HI2C2Start
	CALL	HI2C2START
;Hi2C2Send ( EMC1001_ADDRESS )
	MOVLW	112
	MOVWF	I2C2BYTE
	CALL	HI2C2SEND
;HI2C2Send ( _emc_reg )
	MOVF	_EMC_REG,W
	MOVWF	I2C2BYTE
	CALL	HI2C2SEND
;HI2C2Send( _emc_Data )         ; Send the data
	MOVF	_EMC_DATA,W
	MOVWF	I2C2BYTE
	CALL	HI2C2SEND
;HI2C2Stop
	GOTO	HI2C2STOP

;********************************************************************************

;SOURCE: STDBASIC.H (436)
FN_FNEQUBIT:
;If BitIn then
	MOVF	BITIN,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	GOTO	ELSE37_1
;FnEQUBit = 1
	BSF	SYSBITVAR1,7
;Else
	GOTO	ENDIF37
ELSE37_1:
;FnEQUBit = 0
	BCF	SYSBITVAR1,7
;End If
ENDIF37:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: WORD:BYTE:, SOURCE: STDBASIC.H (386)
FN_FNLSR106:
;Repeat NumBits
	MOVF	NUMBITS,W
	MOVWF	SYSREPEATTEMP1
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	GOTO	SYSREPEATLOOPEND1
SYSREPEATLOOP1:
;Set C Off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate SysWordTempB Right
	RRF	SYSWORDTEMPB_H,F
	RRF	SYSWORDTEMPB,F
;End Repeat
	DECFSZ	SYSREPEATTEMP1,F
	GOTO	SYSREPEATLOOP1
SYSREPEATLOOPEND1:
;FnLSR = SysWordTempB
	MOVF	SYSWORDTEMPB,W
	MOVWF	FNLSR
	MOVF	SYSWORDTEMPB_H,W
	MOVWF	FNLSR_H
	RETURN

;********************************************************************************

;SOURCE: STDBASIC.H (446)
FN_FNNOTBIT:
;If BitIn then
	MOVF	BITIN,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	GOTO	ELSE38_1
;FnNOTBit = 0
	BCF	SYSBITVAR2,0
;Else
	GOTO	ENDIF38
ELSE38_1:
;FnNOTBit = 1
	BSF	SYSBITVAR2,0
;End If
ENDIF38:
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
	GOTO	ENDIF31
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
ENDIF31:
;if HI2C2CurrentMode = Slave then
	BANKSEL	HI2C2CURRENTMODE
	MOVF	HI2C2CURRENTMODE,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF32
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
ENDIF32:
;if HI2C2CurrentMode = Slave10 then
	MOVLW	3
	BANKSEL	HI2C2CURRENTMODE
	SUBWF	HI2C2CURRENTMODE,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF33
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
ENDIF33:
;Enable I2C
;set SSP2CON1_SSPEN on
BANKSEL	SSP2CON1
;B7: ASM Source was:  BSF SSP2CON1,SSP2CON1_SSPEN
	BSF	SSP2CON1,5
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C2.H (303)
HI2C2RECEIVE:
;Enable receive
;Master mode
;If HI2C2CurrentMode > 10 Then
	MOVF	HI2C2CURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ELSE61_1
;if HI2CGetAck.0 = 1 then
	BTFSS	HI2CGETACK,0
	GOTO	ELSE63_1
;Acknowledge
;SSP2CON2_ACKDT = 0
BANKSEL	SSP2CON2
;B7: ASM Source was:  BCF SSP2CON2,SSP2CON2_ACKDT
	BCF	SSP2CON2,5
;else
	GOTO	ENDIF63
ELSE63_1:
;Not Acknowledge
;SSP2CON2_ACKDT = 1
BANKSEL	SSP2CON2
;B7: ASM Source was:  BSF SSP2CON2,SSP2CON2_ACKDT
	BSF	SSP2CON2,5
;end if
ENDIF63:
;SSP2CON2_RCEN = 1
;B7: ASM Source was:  BSF SSP2CON2,SSP2CON2_RCEN
	BSF	SSP2CON2,3
;Slave mode
;Else
	GOTO	ENDIF61
ELSE61_1:
;SET SSP2STAT_R_NOT_W ON
BANKSEL	SSP2STAT
;B7: ASM Source was:  BSF SSP2STAT,SSP2STAT_R_NOT_W
	BSF	SSP2STAT,2
;End If
ENDIF61:
;Clear Collisions
;SET SSP2CON1_WCOL OFF
;B7: ASM Source was:  BCF SSP2CON1,SSP2CON1_WCOL
	BCF	SSP2CON1,7
;SET SSP2CON1_SSPOV Off
;B7: ASM Source was:  BCF SSP2CON1,SSP2CON1_SSPOV
	BCF	SSP2CON1,6
;Wait for receive
;Wait Until SSP2STAT_BF = 1
SYSWAITLOOP4:
;B7: ASM Source was:  BTFSS SSP2STAT,SSP2STAT_BF
	BTFSS	SSP2STAT,0
	GOTO	SYSWAITLOOP4
;HI2C2Byte = SSP2BUF
	MOVF	SSP2BUF,W
	BANKSEL	HI2C2BYTE
	MOVWF	HI2C2BYTE
;SSP2IF = 0
BANKSEL	PIR3
;B7: ASM Source was:  BCF PIR3,SSP2IF
	BCF	PIR3,2
;SSP2CON2_ACKEN = 1
BANKSEL	SSP2CON2
;B7: ASM Source was:  BSF SSP2CON2,SSP2CON2_ACKEN
	BSF	SSP2CON2,4
;Clear flag - this is required
;SSP2STAT_BF = 0
;B7: ASM Source was:  BCF SSP2STAT,SSP2STAT_BF
	BCF	SSP2STAT,0
;HI2C2WaitMSSP
BANKSEL	STATUS
	CALL	HI2C2WAITMSSP
;Disable receive (master mode)
;Master mode
;If HI2C2CurrentMode > 10 Then
	MOVF	HI2C2CURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ELSE62_1
;Set SSP2CON2_RCEN Off
BANKSEL	SSP2CON2
;B7: ASM Source was:  BCF SSP2CON2,SSP2CON2_RCEN
	BCF	SSP2CON2,3
;Slave mode
;Else
	GOTO	ENDIF62
ELSE62_1:
;SET SSP2STAT_R_NOT_W Off
BANKSEL	SSP2STAT
;B7: ASM Source was:  BCF SSP2STAT,SSP2STAT_R_NOT_W
	BCF	SSP2STAT,2
;End If
ENDIF62:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C2.H (197)
HI2C2RESTART:
;Master mode
;If HI2C2CurrentMode > 10 Then
	MOVF	HI2C2CURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF55
;Set SSP2CON2_RSEN On
BANKSEL	SSP2CON2
;B7: ASM Source was:  BSF SSP2CON2,SSP2CON2_RSEN
	BSF	SSP2CON2,1
;HI2C2WaitMSSP
BANKSEL	STATUS
	CALL	HI2C2WAITMSSP
;End If
ENDIF55:
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
	GOTO	ELSE57_1
;HI2C2AckPollState = true
	MOVLW	255
	BANKSEL	HI2C2ACKPOLLSTATE
	MOVWF	HI2C2ACKPOLLSTATE
;else
	GOTO	ENDIF57
ELSE57_1:
;HI2C2AckPollState = false
	BANKSEL	HI2C2ACKPOLLSTATE
	CLRF	HI2C2ACKPOLLSTATE
;end if
ENDIF57:
;If SSP2CON1_WCOL  = On Then
BANKSEL	SSP2CON1
;B7: ASM Source was:  BTFSS SSP2CON1,SSP2CON1_WCOL
	BTFSS	SSP2CON1,7
	GOTO	ENDIF58
;If HI2C2CurrentMode <= 10 Then Goto RetryHI2C2Send
	BANKSEL	HI2C2CURRENTMODE
	MOVF	HI2C2CURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	RETRYHI2C2SEND
;End If
ENDIF58:
;Release clock (only needed by slave)
;If HI2C2CurrentMode <= 10 Then Set SSP2CON1_CKP On
	BANKSEL	HI2C2CURRENTMODE
	MOVF	HI2C2CURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	ENDIF59
BANKSEL	SSP2CON1
;B7: ASM Source was:  BSF SSP2CON1,SSP2CON1_CKP
	BSF	SSP2CON1,4
ENDIF59:
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
	GOTO	ELSE54_1
;Set SSP2CON2_SEN On
BANKSEL	SSP2CON2
;B7: ASM Source was:  BSF SSP2CON2,SSP2CON2_SEN
	BSF	SSP2CON2,0
;HI2C2WaitMSSP
BANKSEL	STATUS
	CALL	HI2C2WAITMSSP
;Slave mode
;Else
	GOTO	ENDIF54
ELSE54_1:
;Wait Until SSP2STAT_S = On
SYSWAITLOOP1:
BANKSEL	SSP2STAT
;B7: ASM Source was:  BTFSS SSP2STAT,SSP2STAT_S
	BTFSS	SSP2STAT,3
	GOTO	SYSWAITLOOP1
;End If
ENDIF54:
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
	GOTO	ELSE56_1
;wait while SSP2STAT_R_NOT_W = 1   'wait for completion of activities
SYSWAITLOOP2:
BANKSEL	SSP2STAT
;B7: ASM Source was:  BTFSC SSP2STAT,SSP2STAT_R_NOT_W
	BTFSC	SSP2STAT,2
	GOTO	SYSWAITLOOP2
;Set SSP2CON2_PEN On
;B7: ASM Source was:  BSF SSP2CON2,SSP2CON2_PEN
	BSF	SSP2CON2,2
;HI2C2WaitMSSP
BANKSEL	STATUS
	CALL	HI2C2WAITMSSP
;Slave mode
;Else
	GOTO	ENDIF56
ELSE56_1:
;Wait Until SSP2STAT_P = On
SYSWAITLOOP3:
BANKSEL	SSP2STAT
;B7: ASM Source was:  BTFSS SSP2STAT,SSP2STAT_P
	BTFSS	SSP2STAT,4
	GOTO	SYSWAITLOOP3
;End If
ENDIF56:
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
	GOTO	ENDIF64
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
ENDIF64:
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
HSERPRINT318:
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
	GOTO	ENDIF49
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
	CALL	HSERSEND308
;next
	MOVF	PRINTLEN,W
	SUBWF	SYSPRINTTEMP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP2
SYSFORLOOPEND2:
;End If
ENDIF49:
;CR
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (1405)
HSERPRINT319:
;OutValueTemp = 0
	CLRF	OUTVALUETEMP
;IF SerPrintVal >= 100 Then
	MOVLW	100
	SUBWF	SERPRINTVAL,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	ENDIF52
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
	CALL	HSERSEND308
;End If
ENDIF52:
;If OutValueTemp > 0 Or SerPrintVal >= 10 Then
	MOVF	OUTVALUETEMP,W
	MOVWF	SYSBYTETEMPB
	CLRF	SYSBYTETEMPA
	CALL	SYSCOMPLESSTHAN
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP2
	MOVF	SERPRINTVAL,W
	MOVWF	SYSBYTETEMPA
	MOVLW	10
	MOVWF	SYSBYTETEMPB
	CALL	SYSCOMPLESSTHAN
	COMF	SYSBYTETEMPX,F
	MOVF	SYSTEMP2,W
	IORWF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP3
	BTFSS	SYSTEMP3,0
	GOTO	ENDIF53
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
	CALL	HSERSEND308
;End If
ENDIF53:
;HSerSend(SerPrintVal + 48 ,comport)
	MOVLW	48
	ADDWF	SERPRINTVAL,W
	MOVWF	SERDATA
	CALL	HSERSEND308
;CR
	RETURN

;********************************************************************************

;SOURCE: USART.H (1532)
HSERPRINTBYTECRLF:
;HSerPrint(PrintValue)
	MOVF	PRINTVALUE,W
	MOVWF	SERPRINTVAL
	MOVLW	1
	MOVWF	COMPORT
	CALL	HSERPRINT319
;HSerSend(13,comport)
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND308
;HSerSend(10,comport)
	MOVLW	10
	MOVWF	SERDATA
	GOTO	HSERSEND308

;********************************************************************************

;SOURCE: USART.H (1538)
HSERPRINTCRLF:
;repeat HSerPrintCRLFCount
	MOVF	HSERPRINTCRLFCOUNT,W
	MOVWF	SYSREPEATTEMP3
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	GOTO	SYSREPEATLOOPEND3
SYSREPEATLOOP3:
;HSerSend(13,comport)
	MOVLW	13
	MOVWF	SERDATA
	CALL	HSERSEND308
;HSerSend(10,comport)
	MOVLW	10
	MOVWF	SERDATA
	CALL	HSERSEND308
;end Repeat
	DECFSZ	SYSREPEATTEMP3,F
	GOTO	SYSREPEATLOOP3
SYSREPEATLOOPEND3:
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: BYTE:BYTE:, SOURCE: USART.H (848)
HSERSEND308:
;Registers/Bits determined by #samevar at top of library
;if comport = 1 Then
	DECF	COMPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF66
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
ENDIF66:
	RETURN

;********************************************************************************

;SOURCE: 20_TEMPERATURE_SENSOR_ALARMS_TO_SERIAL_TERMINAL.GCB (65)
INITPPS:
;UNLOCKPPS
;Macro Source: stdbasic.h (78)
;dim IntState as bit
;IntState = GIE
	BCF	SYSBITVAR0,2
;B7: ASM Source was:  BTFSC INTCON,GIE
	BTFSC	INTCON,7
	BSF	SYSBITVAR0,2
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
;RC3->MSSP2:SDA2;
;RC3PPS = 0x0017
	MOVLW	23
BANKSEL	RC3PPS
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
	BTFSS	SYSBITVAR0,2
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
	BTFSC	SYSBITVAR0,2
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

;SOURCE: STRING.H (75)
FN_STR:
;SysCharCount = 0
	CLRF	SYSCHARCOUNT
;Dim SysCalcTempX As Word
;Ten Thousands
;IF SysValTemp >= 10000 then
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	16
	MOVWF	SYSWORDTEMPB
	MOVLW	39
	MOVWF	SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF43
;SysStrData = SysValTemp / 10000
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	16
	MOVWF	SYSWORDTEMPB
	MOVLW	39
	MOVWF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	MOVWF	SYSSTRDATA
;SysValTemp = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SYSVALTEMP
	MOVF	SYSCALCTEMPX_H,W
	MOVWF	SYSVALTEMP_H
;SysCharCount += 1
	INCF	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	MOVLW	LOW(STR)
	ADDWF	SYSCHARCOUNT,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	CLRF	SYSTEMP2
	MOVLW	HIGH(STR)
	ADDWFC	SYSTEMP2,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVLW	48
	ADDWF	SYSSTRDATA,W
MOVWF	INDF0
;Goto SysValThousands
	GOTO	SYSVALTHOUSANDS
;End If
ENDIF43:
;Thousands
;IF SysValTemp >= 1000 then
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	232
	MOVWF	SYSWORDTEMPB
	MOVLW	3
	MOVWF	SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF44
SYSVALTHOUSANDS:
;SysStrData = SysValTemp / 1000
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	232
	MOVWF	SYSWORDTEMPB
	MOVLW	3
	MOVWF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	MOVWF	SYSSTRDATA
;SysValTemp = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SYSVALTEMP
	MOVF	SYSCALCTEMPX_H,W
	MOVWF	SYSVALTEMP_H
;SysCharCount += 1
	INCF	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	MOVLW	LOW(STR)
	ADDWF	SYSCHARCOUNT,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	CLRF	SYSTEMP2
	MOVLW	HIGH(STR)
	ADDWFC	SYSTEMP2,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVLW	48
	ADDWF	SYSSTRDATA,W
MOVWF	INDF0
;Goto SysValHundreds
	GOTO	SYSVALHUNDREDS
;End If
ENDIF44:
;Hundreds
;IF SysValTemp >= 100 then
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	100
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF45
SYSVALHUNDREDS:
;SysStrData = SysValTemp / 100
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	100
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	MOVWF	SYSSTRDATA
;SysValTemp = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SYSVALTEMP
	MOVF	SYSCALCTEMPX_H,W
	MOVWF	SYSVALTEMP_H
;SysCharCount += 1
	INCF	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	MOVLW	LOW(STR)
	ADDWF	SYSCHARCOUNT,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	CLRF	SYSTEMP2
	MOVLW	HIGH(STR)
	ADDWFC	SYSTEMP2,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVLW	48
	ADDWF	SYSSTRDATA,W
MOVWF	INDF0
;Goto SysValTens
	GOTO	SYSVALTENS
;End If
ENDIF45:
;Tens
;IF SysValTemp >= 10 Then
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	10
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPLESSTHAN16
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF46
SYSVALTENS:
;SysStrData = SysValTemp / 10
	MOVF	SYSVALTEMP,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSVALTEMP_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	10
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSDIVSUB16
	MOVF	SYSWORDTEMPA,W
	MOVWF	SYSSTRDATA
;SysValTemp = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SYSVALTEMP
	MOVF	SYSCALCTEMPX_H,W
	MOVWF	SYSVALTEMP_H
;SysCharCount += 1
	INCF	SYSCHARCOUNT,F
;Str(SysCharCount) = SysStrData + 48
	MOVLW	LOW(STR)
	ADDWF	SYSCHARCOUNT,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	CLRF	SYSTEMP2
	MOVLW	HIGH(STR)
	ADDWFC	SYSTEMP2,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVLW	48
	ADDWF	SYSSTRDATA,W
MOVWF	INDF0
;End If
ENDIF46:
;Ones
;SysCharCount += 1
	INCF	SYSCHARCOUNT,F
;Str(SysCharCount) = SysValTemp + 48
	MOVLW	LOW(STR)
	ADDWF	SYSCHARCOUNT,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	CLRF	SYSTEMP2
	MOVLW	HIGH(STR)
	ADDWFC	SYSTEMP2,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVLW	48
	ADDWF	SYSVALTEMP,W
MOVWF	INDF0
;SysValTemp = SysCalcTempX
	MOVF	SYSCALCTEMPX,W
	MOVWF	SYSVALTEMP
	MOVF	SYSCALCTEMPX_H,W
	MOVWF	SYSVALTEMP_H
;Str(0) = SysCharCount
	MOVF	SYSCHARCOUNT,W
	BANKSEL	SYSSTR_0
	MOVWF	SYSSTR_0
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2894)
SYSCOMPEQUAL16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test low, exit if false
;movf SysWordTempA, W
	MOVF	SYSWORDTEMPA, W
;subwf SysWordTempB, W
	SUBWF	SYSWORDTEMPB, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test high, exit if false
;movf SysWordTempA_H, W
	MOVF	SYSWORDTEMPA_H, W
;subwf SysWordTempB_H, W
	SUBWF	SYSWORDTEMPB_H, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
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

;SOURCE: SYSTEM.H (3065)
SYSCOMPLESSTHAN16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test High, exit if more
;movf SysWordTempA_H,W
	MOVF	SYSWORDTEMPA_H,W
;subwf SysWordTempB_H,W
	SUBWF	SYSWORDTEMPB_H,W
;btfss STATUS,C
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;Test high, exit true if less
;movf SysWordTempB_H,W
	MOVF	SYSWORDTEMPB_H,W
;subwf SysWordTempA_H,W
	SUBWF	SYSWORDTEMPA_H,W
;btfss STATUS,C
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
;goto SCLT16True
	GOTO	SCLT16TRUE
;Test Low, exit if more or equal
;movf SysWordTempB,W
	MOVF	SYSWORDTEMPB,W
;subwf SysWordTempA,W
	SUBWF	SYSWORDTEMPA,W
;btfsc STATUS,C
;B7: ASM Source was:  BTFSC STATUS,C
	BTFSC	STATUS,0
;return
	RETURN
SCLT16TRUE:
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
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

;SOURCE: SYSTEM.H (2712)
SYSDIVSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	MOVF	SYSWORDTEMPA,W
	MOVWF	SYSDIVMULTA
	MOVF	SYSWORDTEMPA_H,W
	MOVWF	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	MOVF	SYSWORDTEMPB,W
	MOVWF	SYSDIVMULTB
	MOVF	SYSWORDTEMPB_H,W
	MOVWF	SYSDIVMULTB_H
;SysDivMultX = 0
	CLRF	SYSDIVMULTX
	CLRF	SYSDIVMULTX_H
;Avoid division by zero
;if SysDivMultB = 0 then
	MOVF	SYSDIVMULTB,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSDIVMULTB_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF41
;SysWordTempA = 0
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
;exit sub
	RETURN
;end if
ENDIF41:
;Main calc routine
;SysDivLoop = 16
	MOVLW	16
	MOVWF	SYSDIVLOOP
SYSDIV16START:
;set C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate SysDivMultA Left
	RLF	SYSDIVMULTA,F
	RLF	SYSDIVMULTA_H,F
;Rotate SysDivMultX Left
	RLF	SYSDIVMULTX,F
	RLF	SYSDIVMULTX_H,F
;SysDivMultX = SysDivMultX - SysDivMultB
	MOVF	SYSDIVMULTB,W
	SUBWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	SUBWFB	SYSDIVMULTX_H,F
;Set SysDivMultA.0 On
	BSF	SYSDIVMULTA,0
;If C Off Then
;B7: ASM Source was:  BTFSC STATUS,C
	BTFSC	STATUS,0
	GOTO	ENDIF42
;Set SysDivMultA.0 Off
	BCF	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	MOVF	SYSDIVMULTB,W
	ADDWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	ADDWFC	SYSDIVMULTX_H,F
;End If
ENDIF42:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv16Start
	GOTO	SYSDIV16START
;SysWordTempA = SysDivMultA
	MOVF	SYSDIVMULTA,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSDIVMULTA_H,W
	MOVWF	SYSWORDTEMPA_H
;SysWordTempX = SysDivMultX
	MOVF	SYSDIVMULTX,W
	MOVWF	SYSWORDTEMPX
	MOVF	SYSDIVMULTX_H,W
	MOVWF	SYSWORDTEMPX_H
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2467)
SYSMULTSUB16:
;dim SysWordTempA as word
;dim SysWordTempB as word
;dim SysWordTempX as word
;dim SysDivMultA as word
;dim SysDivMultB as word
;dim SysDivMultX as word
;SysDivMultA = SysWordTempA
	MOVF	SYSWORDTEMPA,W
	MOVWF	SYSDIVMULTA
	MOVF	SYSWORDTEMPA_H,W
	MOVWF	SYSDIVMULTA_H
;SysDivMultB = SysWordTempB
	MOVF	SYSWORDTEMPB,W
	MOVWF	SYSDIVMULTB
	MOVF	SYSWORDTEMPB_H,W
	MOVWF	SYSDIVMULTB_H
;SysDivMultX = 0
	CLRF	SYSDIVMULTX
	CLRF	SYSDIVMULTX_H
MUL16LOOP:
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	BTFSS	SYSDIVMULTB,0
	GOTO	ENDIF39
	MOVF	SYSDIVMULTA,W
	ADDWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTA_H,W
	ADDWFC	SYSDIVMULTX_H,F
ENDIF39:
;set STATUS.C OFF
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;rotate SysDivMultB right
	RRF	SYSDIVMULTB_H,F
	RRF	SYSDIVMULTB,F
;set STATUS.C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;rotate SysDivMultA left
	RLF	SYSDIVMULTA,F
	RLF	SYSDIVMULTA_H,F
;if SysDivMultB > 0 then goto MUL16LOOP
	MOVF	SYSDIVMULTB,W
	MOVWF	SYSWORDTEMPB
	MOVF	SYSDIVMULTB_H,W
	MOVWF	SYSWORDTEMPB_H
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
	GOTO	MUL16LOOP
;SysWordTempX = SysDivMultX
	MOVF	SYSDIVMULTX,W
	MOVWF	SYSWORDTEMPX
	MOVF	SYSDIVMULTX_H,W
	MOVWF	SYSWORDTEMPX_H
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
	RETLW	97	;A
	RETLW	115	;S
	RETLW	105	;I
	RETLW	99	;C
	RETLW	32	; 
	RETLW	64	;
	RETLW	50	;2
	RETLW	48	;0
	RETLW	49	;1
	RETLW	54	;6

	ALIGN	2;X3

STRINGTABLE2:
	RETLW	17
	RETLW	88	;X
	RETLW	112	;P
	RETLW	114	;R
	RETLW	101	;E
	RETLW	115	;S
	RETLW	115	;S
	RETLW	32	; 
	RETLW	68	;D
	RETLW	101	;E
	RETLW	109	;M
	RETLW	111	;O
	RETLW	32	; 
	RETLW	66	;B
	RETLW	111	;O
	RETLW	97	;A
	RETLW	114	;R
	RETLW	100	;D

	ALIGN	2;X3

STRINGTABLE3:
	RETLW	14
	RETLW	48	;0
	RETLW	57	;9
	RETLW	32	; 
	RETLW	84	;T
	RETLW	101	;E
	RETLW	109	;M
	RETLW	112	;P
	RETLW	101	;E
	RETLW	114	;R
	RETLW	97	;A
	RETLW	116	;T
	RETLW	117	;U
	RETLW	114	;R
	RETLW	101	;E

	ALIGN	2;X3

STRINGTABLE4:
	RETLW	27
	RETLW	80	;P
	RETLW	114	;R
	RETLW	111	;O
	RETLW	100	;D
	RETLW	117	;U
	RETLW	99	;C
	RETLW	116	;T
	RETLW	32	; 
	RETLW	73	;I
	RETLW	68	;D
	RETLW	58	;:
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	69	;E
	RETLW	77	;M
	RETLW	67	;C
	RETLW	49	;1
	RETLW	48	;0
	RETLW	48	;0
	RETLW	49	;1

	ALIGN	2;X3

STRINGTABLE5:
	RETLW	1
	RETLW	45	;-

	ALIGN	2;X3

STRINGTABLE6:
	RETLW	22
	RETLW	77	;M
	RETLW	97	;A
	RETLW	110	;N
	RETLW	117	;U
	RETLW	102	;F
	RETLW	97	;A
	RETLW	99	;C
	RETLW	116	;T
	RETLW	117	;U
	RETLW	114	;R
	RETLW	101	;E
	RETLW	114	;R
	RETLW	32	; 
	RETLW	73	;I
	RETLW	68	;D
	RETLW	58	;:
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	48	;0
	RETLW	120	;X

	ALIGN	2;X3

STRINGTABLE7:
	RETLW	20
	RETLW	82	;R
	RETLW	101	;E
	RETLW	118	;V
	RETLW	105	;I
	RETLW	115	;S
	RETLW	105	;I
	RETLW	111	;O
	RETLW	110	;N
	RETLW	58	;:
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE8:
	RETLW	20
	RETLW	84	;T
	RETLW	104	;H
	RETLW	101	;E
	RETLW	32	; 
	RETLW	116	;T
	RETLW	101	;E
	RETLW	109	;M
	RETLW	112	;P
	RETLW	101	;E
	RETLW	114	;R
	RETLW	97	;A
	RETLW	116	;T
	RETLW	117	;U
	RETLW	114	;R
	RETLW	101	;E
	RETLW	32	; 
	RETLW	105	;I
	RETLW	115	;S
	RETLW	58	;:
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE9:
	RETLW	1
	RETLW	46	;.

	ALIGN	2;X3

STRINGTABLE10:
	RETLW	1
	RETLW	67	;C

	ALIGN	2;X3

STRINGTABLE11:
	RETLW	20
	RETLW	67	;C
	RETLW	111	;O
	RETLW	110	;N
	RETLW	118	;V
	RETLW	101	;E
	RETLW	114	;R
	RETLW	115	;S
	RETLW	105	;I
	RETLW	111	;O
	RETLW	110	;N
	RETLW	32	; 
	RETLW	114	;R
	RETLW	97	;A
	RETLW	116	;T
	RETLW	101	;E
	RETLW	32	; 
	RETLW	105	;I
	RETLW	115	;S
	RETLW	58	;:
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE12:
	RETLW	20
	RETLW	72	;H
	RETLW	105	;I
	RETLW	103	;G
	RETLW	104	;H
	RETLW	32	; 
	RETLW	108	;L
	RETLW	105	;I
	RETLW	109	;M
	RETLW	105	;I
	RETLW	116	;T
	RETLW	32	; 
	RETLW	105	;I
	RETLW	115	;S
	RETLW	58	;:
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE13:
	RETLW	20
	RETLW	76	;L
	RETLW	111	;O
	RETLW	119	;W
	RETLW	32	; 
	RETLW	108	;L
	RETLW	105	;I
	RETLW	109	;M
	RETLW	105	;I
	RETLW	116	;T
	RETLW	32	; 
	RETLW	105	;I
	RETLW	115	;S
	RETLW	58	;:
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE14:
	RETLW	20
	RETLW	83	;S
	RETLW	116	;T
	RETLW	97	;A
	RETLW	116	;T
	RETLW	117	;U
	RETLW	115	;S
	RETLW	32	; 
	RETLW	105	;I
	RETLW	115	;S
	RETLW	58	;:
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 
	RETLW	32	; 

	ALIGN	2;X3

STRINGTABLE47:
	RETLW	0

	ALIGN	2;X3

STRINGTABLE48:
	RETLW	1
	RETLW	49	;1

	ALIGN	2;X3

STRINGTABLE49:
	RETLW	1
	RETLW	48	;0

	ALIGN	2;X3

;********************************************************************************

;SOURCE: PICAS.H (7)
FN__HEXPICAS:
;_HexPICAS(0) = 2
	MOVLW	2
	BANKSEL	SYS_HEXPICAS_0
	MOVWF	SYS_HEXPICAS_0
;dim SysStringTemp as byte
;Low nibble
;SysStringTemp = SysValTemp And 0x0F
	MOVLW	15
	BANKSEL	SYSVALTEMP
	ANDWF	SYSVALTEMP,W
	MOVWF	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	SUBLW	9
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF34
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F
ENDIF34:
;_HexPICAS(2) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W
	BANKSEL	SYS_HEXPICAS_2
	MOVWF	SYS_HEXPICAS_2
;Get high nibble
;For SysStringTemp = 1 to 4
	BANKSEL	SYSSTRINGTEMP
	CLRF	SYSSTRINGTEMP
SYSFORLOOP1:
	INCF	SYSSTRINGTEMP,F
;Rotate SysValTemp Right
	RRF	SYSVALTEMP,F
;Next
	MOVLW	4
	SUBWF	SYSSTRINGTEMP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP1
SYSFORLOOPEND1:
;SysStringTemp = SysValTemp And 0x0F
	MOVLW	15
	ANDWF	SYSVALTEMP,W
	MOVWF	SYSSTRINGTEMP
;If SysStringTemp > 9 Then SysStringTemp = SysStringTemp + 7
	SUBLW	9
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	GOTO	ENDIF36
	MOVLW	7
	ADDWF	SYSSTRINGTEMP,F
ENDIF36:
;_HexPICAS(1) = SysStringTemp + 48
	MOVLW	48
	ADDWF	SYSSTRINGTEMP,W
	BANKSEL	SYS_HEXPICAS_1
	MOVWF	SYS_HEXPICAS_1
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
