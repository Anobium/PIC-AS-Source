;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "C:\temp\New1013.S"
 SUBTITLE    "02-18-2021"

; Reverse lookup file(s)
; C:\Program Files\Microchip\xc8\v2.31\pic\include\proc\pic16f18855.inc
; C:\Program Files\Microchip\xc8\v2.31\pic\dat\cfgmap\16f18855.cfgmap
;
; -mcpu=%ChipModel%  "%Fn_NoExt%.S" -msummary=-mem,+psect,-class,-hex,-file,-sha1,-sha256,-xml,-xmlfull  -Wl -mcallgraph=std -mno-download-hex -o"%Fn_NoExt%.hex"  -Wl,-Map="%Fn_NoExt%.map"
;

 #include <xc.inc>


;********************************************************************************
;Explicit CONFIG
 CONFIG FCMEN=ON                                 ;C1 Reverselookup FCMEN = ON
 CONFIG CLKOUTEN=OFF                             ;C1 Reverselookup CLKOUTEN = OFF
 CONFIG RSTOSC=HFINT32                           ;C1 Reverselookup RSTOSC = HFINT32
 CONFIG FEXTOSC=OFF                              ;C1 Reverselookup FEXTOSC = OFF
 CONFIG MCLRE=OFF                                ;C1 Reverselookup MCLRE = OFF
 CONFIG WDTE=OFF                                 ;C1 Reverselookup WDTE = OFF
 CONFIG LVP=OFF                                  ;C1 Reverselookup LVP = OFF
 CONFIG WRT=OFF                                  ;C1 Reverselookup WRT = OFF
 CONFIG CPD=OFF                                  ;C1 Reverselookup CPD = OFF
 CONFIG CP=OFF                                   ;C1 Reverselookup CP = OFF
;Inferred CONFIG

;********************************************************************************

;Set aside RAM memory locations for variables. All variables are global.
 BYTENUMBER                       EQU 32                    ; 0X20
 CCOUNT                           EQU 33                    ; 0X21
 CHARCODE                         EQU 34                    ; 0X22
 CHARCOL                          EQU 35                    ; 0X23
 CHARCOLS                         EQU 37                    ; 0X25
 CHARCOL_H                        EQU 36                    ; 0X24
 CHARLOCX                         EQU 38                    ; 0X26
 CHARLOCX_H                       EQU 39                    ; 0X27
 CHARLOCY                         EQU 40                    ; 0X28
 CHARLOCY_H                       EQU 41                    ; 0X29
 CHARROW                          EQU 42                    ; 0X2A
 CHARROWS                         EQU 44                    ; 0X2C
 CHARROW_H                        EQU 43                    ; 0X2B
 CHR                              EQU 9030                    ; 0X2346
 COL                              EQU 45                    ; 0X2D
 CURRCHARCOL                      EQU 46                    ; 0X2E
 CURRCHARROW                      EQU 47                    ; 0X2F
 CURRCHARVAL                      EQU 48                    ; 0X30
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 DRAWLINE                         EQU 49                    ; 0X31
 DRAWLINE_H                       EQU 50                    ; 0X32
 GLCDBACKGROUND                   EQU 51                    ; 0X33
 GLCDBACKGROUND_H                 EQU 52                    ; 0X34
 GLCDBITNO                        EQU 53                    ; 0X35
 GLCDCHANGE                       EQU 54                    ; 0X36
 GLCDCOLOUR                       EQU 55                    ; 0X37
 GLCDCOLOUR_H                     EQU 56                    ; 0X38
 GLCDDATATEMP                     EQU 57                    ; 0X39
 GLCDFNTDEFAULT                   EQU 58                    ; 0X3A
 GLCDFNTDEFAULTHEIGHT             EQU 59                    ; 0X3B
 GLCDFNTDEFAULTSIZE               EQU 60                    ; 0X3C
 GLCDFONTWIDTH                    EQU 61                    ; 0X3D
 GLCDFOREGROUND                   EQU 62                    ; 0X3E
 GLCDFOREGROUND_H                 EQU 63                    ; 0X3F
 GLCDPRINTLEN                     EQU 64                    ; 0X40
 GLCDPRINTLOC                     EQU 65                    ; 0X41
 GLCDPRINTLOC_H                   EQU 66                    ; 0X42
 GLCDPRINT_STRING_COUNTER         EQU 67                    ; 0X43
 GLCDTEMP                         EQU 68                    ; 0X44
 GLCDTEMP_H                       EQU 69                    ; 0X45
 GLCDX                            EQU 70                    ; 0X46
 GLCDY                            EQU 71                    ; 0X47
 GLCDY_TEMP                       EQU 72                    ; 0X48
 GLCD_YORDINATE                   EQU 73                    ; 0X49
 GLCD_YORDINATE_H                 EQU 74                    ; 0X4A
 HI2CACKPOLLSTATE                 EQU 75                    ; 0X4B
 HI2CCURRENTMODE                  EQU 76                    ; 0X4C
 HI2CWAITMSSPTIMEOUT              EQU 77                    ; 0X4D
 I2CBYTE                          EQU 78                    ; 0X4E
 INXRADIUS                        EQU 79                    ; 0X4F
 INXRADIUS_H                      EQU 80                    ; 0X50
 LCDVALUE                         EQU 81                    ; 0X51
 LCDVALUE_E                       EQU 84                    ; 0X54
 LCDVALUE_H                       EQU 82                    ; 0X52
 LCDVALUE_U                       EQU 83                    ; 0X53
 LINECOLOUR                       EQU 85                    ; 0X55
 LINECOLOUR_H                     EQU 86                    ; 0X56
 LINEDIFFX                        EQU 87                    ; 0X57
 LINEDIFFX_H                      EQU 88                    ; 0X58
 LINEDIFFX_X2                     EQU 89                    ; 0X59
 LINEDIFFX_X2_H                   EQU 90                    ; 0X5A
 LINEDIFFY                        EQU 91                    ; 0X5B
 LINEDIFFY_H                      EQU 92                    ; 0X5C
 LINEDIFFY_X2                     EQU 93                    ; 0X5D
 LINEDIFFY_X2_H                   EQU 94                    ; 0X5E
 LINEERR                          EQU 95                    ; 0X5F
 LINEERR_H                        EQU 96                    ; 0X60
 LINESTEPX                        EQU 97                    ; 0X61
 LINESTEPX_H                      EQU 98                    ; 0X62
 LINESTEPY                        EQU 99                    ; 0X63
 LINESTEPY_H                      EQU 100                    ; 0X64
 LINEX1                           EQU 101                    ; 0X65
 LINEX1_H                         EQU 102                    ; 0X66
 LINEX2                           EQU 103                    ; 0X67
 LINEX2_H                         EQU 104                    ; 0X68
 LINEY1                           EQU 105                    ; 0X69
 LINEY1_H                         EQU 106                    ; 0X6A
 LINEY2                           EQU 107                    ; 0X6B
 LINEY2_H                         EQU 108                    ; 0X6C
 LOCX                             EQU 109                    ; 0X6D
 LOCY                             EQU 110                    ; 0X6E
 LONGNUMBER                       EQU 160                    ; 0XA0
 LONGNUMBER_E                     EQU 163                    ; 0XA3
 LONGNUMBER_H                     EQU 161                    ; 0XA1
 LONGNUMBER_U                     EQU 162                    ; 0XA2
 OUTSTRING                        EQU 8989                    ; 0X231D
 PAD                              EQU 8948                    ; 0X22F4
 POSCHARX                         EQU 164                    ; 0XA4
 POSCHARX_H                       EQU 165                    ; 0XA5
 POSCHARY                         EQU 111                    ; 0X6F
 PRINTLOCX                        EQU 166                    ; 0XA6
 PRINTLOCX_H                      EQU 167                    ; 0XA7
 PRINTLOCY                        EQU 168                    ; 0XA8
 PRINTLOCY_H                      EQU 169                    ; 0XA9
 RADIUSERR                        EQU 170                    ; 0XAA
 RADIUSERR_H                      EQU 171                    ; 0XAB
 ROW                              EQU 172                    ; 0XAC
 SSD1306SENDBYTE                  EQU 173                    ; 0XAD
 SSD1306_BUFFERALIAS              EQU 9071                    ; 0X236F
 SSD1306_BUFFERLOCATIONCALC       EQU 174                    ; 0XAE
 SSD1306_BUFFERLOCATIONCALC_H     EQU 175                    ; 0XAF
 STRINGLOCX                       EQU 176                    ; 0XB0
 STRINGPOINTER                    EQU 177                    ; 0XB1
 SYSARRAYTEMP1                    EQU 178                    ; 0XB2
 SYSARRAYTEMP2                    EQU 179                    ; 0XB3
 SYSBITVAR0                       EQU 180                    ; 0XB4
 SYSBYTETEMPA                     EQU 117                    ; 0X75
 SYSBYTETEMPB                     EQU 121                    ; 0X79
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSCALCTEMPA                     EQU 117                    ; 0X75
 SYSCALCTEMPA_E                   EQU 120                    ; 0X78
 SYSCALCTEMPA_H                   EQU 118                    ; 0X76
 SYSCALCTEMPA_U                   EQU 119                    ; 0X77
 SYSCHAR                          EQU 181                    ; 0XB5
 SYSCHARCOUNT                     EQU 182                    ; 0XB6
 SYSCHARSHANDLER                  EQU 183                    ; 0XB7
 SYSCHARSHANDLER_H                EQU 184                    ; 0XB8
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSDIVMULTA                      EQU 119                    ; 0X77
 SYSDIVMULTA_H                    EQU 120                    ; 0X78
 SYSDIVMULTB                      EQU 123                    ; 0X7B
 SYSDIVMULTB_H                    EQU 124                    ; 0X7C
 SYSDIVMULTX                      EQU 114                    ; 0X72
 SYSDIVMULTX_H                    EQU 115                    ; 0X73
 SYSINTEGERTEMPA                  EQU 117                    ; 0X75
 SYSINTEGERTEMPA_H                EQU 118                    ; 0X76
 SYSINTEGERTEMPB                  EQU 121                    ; 0X79
 SYSINTEGERTEMPB_H                EQU 122                    ; 0X7A
 SYSINTEGERTEMPX                  EQU 112                    ; 0X70
 SYSINTEGERTEMPX_H                EQU 113                    ; 0X71
 SYSLCDPRINTDATAHANDLER           EQU 185                    ; 0XB9
 SYSLCDPRINTDATAHANDLER_H         EQU 186                    ; 0XBA
 SYSLONGDIVMULTA                  EQU 187                    ; 0XBB
 SYSLONGDIVMULTA_E                EQU 190                    ; 0XBE
 SYSLONGDIVMULTA_H                EQU 188                    ; 0XBC
 SYSLONGDIVMULTA_U                EQU 189                    ; 0XBD
 SYSLONGDIVMULTB                  EQU 191                    ; 0XBF
 SYSLONGDIVMULTB_E                EQU 194                    ; 0XC2
 SYSLONGDIVMULTB_H                EQU 192                    ; 0XC0
 SYSLONGDIVMULTB_U                EQU 193                    ; 0XC1
 SYSLONGDIVMULTX                  EQU 195                    ; 0XC3
 SYSLONGDIVMULTX_E                EQU 198                    ; 0XC6
 SYSLONGDIVMULTX_H                EQU 196                    ; 0XC4
 SYSLONGDIVMULTX_U                EQU 197                    ; 0XC5
 SYSLONGTEMPA                     EQU 117                    ; 0X75
 SYSLONGTEMPA_E                   EQU 120                    ; 0X78
 SYSLONGTEMPA_H                   EQU 118                    ; 0X76
 SYSLONGTEMPA_U                   EQU 119                    ; 0X77
 SYSLONGTEMPB                     EQU 121                    ; 0X79
 SYSLONGTEMPB_E                   EQU 124                    ; 0X7C
 SYSLONGTEMPB_H                   EQU 122                    ; 0X7A
 SYSLONGTEMPB_U                   EQU 123                    ; 0X7B
 SYSLONGTEMPX                     EQU 112                    ; 0X70
 SYSLONGTEMPX_E                   EQU 115                    ; 0X73
 SYSLONGTEMPX_H                   EQU 113                    ; 0X71
 SYSLONGTEMPX_U                   EQU 114                    ; 0X72
 SYSPRINTBUFFER                   EQU 8937                    ; 0X22E9
 SYSPRINTBUFFLEN                  EQU 199                    ; 0XC7
 SYSREPEATTEMP1                   EQU 200                    ; 0XC8
 SYSREPEATTEMP2                   EQU 201                    ; 0XC9
 SYSREPEATTEMP4                   EQU 202                    ; 0XCA
 SYSSIGNBYTE                      EQU 125                    ; 0X7D
 SYSSTRINGA                       EQU 119                    ; 0X77
 SYSSTRINGA_H                     EQU 120                    ; 0X78
 SYSSTRINGLENGTH                  EQU 118                    ; 0X76
 SYSSTRINGPARAM1                  EQU 288                    ; 0X120
 SYSSTRINGTEMP                    EQU 203                    ; 0XCB
 SYSSTRLEN                        EQU 204                    ; 0XCC
 SYSSYSINSTRING3HANDLER           EQU 205                    ; 0XCD
 SYSSYSINSTRING3HANDLER_H         EQU 206                    ; 0XCE
 SYSSYSINSTRINGHANDLER            EQU 207                    ; 0XCF
 SYSSYSINSTRINGHANDLER_H          EQU 208                    ; 0XD0
 SYSTEMP1                         EQU 209                    ; 0XD1
 SYSTEMP1_E                       EQU 212                    ; 0XD4
 SYSTEMP1_H                       EQU 210                    ; 0XD2
 SYSTEMP1_U                       EQU 211                    ; 0XD3
 SYSTEMP2                         EQU 213                    ; 0XD5
 SYSTEMP2_H                       EQU 214                    ; 0XD6
 SYSTEMP3                         EQU 215                    ; 0XD7
 SYSTEMP3_H                       EQU 216                    ; 0XD8
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 SYSWAITTEMPS                     EQU 116                    ; 0X74
 SYSWORDTEMPA                     EQU 117                    ; 0X75
 SYSWORDTEMPA_H                   EQU 118                    ; 0X76
 SYSWORDTEMPB                     EQU 121                    ; 0X79
 SYSWORDTEMPB_H                   EQU 122                    ; 0X7A
 SYSWORDTEMPX                     EQU 112                    ; 0X70
 SYSWORDTEMPX_H                   EQU 113                    ; 0X71
 WORDNUMBER                       EQU 217                    ; 0XD9
 WORDNUMBER_H                     EQU 218                    ; 0XDA
 XCHAR                            EQU 219                    ; 0XDB
 XOFFSET                          EQU 220                    ; 0XDC
 XOFFSET_H                        EQU 221                    ; 0XDD
 XRADIUS                          EQU 222                    ; 0XDE
 XRADIUS_H                        EQU 223                    ; 0XDF
 YOFFSET                          EQU 224                    ; 0XE0
 YOFFSET_H                        EQU 225                    ; 0XE1
 YORDINATE                        EQU 226                    ; 0XE2
 _GLCDPAGE                        EQU 227                    ; 0XE3

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 4
 AFSR0_H                          EQU 5
 SYSCHR_0                         EQU 1350
 SYSCHR_1                         EQU 1351
 SYSPAD_0                         EQU 1220

;********************************************************************************

 PSECT   code,delta=2, abs, global, class=CODE,  space=SPACE_CODE
 GLOBAL RESETVEC
 RESETVEC:
;VECTORS
	ORG	0
	PAGESEL	BASPROGRAMSTART
	LJMP	BASPROGRAMSTART
	ORG	4
	RETFIE

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 0
ORG	5
GLOBAL	BASPROGRAMSTART
BASPROGRAMSTART:
;CALL INITIALISATION ROUTINES
	FCALL	INITSYS
	FCALL	INITPPS
	FCALL	HI2CINIT
	FCALL	INITGLCD_SSD1306
	PAGESEL	$

;START OF THE MAIN PROGRAM
;''
;''******************************************************************
;''
;''
;''
;''  PIC: 16F18855
;''  Compiler: GCB
;''  IDE: GCB@SYN
;----- Configuration
;Chip Settings.
;Set the PPS of the PWM and the RS232 ports.
;Set the PPS for this solution.
;#define SWITCH_DOWN         0
;#define SWITCH_UP           1
;#define SWITCH      PORTA.5
;#define USART_BAUD_RATE 19200
;#define USART_TX_BLOCKING
;#define sync SYNC_TX1STA
;----- Define Hardware settings for hwi2c
;Define I2C settings - CHANGE PORTS if required for your specific device.
;#define hi2c_BAUD_RATE 400
;#define hi2c_DATA PORTC.3
;#define hi2c_CLOCK PORTC.4
;Initialise I2C Master
;I2C pins need to be input for SSP2 module
;Dir hi2c_DATA in
	BSF	TRISC,3
;Dir hi2c_CLOCK in
	BSF	TRISC,4
;hi2cMode Master
	MOVLW	12
	MOVWF	HI2CCURRENTMODE
	PAGESEL	HI2CMODE
	FCALL	HI2CMODE
	PAGESEL	$
;*****************************************************************************************************
;Main program commences here.. everything before this is setup for the board.
;#DEFINE GLCD_TYPE GLCD_TYPE_SSD1306
;#DEFINE GLCD_I2C_Address 0x78
;----- Define variables
;These constants allow you to change the GLCD memory usage.
;We have set this demonstration to use only 128bytes of RAM for GLCD operations.
;#DEFINE GLCD_TYPE_SSD1306_LOWMEMORY_GLCD_MODE
;#DEFINE GLCD_TYPE_SSD1306_CHARACTER_MODE_ONLY
;#DEFINE IGNORE_GLCD_TYPE_SSD1306_LOW_MEMORY_WARNINGS
;#DEFINE GLCD_PROTECTOVERRUN
;Dim BYTENUMBER, CCOUNT As Byte
;CCount = 0
	CLRF	CCOUNT
;Dim longNumber As Long
;max value = 4294967290
;longNumber = 0
	BANKSEL	LONGNUMBER
	CLRF	LONGNUMBER
	CLRF	LONGNUMBER_H
	CLRF	LONGNUMBER_U
	CLRF	LONGNUMBER_E
;Dim wordNumber, adcval, ldrval As Word
;Dim outstring As String
;wordNumber = 0
	CLRF	WORDNUMBER
	CLRF	WORDNUMBER_H
;byteNumber = 0
	BANKSEL	BYTENUMBER
	CLRF	BYTENUMBER
;----- Main program
;GLCD_Open_PageTransaction 0,7
;Macro Source: glcd_ssd1306.h (1172)
;dim _GLCDPage as byte
;Clear buffer
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	MOVLW	255
	BANKSEL	_GLCDPAGE
	MOVWF	_GLCDPAGE
GLOBAL	SYSFORLOOP1
SYSFORLOOP1:
	INCF	_GLCDPAGE,F
;GLCDPrint 0, 0,   "Great Cow BASIC"
	CLRF	PRINTLOCX
	CLRF	PRINTLOCX_H
	CLRF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE1
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE1) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
BANKSEL	STATUS
	PAGESEL	GLCDPRINT32
	FCALL	GLCDPRINT32
	PAGESEL	$
;GLCDPrint (0, 16, "Anobium 2021")
	BANKSEL	PRINTLOCX
	CLRF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	16
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE2
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE2) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
BANKSEL	STATUS
	PAGESEL	GLCDPRINT32
	FCALL	GLCDPRINT32
	PAGESEL	$
;GLCDPrint (76, 16, GLCD_WIDTH )
	MOVLW	76
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	16
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	128
	BANKSEL	LCDVALUE
	MOVWF	LCDVALUE
	CLRF	LCDVALUE_H
	CLRF	LCDVALUE_U
	CLRF	LCDVALUE_E
	PAGESEL	GLCDPRINT35
	FCALL	GLCDPRINT35
	PAGESEL	$
;GLCDPrint (96, 16, "*" )
	MOVLW	96
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	16
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE3
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE3) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
BANKSEL	STATUS
	PAGESEL	GLCDPRINT32
	FCALL	GLCDPRINT32
	PAGESEL	$
;GLCDPrint (104, 16, GLCD_HEIGHT )
	MOVLW	104
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	16
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	64
	BANKSEL	LCDVALUE
	MOVWF	LCDVALUE
	CLRF	LCDVALUE_H
	CLRF	LCDVALUE_U
	CLRF	LCDVALUE_E
	PAGESEL	GLCDPRINT35
	FCALL	GLCDPRINT35
	PAGESEL	$
;GLCD_Close_PageTransaction
;Macro Source: glcd_ssd1306.h (1184)
;Set cursor position
;Cursor_Position_SSD1306 ( 0, 8 * _GLCDPage )
	CLRF	LOCX
	BANKSEL	_GLCDPAGE
	MOVF	_GLCDPAGE,W
	MOVWF	SYSBYTETEMPA
	MOVLW	8
	MOVWF	SYSBYTETEMPB
BANKSEL	STATUS
	PAGESEL	SYSMULTSUB
	FCALL	SYSMULTSUB
	PAGESEL	$
	MOVF	SYSBYTETEMPX,W
	MOVWF	LOCY
	PAGESEL	CURSOR_POSITION_SSD1306
	FCALL	CURSOR_POSITION_SSD1306
	PAGESEL	$
;Send the buffer to the device using transaction
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1210)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	PAGESEL	HI2CSTART
	FCALL	HI2CSTART
	PAGESEL	$
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE
	PAGESEL	HI2CSEND
	FCALL	HI2CSEND
	PAGESEL	$
;HI2CSend 0x40
	MOVLW	64
	MOVWF	I2CBYTE
	PAGESEL	HI2CSEND
	FCALL	HI2CSEND
	PAGESEL	$
;for SSD1306_BufferLocationCalc = 1 to 128
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC_H
GLOBAL	SYSFORLOOP2
SYSFORLOOP2:
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	INCF	SSD1306_BUFFERLOCATIONCALC,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F
;Write_Transaction_Data_SSD1306 SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
;Macro Source: glcd_ssd1306.h (1241)
;HI2CSend SSD1306SendByte
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	PAGESEL	HI2CSEND
	FCALL	HI2CSEND
	PAGESEL	$
;Clear the buffer byte. We need it to be empty for the next page operation
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
CLRF	INDF0
;next
	MOVF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	SYSWORDTEMPA
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	128
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
BANKSEL	STATUS
	PAGESEL	SYSCOMPLESSTHAN16
	FCALL	SYSCOMPLESSTHAN16
	PAGESEL	$
	BTFSC	SYSBYTETEMPX,0
	LJMP	SYSFORLOOP2
GLOBAL	SYSFORLOOPEND2
SYSFORLOOPEND2:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1274)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	PAGESEL	HI2CSTOP
	FCALL	HI2CSTOP
	PAGESEL	$
;next
	MOVLW	7
	BANKSEL	_GLCDPAGE
	SUBWF	_GLCDPAGE,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOP1
GLOBAL	SYSFORLOOPEND1
SYSFORLOOPEND1:
;Wait 3 s
	MOVLW	3
	MOVWF	SYSWAITTEMPS
BANKSEL	STATUS
	PAGESEL	DELAY_S
	FCALL	DELAY_S
;GLCDCLS
	PAGESEL	GLCDCLS_SSD1306
	FCALL	GLCDCLS_SSD1306
	PAGESEL	$
;GLCD_Open_PageTransaction 0, 7
;Macro Source: glcd_ssd1306.h (1172)
;dim _GLCDPage as byte
;Clear buffer
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	MOVLW	255
	BANKSEL	_GLCDPAGE
	MOVWF	_GLCDPAGE
GLOBAL	SYSFORLOOP3
SYSFORLOOP3:
	INCF	_GLCDPAGE,F
;GLCDPrint 0, 0,   "Version 0.98.07"
	CLRF	PRINTLOCX
	CLRF	PRINTLOCX_H
	CLRF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE4
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE4) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
BANKSEL	STATUS
	PAGESEL	GLCDPRINT32
	FCALL	GLCDPRINT32
	PAGESEL	$
;GLCDPrint (0, 16, "LM GLCD MODE")
	BANKSEL	PRINTLOCX
	CLRF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	16
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE5
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE5) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
BANKSEL	STATUS
	PAGESEL	GLCDPRINT32
	FCALL	GLCDPRINT32
	PAGESEL	$
;GLCDPrint (0, 32, "GLCD_Buffer=128 bytes" )
	BANKSEL	PRINTLOCX
	CLRF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	32
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE6
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE6) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
BANKSEL	STATUS
	PAGESEL	GLCDPRINT32
	FCALL	GLCDPRINT32
	PAGESEL	$
;GLCD_Close_PageTransaction
;Macro Source: glcd_ssd1306.h (1184)
;Set cursor position
;Cursor_Position_SSD1306 ( 0, 8 * _GLCDPage )
	CLRF	LOCX
	BANKSEL	_GLCDPAGE
	MOVF	_GLCDPAGE,W
	MOVWF	SYSBYTETEMPA
	MOVLW	8
	MOVWF	SYSBYTETEMPB
BANKSEL	STATUS
	PAGESEL	SYSMULTSUB
	FCALL	SYSMULTSUB
	PAGESEL	$
	MOVF	SYSBYTETEMPX,W
	MOVWF	LOCY
	PAGESEL	CURSOR_POSITION_SSD1306
	FCALL	CURSOR_POSITION_SSD1306
	PAGESEL	$
;Send the buffer to the device using transaction
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1210)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	PAGESEL	HI2CSTART
	FCALL	HI2CSTART
	PAGESEL	$
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE
	PAGESEL	HI2CSEND
	FCALL	HI2CSEND
	PAGESEL	$
;HI2CSend 0x40
	MOVLW	64
	MOVWF	I2CBYTE
	PAGESEL	HI2CSEND
	FCALL	HI2CSEND
	PAGESEL	$
;for SSD1306_BufferLocationCalc = 1 to 128
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC_H
GLOBAL	SYSFORLOOP4
SYSFORLOOP4:
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	INCF	SSD1306_BUFFERLOCATIONCALC,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F
;Write_Transaction_Data_SSD1306 SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
;Macro Source: glcd_ssd1306.h (1241)
;HI2CSend SSD1306SendByte
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	PAGESEL	HI2CSEND
	FCALL	HI2CSEND
	PAGESEL	$
;Clear the buffer byte. We need it to be empty for the next page operation
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
CLRF	INDF0
;next
	MOVF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	SYSWORDTEMPA
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	128
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
BANKSEL	STATUS
	PAGESEL	SYSCOMPLESSTHAN16
	FCALL	SYSCOMPLESSTHAN16
	PAGESEL	$
	BTFSC	SYSBYTETEMPX,0
	LJMP	SYSFORLOOP4
GLOBAL	SYSFORLOOPEND4
SYSFORLOOPEND4:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1274)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	PAGESEL	HI2CSTOP
	FCALL	HI2CSTOP
	PAGESEL	$
;next
	MOVLW	7
	BANKSEL	_GLCDPAGE
	SUBWF	_GLCDPAGE,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOP3
GLOBAL	SYSFORLOOPEND3
SYSFORLOOPEND3:
;Wait 3 s
	MOVLW	3
	MOVWF	SYSWAITTEMPS
BANKSEL	STATUS
	PAGESEL	DELAY_S
	FCALL	DELAY_S
;GLCDCLS
	PAGESEL	GLCDCLS_SSD1306
	FCALL	GLCDCLS_SSD1306
	PAGESEL	$
;GLCDLoop
	FCALL	GLCDLOOP
;End
	LJMP	BASPROGRAMEND
;asm showdebug  GLCD SSD1306 buffer is 128bytes
;#DEFINE DO_SH1106         GLCD_DO
;#DEFINE SCK_SH1106        GLCD_SCK
;#DEFINE DC_SH1106         GLCD_DC
;#DEFINE CS_SH1106         GLCD_CS
;#DEFINE RESET_SH1106      GLCD_RESET
GLOBAL	BASPROGRAMEND
BASPROGRAMEND:
	SLEEP
	LJMP	BASPROGRAMEND

;********************************************************************************

;SOURCE: GLCD.H (1442)
GLOBAL	BOX
BOX:
;dim GLCDTemp as word
;Make sure that starting point (1) is always less than end point (2)
;If LineX1 > LineX2 Then
	MOVF	LINEX1,W
	MOVWF	SYSWORDTEMPB
	MOVF	LINEX1_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVF	LINEX2,W
	MOVWF	SYSWORDTEMPA
	MOVF	LINEX2_H,W
	MOVWF	SYSWORDTEMPA_H
	PAGESEL	SYSCOMPLESSTHAN16
	FCALL	SYSCOMPLESSTHAN16
	PAGESEL	$
	BTFSS	SYSBYTETEMPX,0
	LJMP	ENDIF30
;GLCDTemp = LineX1
	MOVF	LINEX1,W
	MOVWF	GLCDTEMP
	MOVF	LINEX1_H,W
	MOVWF	GLCDTEMP_H
;LineX1 = LineX2
	MOVF	LINEX2,W
	MOVWF	LINEX1
	MOVF	LINEX2_H,W
	MOVWF	LINEX1_H
;LineX2 = GLCDTemp
	MOVF	GLCDTEMP,W
	MOVWF	LINEX2
	MOVF	GLCDTEMP_H,W
	MOVWF	LINEX2_H
;End If
GLOBAL	ENDIF30
ENDIF30:
;If LineY1 > LineY2 Then
	MOVF	LINEY1,W
	MOVWF	SYSWORDTEMPB
	MOVF	LINEY1_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVF	LINEY2,W
	MOVWF	SYSWORDTEMPA
	MOVF	LINEY2_H,W
	MOVWF	SYSWORDTEMPA_H
	PAGESEL	SYSCOMPLESSTHAN16
	FCALL	SYSCOMPLESSTHAN16
	PAGESEL	$
	BTFSS	SYSBYTETEMPX,0
	LJMP	ENDIF31
;GLCDTemp = LineY1
	MOVF	LINEY1,W
	MOVWF	GLCDTEMP
	MOVF	LINEY1_H,W
	MOVWF	GLCDTEMP_H
;LineY1 = LineY2
	MOVF	LINEY2,W
	MOVWF	LINEY1
	MOVF	LINEY2_H,W
	MOVWF	LINEY1_H
;LineY2 = GLCDTemp
	MOVF	GLCDTEMP,W
	MOVWF	LINEY2
	MOVF	GLCDTEMP_H,W
	MOVWF	LINEY2_H
;End If
GLOBAL	ENDIF31
ENDIF31:
;dim DrawLine as word
;Draw lines going across
;For DrawLine = LineX1 To LineX2
	MOVLW	1
	SUBWF	LINEX1,W
	MOVWF	DRAWLINE
	MOVLW	0
	SUBWFB	LINEX1_H,W
	MOVWF	DRAWLINE_H
	MOVF	LINEX1,W
	MOVWF	SYSWORDTEMPB
	MOVF	LINEX1_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVF	LINEX2,W
	MOVWF	SYSWORDTEMPA
	MOVF	LINEX2_H,W
	MOVWF	SYSWORDTEMPA_H
	PAGESEL	SYSCOMPLESSTHAN16
	FCALL	SYSCOMPLESSTHAN16
	PAGESEL	$
	BTFSC	SYSBYTETEMPX,0
	LJMP	SYSFORLOOPEND11
GLOBAL	SYSFORLOOP11
SYSFORLOOP11:
	INCF	DRAWLINE,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	DRAWLINE_H,F
;PSet DrawLine, LineY1, LineColour
	MOVF	DRAWLINE,W
	MOVWF	GLCDX
	MOVF	LINEY1,W
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;PSet DrawLine, LineY2, LineColour
	MOVF	DRAWLINE,W
	MOVWF	GLCDX
	MOVF	LINEY2,W
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;Next
	MOVF	DRAWLINE,W
	MOVWF	SYSWORDTEMPA
	MOVF	DRAWLINE_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVF	LINEX2,W
	MOVWF	SYSWORDTEMPB
	MOVF	LINEX2_H,W
	MOVWF	SYSWORDTEMPB_H
	PAGESEL	SYSCOMPLESSTHAN16
	FCALL	SYSCOMPLESSTHAN16
	PAGESEL	$
	BTFSC	SYSBYTETEMPX,0
	LJMP	SYSFORLOOP11
GLOBAL	SYSFORLOOPEND11
SYSFORLOOPEND11:
;Draw lines going down
;For DrawLine = LineY1 To LineY2
	MOVLW	1
	SUBWF	LINEY1,W
	MOVWF	DRAWLINE
	MOVLW	0
	SUBWFB	LINEY1_H,W
	MOVWF	DRAWLINE_H
	MOVF	LINEY1,W
	MOVWF	SYSWORDTEMPB
	MOVF	LINEY1_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVF	LINEY2,W
	MOVWF	SYSWORDTEMPA
	MOVF	LINEY2_H,W
	MOVWF	SYSWORDTEMPA_H
	PAGESEL	SYSCOMPLESSTHAN16
	FCALL	SYSCOMPLESSTHAN16
	PAGESEL	$
	BTFSC	SYSBYTETEMPX,0
	LJMP	SYSFORLOOPEND12
GLOBAL	SYSFORLOOP12
SYSFORLOOP12:
	INCF	DRAWLINE,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	DRAWLINE_H,F
;PSet LineX1, DrawLine, LineColour
	MOVF	LINEX1,W
	MOVWF	GLCDX
	MOVF	DRAWLINE,W
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;PSet LineX2, DrawLine, LineColour
	MOVF	LINEX2,W
	MOVWF	GLCDX
	MOVF	DRAWLINE,W
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;Next
	MOVF	DRAWLINE,W
	MOVWF	SYSWORDTEMPA
	MOVF	DRAWLINE_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVF	LINEY2,W
	MOVWF	SYSWORDTEMPB
	MOVF	LINEY2_H,W
	MOVWF	SYSWORDTEMPB_H
	PAGESEL	SYSCOMPLESSTHAN16
	FCALL	SYSCOMPLESSTHAN16
	PAGESEL	$
	BTFSC	SYSBYTETEMPX,0
	LJMP	SYSFORLOOP12
GLOBAL	SYSFORLOOPEND12
SYSFORLOOPEND12:
	RETURN

;********************************************************************************

;SOURCE: GLCD.H (1489)
GLOBAL	CIRCLE
CIRCLE:
;dim  radiusErr, xradius as Integer
;xradius = Inxradius
	MOVF	INXRADIUS,W
	BANKSEL	XRADIUS
	MOVWF	XRADIUS
	BANKSEL	INXRADIUS_H
	MOVF	INXRADIUS_H,W
	BANKSEL	XRADIUS_H
	MOVWF	XRADIUS_H
;radiusErr = -(xradius/2)
	MOVF	XRADIUS,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	XRADIUS_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVLW	2
	MOVWF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
BANKSEL	STATUS
	PAGESEL	SYSDIVSUBINT
	FCALL	SYSDIVSUBINT
	PAGESEL	$
	MOVF	SYSINTEGERTEMPA,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	MOVF	SYSINTEGERTEMPA_H,W
	MOVWF	SYSTEMP1_H
	COMF	SYSTEMP1,W
	MOVWF	RADIUSERR
	COMF	SYSTEMP1_H,W
	MOVWF	RADIUSERR_H
	INCF	RADIUSERR,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	RADIUSERR_H,F
;Do While xradius >=  yordinate
GLOBAL	SYSDOLOOP_S3
SYSDOLOOP_S3:
	MOVF	XRADIUS,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	XRADIUS_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVF	YORDINATE,W
	MOVWF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
BANKSEL	STATUS
	PAGESEL	SYSCOMPLESSTHANINT
	FCALL	SYSCOMPLESSTHANINT
	PAGESEL	$
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	LJMP	SYSDOLOOP_E3
;Pset ((xoffset + xradius), (yoffset + yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	ADDWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	ADDWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;Pset ((xoffset + yordinate), (yoffset + xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	ADDWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	ADDWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;Pset ((xoffset - xradius), (yoffset + yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	SUBWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	ADDWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;Pset ((xoffset - yordinate), (yoffset + xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	SUBWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	ADDWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;Pset ((xoffset - xradius), (yoffset - yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	SUBWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	SUBWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;Pset ((xoffset - yordinate), (yoffset - xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	SUBWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	SUBWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;Pset ((xoffset + xradius), (yoffset - yordinate), LineColour)
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	ADDWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	SUBWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;Pset ((xoffset + yordinate), (yoffset - xradius), LineColour)
	BANKSEL	YORDINATE
	MOVF	YORDINATE,W
	ADDWF	XOFFSET,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	BANKSEL	XRADIUS
	MOVF	XRADIUS,W
	SUBWF	YOFFSET,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;yordinate ++
	BANKSEL	YORDINATE
	INCF	YORDINATE,F
;If radiusErr < 0 Then
	MOVF	RADIUSERR,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	RADIUSERR_H,W
	MOVWF	SYSINTEGERTEMPA_H
	CLRF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
BANKSEL	STATUS
	PAGESEL	SYSCOMPLESSTHANINT
	FCALL	SYSCOMPLESSTHANINT
	PAGESEL	$
	BTFSS	SYSBYTETEMPX,0
	LJMP	ELSE36_1
;radiusErr = radiusErr + 2 * yordinate + 1
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
	BANKSEL	YORDINATE
	RLF	YORDINATE,W
	MOVWF	SYSTEMP1
	ADDWF	RADIUSERR,W
	MOVWF	SYSTEMP2
	MOVLW	0
	ADDWFC	RADIUSERR_H,W
	MOVWF	SYSTEMP2_H
	MOVLW	1
	ADDWF	SYSTEMP2,W
	MOVWF	RADIUSERR
	MOVLW	0
	ADDWFC	SYSTEMP2_H,W
	MOVWF	RADIUSERR_H
;else
	LJMP	ENDIF36
GLOBAL	ELSE36_1
ELSE36_1:
;xradius --
	MOVLW	1
	BANKSEL	XRADIUS
	SUBWF	XRADIUS,F
	MOVLW	0
	SUBWFB	XRADIUS_H,F
;radiusErr = radiusErr + 2 * (yordinate - xradius + 1)
	MOVF	XRADIUS,W
	SUBWF	YORDINATE,W
	MOVWF	SYSTEMP2
	CLRF	SYSTEMP1
	MOVF	XRADIUS_H,W
	SUBWFB	SYSTEMP1,W
	MOVWF	SYSTEMP2_H
	MOVLW	1
	ADDWF	SYSTEMP2,W
	MOVWF	SYSTEMP3
	MOVLW	0
	ADDWFC	SYSTEMP2_H,W
	MOVWF	SYSTEMP3_H
	MOVF	SYSTEMP3,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	SYSTEMP3_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVLW	2
	MOVWF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
BANKSEL	STATUS
	PAGESEL	SYSMULTSUBINT
	FCALL	SYSMULTSUBINT
	PAGESEL	$
	MOVF	SYSINTEGERTEMPX,W
	BANKSEL	RADIUSERR
	ADDWF	RADIUSERR,F
	MOVF	SYSINTEGERTEMPX_H,W
	ADDWFC	RADIUSERR_H,F
;end if
GLOBAL	ENDIF36
ENDIF36:
;Loop
	LJMP	SYSDOLOOP_S3
GLOBAL	SYSDOLOOP_E3
SYSDOLOOP_E3:
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (467)
GLOBAL	GLCDDRAWCHAR_SSD1306
GLCDDRAWCHAR_SSD1306:
;This is now in four parts
;1. Handler for GLCD LM mode
;2. Preamble
;3. GCB Font set handler
;4. OLED Font set handler
;***** Handler for GLCD LM mode
;if GLCDfntDefaultSize = 1 then
	DECF	GLCDFNTDEFAULTSIZE,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	LJMP	ENDIF41
;test if character lies within current page
;GLCDY_Temp = CharLocY + 7
	MOVLW	7
	ADDWF	CHARLOCY,W
	MOVWF	GLCDY_TEMP
;Repeat 3
	MOVLW	3
	BANKSEL	SYSREPEATTEMP1
	MOVWF	SYSREPEATTEMP1
GLOBAL	SYSREPEATLOOP1
SYSREPEATLOOP1:
;Set C Off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate GLCDY_Temp Right
	BANKSEL	GLCDY_TEMP
	RRF	GLCDY_TEMP,F
;End Repeat
	BANKSEL	SYSREPEATTEMP1
	DECFSZ	SYSREPEATTEMP1,F
	LJMP	SYSREPEATLOOP1
GLOBAL	SYSREPEATLOOPEND1
SYSREPEATLOOPEND1:
;IF GLCDY_Temp <> _GLCDPage THEN
	MOVF	_GLCDPAGE,W
	BANKSEL	GLCDY_TEMP
	SUBWF	GLCDY_TEMP,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	LJMP	ENDIF52
;GLCDY_Temp = GLCDY_Temp - 1
	DECF	GLCDY_TEMP,F
;IF GLCDY_Temp <> _GLCDPage THEN
	BANKSEL	_GLCDPAGE
	MOVF	_GLCDPAGE,W
	BANKSEL	GLCDY_TEMP
	SUBWF	GLCDY_TEMP,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;EXIT SUB
	RETURN
;END IF
;END IF
GLOBAL	ENDIF52
ENDIF52:
;end if
GLOBAL	ENDIF41
ENDIF41:
;****** Preamble
;invert colors if required
;if LineColour <> GLCDForeground  then
	MOVF	LINECOLOUR,W
	MOVWF	SYSWORDTEMPA
	MOVF	LINECOLOUR_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVF	GLCDFOREGROUND,W
	MOVWF	SYSWORDTEMPB
	MOVF	GLCDFOREGROUND_H,W
	MOVWF	SYSWORDTEMPB_H
	PAGESEL	SYSCOMPEQUAL16
	FCALL	SYSCOMPEQUAL16
	PAGESEL	$
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	LJMP	ENDIF42
;Inverted Colours
;GLCDBackground = 1
	MOVLW	1
	MOVWF	GLCDBACKGROUND
	CLRF	GLCDBACKGROUND_H
;GLCDForeground = 0
	CLRF	GLCDFOREGROUND
	CLRF	GLCDFOREGROUND_H
;end if
GLOBAL	ENDIF42
ENDIF42:
;dim CharCol, CharRow as word
;CharCode -= 15
	MOVLW	15
	SUBWF	CHARCODE,F
;CharCol=0
	CLRF	CHARCOL
	CLRF	CHARCOL_H
;Cursor_Position_SSD1306 ( CharLocX , CharLocY )
	MOVF	CHARLOCX,W
	MOVWF	LOCX
	MOVF	CHARLOCY,W
	MOVWF	LOCY
	PAGESEL	CURSOR_POSITION_SSD1306
	FCALL	CURSOR_POSITION_SSD1306
	PAGESEL	$
;1.14 Added transaction
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1210)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	PAGESEL	HI2CSTART
	FCALL	HI2CSTART
	PAGESEL	$
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE
	PAGESEL	HI2CSEND
	FCALL	HI2CSEND
	PAGESEL	$
;HI2CSend 0x40
	MOVLW	64
	MOVWF	I2CBYTE
	PAGESEL	HI2CSEND
	FCALL	HI2CSEND
	PAGESEL	$
;****** GCB Font set handler
;if CharCode>=178 and CharCode<=202 then
	MOVF	CHARCODE,W
	MOVWF	SYSBYTETEMPA
	MOVLW	178
	MOVWF	SYSBYTETEMPB
	PAGESEL	SYSCOMPLESSTHAN
	FCALL	SYSCOMPLESSTHAN
	PAGESEL	$
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	BANKSEL	CHARCODE
	MOVF	CHARCODE,W
	MOVWF	SYSBYTETEMPB
	MOVLW	202
	MOVWF	SYSBYTETEMPA
	PAGESEL	SYSCOMPLESSTHAN
	FCALL	SYSCOMPLESSTHAN
	PAGESEL	$
	COMF	SYSBYTETEMPX,F
	BANKSEL	SYSTEMP1
	MOVF	SYSTEMP1,W
	ANDWF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP2
	BTFSS	SYSTEMP2,0
	LJMP	ENDIF43
;CharLocY=CharLocY-1
	MOVLW	1
	BANKSEL	CHARLOCY
	SUBWF	CHARLOCY,F
	MOVLW	0
	SUBWFB	CHARLOCY_H,F
;end if
GLOBAL	ENDIF43
ENDIF43:
;For CurrCharCol = 1 to 5
	BANKSEL	CURRCHARCOL
	CLRF	CURRCHARCOL
GLOBAL	SYSFORLOOP16
SYSFORLOOP16:
	INCF	CURRCHARCOL,F
;Select Case CurrCharCol
;Case 1: ReadTable GLCDCharCol3, CharCode, CurrCharVal
GLOBAL	SYSSELECT1CASE1
SYSSELECT1CASE1:
	DECF	CURRCHARCOL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	LJMP	SYSSELECT1CASE2
	MOVF	CHARCODE,W
	MOVWF	SYSSTRINGA
	PAGESEL	GLCDCHARCOL3
	FCALL	GLCDCHARCOL3
	PAGESEL	$
	MOVWF	CURRCHARVAL
;Case 2: ReadTable GLCDCharCol4, CharCode, CurrCharVal
	LJMP	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE2
SYSSELECT1CASE2:
	MOVLW	2
	SUBWF	CURRCHARCOL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	LJMP	SYSSELECT1CASE3
	MOVF	CHARCODE,W
	MOVWF	SYSSTRINGA
	PAGESEL	GLCDCHARCOL4
	FCALL	GLCDCHARCOL4
	PAGESEL	$
	MOVWF	CURRCHARVAL
;Case 3: ReadTable GLCDCharCol5, CharCode, CurrCharVal
	LJMP	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE3
SYSSELECT1CASE3:
	MOVLW	3
	SUBWF	CURRCHARCOL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	LJMP	SYSSELECT1CASE4
	MOVF	CHARCODE,W
	MOVWF	SYSSTRINGA
	PAGESEL	GLCDCHARCOL5
	FCALL	GLCDCHARCOL5
	PAGESEL	$
	MOVWF	CURRCHARVAL
;Case 4: ReadTable GLCDCharCol6, CharCode, CurrCharVal
	LJMP	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE4
SYSSELECT1CASE4:
	MOVLW	4
	SUBWF	CURRCHARCOL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	LJMP	SYSSELECT1CASE5
	MOVF	CHARCODE,W
	MOVWF	SYSSTRINGA
	PAGESEL	GLCDCHARCOL6
	FCALL	GLCDCHARCOL6
	PAGESEL	$
	MOVWF	CURRCHARVAL
;Case 5: ReadTable GLCDCharCol7, CharCode, CurrCharVal
	LJMP	SYSSELECTEND1
GLOBAL	SYSSELECT1CASE5
SYSSELECT1CASE5:
	MOVLW	5
	SUBWF	CURRCHARCOL,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	LJMP	SYSSELECTEND1
	MOVF	CHARCODE,W
	MOVWF	SYSSTRINGA
	PAGESEL	GLCDCHARCOL7
	FCALL	GLCDCHARCOL7
	PAGESEL	$
	MOVWF	CURRCHARVAL
;End Select
GLOBAL	SYSSELECTEND1
SYSSELECTEND1:
;Full Memory GLCD mode
;1.14 Low Memory GLCD mode
;CharRow=0
	CLRF	CHARROW
	CLRF	CHARROW_H
;For CurrCharRow = 1 to 8
	CLRF	CURRCHARROW
GLOBAL	SYSFORLOOP17
SYSFORLOOP17:
	INCF	CURRCHARROW,F
;CharColS=0
	CLRF	CHARCOLS
;For Col=1 to GLCDfntDefaultsize
	CLRF	COL
	MOVLW	1
	SUBWF	GLCDFNTDEFAULTSIZE,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOPEND18
GLOBAL	SYSFORLOOP18
SYSFORLOOP18:
	INCF	COL,F
;CharRowS=0
	CLRF	CHARROWS
;For Row=1 to GLCDfntDefaultsize
	BANKSEL	ROW
	CLRF	ROW
	MOVLW	1
	BANKSEL	GLCDFNTDEFAULTSIZE
	SUBWF	GLCDFNTDEFAULTSIZE,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOPEND19
GLOBAL	SYSFORLOOP19
SYSFORLOOP19:
	BANKSEL	ROW
	INCF	ROW,F
;GLCDY = [word]CharLocY + CharRow + CharRowS
	BANKSEL	CHARROW
	MOVF	CHARROW,W
	ADDWF	CHARLOCY,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	BANKSEL	CHARROWS
	MOVF	CHARROWS,W
	BANKSEL	SYSTEMP1
	ADDWF	SYSTEMP1,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
;if CurrCharVal.0=1 then
	BTFSS	CURRCHARVAL,0
	LJMP	ELSE46_1
;PSet [word]CharLocX + CharCol + CharColS, GLCDY, LineColour
	MOVF	CHARCOL,W
	ADDWF	CHARLOCX,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	BANKSEL	CHARCOLS
	MOVF	CHARCOLS,W
	BANKSEL	SYSTEMP1
	ADDWF	SYSTEMP1,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;Else
	LJMP	ENDIF46
GLOBAL	ELSE46_1
ELSE46_1:
;PSet [word]CharLocX + CharCol + CharColS, GLCDY, GLCDBackground
	MOVF	CHARCOL,W
	ADDWF	CHARLOCX,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	BANKSEL	CHARCOLS
	MOVF	CHARCOLS,W
	BANKSEL	SYSTEMP1
	ADDWF	SYSTEMP1,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	MOVF	GLCDBACKGROUND,W
	MOVWF	GLCDCOLOUR
	MOVF	GLCDBACKGROUND_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;End if
GLOBAL	ENDIF46
ENDIF46:
;End if
;CharRowS +=1
	INCF	CHARROWS,F
;Put out a white intercharacter pixel/space
;if ( CharCol + CharColS ) = ( GLCDFontWidth * GLCDfntDefaultsize) - GLCDfntDefaultsize - 1 then
	MOVF	CHARCOLS,W
	ADDWF	CHARCOL,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	MOVLW	0
	BANKSEL	CHARCOL_H
	ADDWFC	CHARCOL_H,W
	BANKSEL	SYSTEMP1_H
	MOVWF	SYSTEMP1_H
	BANKSEL	GLCDFONTWIDTH
	MOVF	GLCDFONTWIDTH,W
	MOVWF	SYSBYTETEMPA
	MOVF	GLCDFNTDEFAULTSIZE,W
	MOVWF	SYSBYTETEMPB
	PAGESEL	SYSMULTSUB
	FCALL	SYSMULTSUB
	PAGESEL	$
	MOVF	SYSBYTETEMPX,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	GLCDFNTDEFAULTSIZE
	MOVF	GLCDFNTDEFAULTSIZE,W
	BANKSEL	SYSTEMP2
	SUBWF	SYSTEMP2,W
	MOVWF	SYSTEMP3
	DECF	SYSTEMP3,W
	MOVWF	SYSTEMP2
	MOVF	SYSTEMP1,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSTEMP1_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVF	SYSTEMP2,W
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
BANKSEL	STATUS
	PAGESEL	SYSCOMPEQUAL16
	FCALL	SYSCOMPEQUAL16
	PAGESEL	$
	BTFSS	SYSBYTETEMPX,0
	LJMP	ENDIF47
;PSet [word]CharLocX + CharCol + CharColS + 1, [word]CharLocY + CharRow+CharRowS -1, GLCDBackground
	MOVF	CHARCOL,W
	ADDWF	CHARLOCX,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	BANKSEL	CHARCOLS
	MOVF	CHARCOLS,W
	BANKSEL	SYSTEMP1
	ADDWF	SYSTEMP1,W
	MOVWF	SYSTEMP2
	INCF	SYSTEMP2,W
	BANKSEL	GLCDX
	MOVWF	GLCDX
	MOVF	CHARROW,W
	ADDWF	CHARLOCY,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	BANKSEL	CHARROWS
	MOVF	CHARROWS,W
	BANKSEL	SYSTEMP1
	ADDWF	SYSTEMP1,W
	MOVWF	SYSTEMP2
	DECF	SYSTEMP2,W
	BANKSEL	GLCDY
	MOVWF	GLCDY
	MOVF	GLCDBACKGROUND,W
	MOVWF	GLCDCOLOUR
	MOVF	GLCDBACKGROUND_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;end if
GLOBAL	ENDIF47
ENDIF47:
;Next Row
	MOVF	GLCDFNTDEFAULTSIZE,W
	BANKSEL	ROW
	SUBWF	ROW,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOP19
GLOBAL	SYSFORLOOPEND19
SYSFORLOOPEND19:
;CharColS +=1
	BANKSEL	CHARCOLS
	INCF	CHARCOLS,F
;Next Col
	MOVF	GLCDFNTDEFAULTSIZE,W
	SUBWF	COL,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOP18
GLOBAL	SYSFORLOOPEND18
SYSFORLOOPEND18:
;Rotate CurrCharVal Right
	RRF	CURRCHARVAL,F
;CharRow +=GLCDfntDefaultsize
	MOVF	GLCDFNTDEFAULTSIZE,W
	ADDWF	CHARROW,F
	MOVLW	0
	ADDWFC	CHARROW_H,F
;Next
	MOVLW	8
	SUBWF	CURRCHARROW,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOP17
GLOBAL	SYSFORLOOPEND17
SYSFORLOOPEND17:
;CharCol +=GLCDfntDefaultsize
	MOVF	GLCDFNTDEFAULTSIZE,W
	ADDWF	CHARCOL,F
	MOVLW	0
	ADDWFC	CHARCOL_H,F
;1.12 Character GLCD mode
;Handles specific draw sequence. This caters for write only of a bit value. No read operation.
;Ensure this is not called with in Low memory mode
;Next
	MOVLW	5
	SUBWF	CURRCHARCOL,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOP16
GLOBAL	SYSFORLOOPEND16
SYSFORLOOPEND16:
;****** OLED Font set handler
;1.14 Added transaction
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1274)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	PAGESEL	HI2CSTOP
	FCALL	HI2CSTOP
	PAGESEL	$
;Restore
;GLCDBackground = 0
	CLRF	GLCDBACKGROUND
	CLRF	GLCDBACKGROUND_H
;GLCDForeground = 1
	MOVLW	1
	MOVWF	GLCDFOREGROUND
	CLRF	GLCDFOREGROUND_H
	RETURN

;********************************************************************************

;SOURCE: GLCD.H (1238)
GLOBAL	GLCDDRAWSTRING
GLCDDRAWSTRING:
;dim GLCDPrintLoc as word
;GLCDPrintLoc = StringLocX
	BANKSEL	STRINGLOCX
	MOVF	STRINGLOCX,W
	BANKSEL	GLCDPRINTLOC
	MOVWF	GLCDPRINTLOC
	CLRF	GLCDPRINTLOC_H
;for xchar = 1 to Chars(0)
	BANKSEL	XCHAR
	CLRF	XCHAR
	MOVF	SYSCHARSHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSCHARSHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVLW	1
	SUBWF	INDF0,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOPEND10
GLOBAL	SYSFORLOOP10
SYSFORLOOP10:
	INCF	XCHAR,F
;GLCDDrawChar GLCDPrintLoc , CharLocY , Chars(xchar), LineColour
	BANKSEL	GLCDPRINTLOC
	MOVF	GLCDPRINTLOC,W
	MOVWF	CHARLOCX
	MOVF	GLCDPRINTLOC_H,W
	MOVWF	CHARLOCX_H
	BANKSEL	XCHAR
	MOVF	XCHAR,W
	ADDWF	SYSCHARSHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSCHARSHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	CHARCODE
	MOVWF	CHARCODE
	FCALL	GLCDDRAWCHAR_SSD1306
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1172)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	MOVF	GLCDFONTWIDTH,W
	MOVWF	SYSBYTETEMPA
	MOVF	GLCDFNTDEFAULTSIZE,W
	MOVWF	SYSBYTETEMPB
	PAGESEL	SYSMULTSUB
	FCALL	SYSMULTSUB
	PAGESEL	$
	MOVF	SYSBYTETEMPX,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	BANKSEL	GLCDPRINTLOC
	ADDWF	GLCDPRINTLOC,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	MOVLW	0
	BANKSEL	GLCDPRINTLOC_H
	ADDWFC	GLCDPRINTLOC_H,W
	BANKSEL	SYSTEMP2_H
	MOVWF	SYSTEMP2_H
	MOVLW	1
	ADDWF	SYSTEMP2,W
	BANKSEL	GLCDPRINTLOC
	MOVWF	GLCDPRINTLOC
	MOVLW	0
	BANKSEL	SYSTEMP2_H
	ADDWFC	SYSTEMP2_H,W
	BANKSEL	GLCDPRINTLOC_H
	MOVWF	GLCDPRINTLOC_H
;next
	BANKSEL	SYSCHARSHANDLER
	MOVF	SYSCHARSHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSCHARSHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	SUBWF	XCHAR,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOP10
GLOBAL	SYSFORLOOPEND10
SYSFORLOOPEND10:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: NEW1013.GCB (132)
GLOBAL	GLCDLOOP
GLCDLOOP:
;Do Forever
GLOBAL	SYSDOLOOP_S1
SYSDOLOOP_S1:
;For CCount = 31 To 127
	MOVLW	30
	MOVWF	CCOUNT
GLOBAL	SYSFORLOOP5
SYSFORLOOP5:
	INCF	CCOUNT,F
;Prepare the static components of the screen
;GLCD_Open_PageTransaction 0,7
;Macro Source: glcd_ssd1306.h (1172)
;dim _GLCDPage as byte
;Clear buffer
;for _GLCDPage = _GLCDPagesL to _GLCDPagesH    '_GLCDPage is a global variable - DO NOT CHANGE!!!
	MOVLW	255
	BANKSEL	_GLCDPAGE
	MOVWF	_GLCDPAGE
GLOBAL	SYSFORLOOP6
SYSFORLOOP6:
	INCF	_GLCDPAGE,F
;Print some text
;GLCDPrint ( 1,   1, "PrintStr")
	MOVLW	1
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	1
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE8
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE8) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
BANKSEL	STATUS
	PAGESEL	GLCDPRINT32
	FCALL	GLCDPRINT32
	PAGESEL	$
;Print some more text
;GLCDPrint ( 64,  1, "@")
	MOVLW	64
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	1
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE9
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE9) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
BANKSEL	STATUS
	PAGESEL	GLCDPRINT32
	FCALL	GLCDPRINT32
	PAGESEL	$
;Print chip speed
;GLCDPrint ( 72,  1, ChipMHz)
	MOVLW	72
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	1
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	32
	BANKSEL	LCDVALUE
	MOVWF	LCDVALUE
	CLRF	LCDVALUE_H
	CLRF	LCDVALUE_U
	CLRF	LCDVALUE_E
	PAGESEL	GLCDPRINT35
	FCALL	GLCDPRINT35
	PAGESEL	$
;Print some text
;GLCDPrint ( 86, 1, "Mhz")
	MOVLW	86
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	CLRF	PRINTLOCX_H
	MOVLW	1
	MOVWF	PRINTLOCY
	CLRF	PRINTLOCY_H
	MOVLW	LOW STRINGTABLE10
	MOVWF	SYSLCDPRINTDATAHANDLER
	MOVLW	(HIGH STRINGTABLE10) | 128
	MOVWF	SYSLCDPRINTDATAHANDLER_H
BANKSEL	STATUS
	PAGESEL	GLCDPRINT32
	FCALL	GLCDPRINT32
	PAGESEL	$
;Draw some text
;GLCDDrawString( 1,11,"DrawStr")
	MOVLW	1
	BANKSEL	STRINGLOCX
	MOVWF	STRINGLOCX
	MOVLW	11
	BANKSEL	CHARLOCY
	MOVWF	CHARLOCY
	MOVLW	LOW STRINGTABLE11
	BANKSEL	SYSCHARSHANDLER
	MOVWF	SYSCHARSHANDLER
	MOVLW	(HIGH STRINGTABLE11) | 128
	MOVWF	SYSCHARSHANDLER_H
	BANKSEL	GLCDFOREGROUND
	MOVF	GLCDFOREGROUND,W
	MOVWF	LINECOLOUR
	MOVF	GLCDFOREGROUND_H,W
	MOVWF	LINECOLOUR_H
	FCALL	GLCDDRAWSTRING
;Draw a box
;Box 0,0,GLCD_WIDTH-1, GLCD_HEIGHT-1
	CLRF	LINEX1
	CLRF	LINEX1_H
	CLRF	LINEY1
	CLRF	LINEY1_H
	MOVLW	127
	MOVWF	LINEX2
	CLRF	LINEX2_H
	MOVLW	63
	MOVWF	LINEY2
	CLRF	LINEY2_H
	MOVF	GLCDFOREGROUND,W
	MOVWF	LINECOLOUR
	MOVF	GLCDFOREGROUND_H,W
	MOVWF	LINECOLOUR_H
	FCALL	BOX
;Draw a box
;Box GLCD_WIDTH-5, GLCD_HEIGHT-5,GLCD_WIDTH-1, GLCD_HEIGHT-1
	MOVLW	123
	MOVWF	LINEX1
	CLRF	LINEX1_H
	MOVLW	59
	MOVWF	LINEY1
	CLRF	LINEY1_H
	MOVLW	127
	MOVWF	LINEX2
	CLRF	LINEX2_H
	MOVLW	63
	MOVWF	LINEY2
	CLRF	LINEY2_H
	MOVF	GLCDFOREGROUND,W
	MOVWF	LINECOLOUR
	MOVF	GLCDFOREGROUND_H,W
	MOVWF	LINECOLOUR_H
	FCALL	BOX
;Draw a circle
;Circle( 44,24,5)
	MOVLW	44
	BANKSEL	XOFFSET
	MOVWF	XOFFSET
	CLRF	XOFFSET_H
	MOVLW	24
	MOVWF	YOFFSET
	CLRF	YOFFSET_H
	MOVLW	5
	BANKSEL	INXRADIUS
	MOVWF	INXRADIUS
	CLRF	INXRADIUS_H
	MOVF	GLCDFOREGROUND,W
	MOVWF	LINECOLOUR
	MOVF	GLCDFOREGROUND_H,W
	MOVWF	LINECOLOUR_H
	MOVF	GLCD_YORDINATE,W
	BANKSEL	YORDINATE
	MOVWF	YORDINATE
BANKSEL	STATUS
	FCALL	CIRCLE
;Draw a line
;Line 0,GLCD_HEIGHT-1,44,19
	CLRF	LINEX1
	CLRF	LINEX1_H
	MOVLW	63
	MOVWF	LINEY1
	CLRF	LINEY1_H
	MOVLW	44
	MOVWF	LINEX2
	CLRF	LINEX2_H
	MOVLW	19
	MOVWF	LINEY2
	CLRF	LINEY2_H
	MOVF	GLCDFOREGROUND,W
	MOVWF	LINECOLOUR
	MOVF	GLCDFOREGROUND_H,W
	MOVWF	LINECOLOUR_H
	FCALL	_LINE
;Draw a Box
;Box (3,24,6,27)
	MOVLW	3
	MOVWF	LINEX1
	CLRF	LINEX1_H
	MOVLW	24
	MOVWF	LINEY1
	CLRF	LINEY1_H
	MOVLW	6
	MOVWF	LINEX2
	CLRF	LINEX2_H
	MOVLW	27
	MOVWF	LINEY2
	CLRF	LINEY2_H
	MOVF	GLCDFOREGROUND,W
	MOVWF	LINECOLOUR
	MOVF	GLCDFOREGROUND_H,W
	MOVWF	LINECOLOUR_H
	FCALL	BOX
;Draw a string
;GLCDDrawString(44, 11, CHR(CCount)+"="+Pad(outString,3) )
	MOVLW	44
	BANKSEL	STRINGLOCX
	MOVWF	STRINGLOCX
	MOVLW	11
	BANKSEL	CHARLOCY
	MOVWF	CHARLOCY
	MOVF	CCOUNT,W
	BANKSEL	SYSCHAR
	MOVWF	SYSCHAR
BANKSEL	STATUS
	PAGESEL	FN_CHR
	FCALL	FN_CHR
	PAGESEL	$
	MOVLW	LOW OUTSTRING
	BANKSEL	SYSSYSINSTRINGHANDLER
	MOVWF	SYSSYSINSTRINGHANDLER
	MOVLW	HIGH OUTSTRING
	MOVWF	SYSSYSINSTRINGHANDLER_H
	MOVLW	3
	MOVWF	SYSSTRLEN
	MOVLW	LOW STRINGTABLE67
	MOVWF	SYSSYSINSTRING3HANDLER
	MOVLW	(HIGH STRINGTABLE67) | 128
	MOVWF	SYSSYSINSTRING3HANDLER_H
BANKSEL	STATUS
	PAGESEL	FN_PAD
	FCALL	FN_PAD
	PAGESEL	$
	MOVLW	LOW SYSSTRINGPARAM1
MOVWF	FSR1L
	MOVLW	HIGH SYSSTRINGPARAM1
MOVWF	FSR1H
	CLRF	SYSSTRINGLENGTH
	MOVLW	LOW CHR
MOVWF	FSR0L
	MOVLW	HIGH CHR
MOVWF	FSR0H
	PAGESEL	SYSCOPYSTRINGPART
	FCALL	SYSCOPYSTRINGPART
	PAGESEL	$
	MOVLW	LOW STRINGTABLE12
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE12) & 127
	MOVWF	SYSSTRINGA_H
	PAGESEL	SYSREADSTRINGPART
	FCALL	SYSREADSTRINGPART
	PAGESEL	$
	MOVLW	LOW PAD
MOVWF	FSR0L
	MOVLW	HIGH PAD
MOVWF	FSR0H
	PAGESEL	SYSCOPYSTRINGPART
	FCALL	SYSCOPYSTRINGPART
	PAGESEL	$
	MOVLW	LOW SYSSTRINGPARAM1
MOVWF	FSR0L
	MOVLW	HIGH SYSSTRINGPARAM1
MOVWF	FSR0H
	MOVF	SYSSTRINGLENGTH,W
MOVWF	INDF0
	MOVLW	LOW SYSSTRINGPARAM1
	BANKSEL	SYSCHARSHANDLER
	MOVWF	SYSCHARSHANDLER
	MOVLW	HIGH SYSSTRINGPARAM1
	MOVWF	SYSCHARSHANDLER_H
	BANKSEL	GLCDFOREGROUND
	MOVF	GLCDFOREGROUND,W
	MOVWF	LINECOLOUR
	MOVF	GLCDFOREGROUND_H,W
	MOVWF	LINECOLOUR_H
	FCALL	GLCDDRAWSTRING
;GLCD_Close_PageTransaction
;Macro Source: glcd_ssd1306.h (1184)
;Set cursor position
;Cursor_Position_SSD1306 ( 0, 8 * _GLCDPage )
	CLRF	LOCX
	BANKSEL	_GLCDPAGE
	MOVF	_GLCDPAGE,W
	MOVWF	SYSBYTETEMPA
	MOVLW	8
	MOVWF	SYSBYTETEMPB
BANKSEL	STATUS
	PAGESEL	SYSMULTSUB
	FCALL	SYSMULTSUB
	PAGESEL	$
	MOVF	SYSBYTETEMPX,W
	MOVWF	LOCY
	PAGESEL	CURSOR_POSITION_SSD1306
	FCALL	CURSOR_POSITION_SSD1306
	PAGESEL	$
;Send the buffer to the device using transaction
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1210)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	PAGESEL	HI2CSTART
	FCALL	HI2CSTART
	PAGESEL	$
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE
	PAGESEL	HI2CSEND
	FCALL	HI2CSEND
	PAGESEL	$
;HI2CSend 0x40
	MOVLW	64
	MOVWF	I2CBYTE
	PAGESEL	HI2CSEND
	FCALL	HI2CSEND
	PAGESEL	$
;for SSD1306_BufferLocationCalc = 1 to 128
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC_H
GLOBAL	SYSFORLOOP7
SYSFORLOOP7:
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	INCF	SSD1306_BUFFERLOCATIONCALC,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F
;Write_Transaction_Data_SSD1306 SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
;Macro Source: glcd_ssd1306.h (1241)
;HI2CSend SSD1306SendByte
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	PAGESEL	HI2CSEND
	FCALL	HI2CSEND
	PAGESEL	$
;Clear the buffer byte. We need it to be empty for the next page operation
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
CLRF	INDF0
;next
	MOVF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	SYSWORDTEMPA
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	128
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
BANKSEL	STATUS
	PAGESEL	SYSCOMPLESSTHAN16
	FCALL	SYSCOMPLESSTHAN16
	PAGESEL	$
	BTFSC	SYSBYTETEMPX,0
	LJMP	SYSFORLOOP7
GLOBAL	SYSFORLOOPEND7
SYSFORLOOPEND7:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1274)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	PAGESEL	HI2CSTOP
	FCALL	HI2CSTOP
	PAGESEL	$
;next
	MOVLW	7
	BANKSEL	_GLCDPAGE
	SUBWF	_GLCDPAGE,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOP6
GLOBAL	SYSFORLOOPEND6
SYSFORLOOPEND6:
;longNumber = longNumber + 7
	MOVLW	7
	ADDWF	LONGNUMBER,F
	MOVLW	0
	ADDWFC	LONGNUMBER_H,F
	MOVLW	0
	ADDWFC	LONGNUMBER_U,F
	MOVLW	0
	ADDWFC	LONGNUMBER_E,F
;Next
	MOVLW	127
	BANKSEL	CCOUNT
	SUBWF	CCOUNT,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOP5
GLOBAL	SYSFORLOOPEND5
SYSFORLOOPEND5:
;Loop
	LJMP	SYSDOLOOP_S1
GLOBAL	SYSDOLOOP_E1
SYSDOLOOP_E1:
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (698)
GLOBAL	HI2CINIT
HI2CINIT:
;asm showdebug  This method sets the variable `HI2CCurrentMode`, and, if required calls the method `SI2CInit` to set up new MSSP modules - aka K42s family chips
;HI2CCurrentMode = 0
	CLRF	HI2CCURRENTMODE
;Initialise the I2C module
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (309)
GLOBAL	INITGLCD_SSD1306
INITGLCD_SSD1306:
;Colours //Set these first
;GLCDBackground = 0
	CLRF	GLCDBACKGROUND
	CLRF	GLCDBACKGROUND_H
;GLCDForeground = 1
	MOVLW	1
	MOVWF	GLCDFOREGROUND
	CLRF	GLCDFOREGROUND_H
;GLCDFontWidth = 5
	MOVLW	5
	MOVWF	GLCDFONTWIDTH
;GLCDfntDefaultHeight = 7  'used by GLCDPrintString and GLCDPrintStringLn
	MOVLW	7
	MOVWF	GLCDFNTDEFAULTHEIGHT
;dim PrintLocX, PrintLocY as word
;GLCDfntDefault = 0
	CLRF	GLCDFNTDEFAULT
;GLCDfntDefaultsize = 1
	MOVLW	1
	MOVWF	GLCDFNTDEFAULTSIZE
;wait 255 ms             'added to ensure the charge pump and power is operational.
	MOVLW	255
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	PAGESEL	DELAY_MS
	FCALL	DELAY_MS
	PAGESEL	$
;HI2CMode Master
	MOVLW	12
	MOVWF	HI2CCURRENTMODE
	PAGESEL	HI2CMODE
	FCALL	HI2CMODE
	PAGESEL	$
;Wait 15 ms  'wait for power-up and reset
	MOVLW	15
	MOVWF	SYSWAITTEMPMS
	CLRF	SYSWAITTEMPMS_H
	PAGESEL	DELAY_MS
	FCALL	DELAY_MS
	PAGESEL	$
;Setup code for SSD1306 controllers
;Init sequence for 128x64 OLED module
;Write_Command_SSD1306(SSD1306_DISPLAYOFF)                    ' 0xAE
	MOVLW	174
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(SSD1306_DEACTIVATE_SCROLL)
	MOVLW	46
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(SSD1306_SETDISPLAYCLOCKDIV)            ' 0xD5
	MOVLW	213
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(0x80)                                  ' the suggested ratio 0x80
	MOVLW	128
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(SSD1306_SETMULTIPLEX)                  ' 0xA8
	MOVLW	168
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(0x3f)                                 '64 pixels
	MOVLW	63
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(SSD1306_SETDISPLAYOFFSET)              ' 0xD3
	MOVLW	211
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(0x00)                                   ' no offset
	BANKSEL	SSD1306SENDBYTE
	CLRF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(SSD1306_SETSTARTLINE | 0x00)            ' line #0
	MOVLW	64
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(SSD1306_CHARGEPUMP)                    ' 0x8D
	MOVLW	141
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;if (SSD1306_vccstate = SSD1306_EXTERNALVCC) then
;Write_Command_SSD1306(0x14)
	MOVLW	20
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;end if
;Write_Command_SSD1306(SSD1306_MEMORYMODE)                    ' 0x20
	MOVLW	32
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(0x00)                                  ' 0x00 act like ks0108 - DO NOT SELECT!!
;Write_Command_SSD1306(0x10)                                  ' 0x01 act like PCD8544
	MOVLW	16
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(SSD1306_SEGREMAP | 0x1)
	MOVLW	161
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(SSD1306_COMSCANDEC)
	MOVLW	200
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(SSD1306_SETCOMPINS)                    ' 0xDA
	MOVLW	218
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(0x12)                                 '64 pixels
	MOVLW	18
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(SSD1306_SETCONTRAST)                   ' 0x81
	MOVLW	129
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xCF)
	MOVLW	207
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;end if
;Write_Command_SSD1306(SSD1306_SETPRECHARGE)                  ' 0xd9
	MOVLW	217
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;if SSD1306_vccstate = SSD1306_EXTERNALVCC then
;Write_Command_SSD1306(0xF1)
	MOVLW	241
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;end if
;Write_Command_SSD1306(SSD1306_SETVCOMDETECT)                 ' 0xDB
	MOVLW	219
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(0x40)
	MOVLW	64
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(SSD1306_DISPLAYALLON_RESUME)           ' 0xA4
	MOVLW	164
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(SSD1306_NORMALDISPLAY)                 ' 0xA6
	MOVLW	166
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	FCALL	WRITE_COMMAND_SSD1306
	PAGESEL	$
;Clear screen Here
;GLCDCLS_SSD1306
	PAGESEL	GLCDCLS_SSD1306
	FCALL	GLCDCLS_SSD1306
	PAGESEL	$
;Write_Command_SSD1306(SSD1306_DISPLAYON)                     '--turn on oled panel
	MOVLW	175
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	PAGESEL	WRITE_COMMAND_SSD1306
	LJMP	WRITE_COMMAND_SSD1306

;********************************************************************************

;SOURCE: NEW1013.GCB (27)
GLOBAL	INITPPS
INITPPS:
;UNLOCKPPS
;Macro Source: stdbasic.h (78)
;dim IntState as bit
;IntState = GIE
	BANKSEL	SYSBITVAR0
	BCF	SYSBITVAR0,7
;B7: ASM Source was:  BTFSC INTCON,GIE
	BTFSC	INTCON,7
	BSF	SYSBITVAR0,7
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
;SSP1CLKPPS = 0x14     'RC3->MSSP1:SCL1;
	MOVLW	20
MOVWF	SSP1CLKPPS
;SSP1DATPPS = 0x13     'RC4->MSSP1:SDA1;
	MOVLW	19
MOVWF	SSP1DATPPS
;RC3PPS = 0x15         'RC3->MSSP1:SCL1;
	MOVLW	21
BANKSEL	RC3PPS
MOVWF	RC3PPS
;RC4PPS = 0x14         'RC4->MSSP1:SDA1;
	MOVLW	20
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
	BTFSS	SYSBITVAR0,7
;B7: ASM Source was:  BCF INTCON,GIE
	BCF	INTCON,7
	BTFSC	SYSBITVAR0,7
;B7: ASM Source was:  BSF INTCON,GIE
	BSF	INTCON,7
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (130)
GLOBAL	INITSYS
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

;SOURCE: PICAS.H (26)
GLOBAL	_LINE
_LINE:
;dim LineStepX as integer
;dim LineStepY as integer
;dim LineDiffX, LineDiffY as integer
;dim LineDiffX_x2, LineDiffY_x2 as integer
;dim LineErr as integer
;LineDiffX = 0
	CLRF	LINEDIFFX
	CLRF	LINEDIFFX_H
;LineDiffY = 0
	CLRF	LINEDIFFY
	CLRF	LINEDIFFY_H
;LineStepX = 0
	CLRF	LINESTEPX
	CLRF	LINESTEPX_H
;LineStepY = 0
	CLRF	LINESTEPY
	CLRF	LINESTEPY_H
;LineDiffX_x2 = 0
	CLRF	LINEDIFFX_X2
	CLRF	LINEDIFFX_X2_H
;LineDiffY_x2 = 0
	CLRF	LINEDIFFY_X2
	CLRF	LINEDIFFY_X2_H
;LineErr = 0
	CLRF	LINEERR
	CLRF	LINEERR_H
;LineDiffX =  LineX2 -   LineX1
	MOVF	LINEX1,W
	SUBWF	LINEX2,W
	MOVWF	LINEDIFFX
	MOVF	LINEX1_H,W
	SUBWFB	LINEX2_H,W
	MOVWF	LINEDIFFX_H
;LineDiffY =  LineY2 -   LineY1
	MOVF	LINEY1,W
	SUBWF	LINEY2,W
	MOVWF	LINEDIFFY
	MOVF	LINEY1_H,W
	SUBWFB	LINEY2_H,W
	MOVWF	LINEDIFFY_H
;if (LineDiffX > 0) then
	MOVF	LINEDIFFX,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	LINEDIFFX_H,W
	MOVWF	SYSINTEGERTEMPB_H
	CLRF	SYSINTEGERTEMPA
	CLRF	SYSINTEGERTEMPA_H
	PAGESEL	SYSCOMPLESSTHANINT
	FCALL	SYSCOMPLESSTHANINT
	PAGESEL	$
	BTFSS	SYSBYTETEMPX,0
	LJMP	ELSE60_1
;LineStepX = 1
	MOVLW	1
	MOVWF	LINESTEPX
	CLRF	LINESTEPX_H
;else
	LJMP	ENDIF60
GLOBAL	ELSE60_1
ELSE60_1:
;LineStepX = -1
	MOVLW	255
	MOVWF	LINESTEPX
	MOVWF	LINESTEPX_H
;end if
GLOBAL	ENDIF60
ENDIF60:
;if (LineDiffY > 0) then
	MOVF	LINEDIFFY,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	LINEDIFFY_H,W
	MOVWF	SYSINTEGERTEMPB_H
	CLRF	SYSINTEGERTEMPA
	CLRF	SYSINTEGERTEMPA_H
	PAGESEL	SYSCOMPLESSTHANINT
	FCALL	SYSCOMPLESSTHANINT
	PAGESEL	$
	BTFSS	SYSBYTETEMPX,0
	LJMP	ELSE61_1
;LineStepY = 1
	MOVLW	1
	MOVWF	LINESTEPY
	CLRF	LINESTEPY_H
;else
	LJMP	ENDIF61
GLOBAL	ELSE61_1
ELSE61_1:
;LineStepY = -1
	MOVLW	255
	MOVWF	LINESTEPY
	MOVWF	LINESTEPY_H
;end if
GLOBAL	ENDIF61
ENDIF61:
;LineDiffX = LineStepX * LineDiffX
	MOVF	LINESTEPX,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	LINESTEPX_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVF	LINEDIFFX,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	LINEDIFFX_H,W
	MOVWF	SYSINTEGERTEMPB_H
	PAGESEL	SYSMULTSUBINT
	FCALL	SYSMULTSUBINT
	PAGESEL	$
	MOVF	SYSINTEGERTEMPX,W
	MOVWF	LINEDIFFX
	MOVF	SYSINTEGERTEMPX_H,W
	MOVWF	LINEDIFFX_H
;LineDiffY = LineStepY * LineDiffY
	MOVF	LINESTEPY,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	LINESTEPY_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVF	LINEDIFFY,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	LINEDIFFY_H,W
	MOVWF	SYSINTEGERTEMPB_H
	PAGESEL	SYSMULTSUBINT
	FCALL	SYSMULTSUBINT
	PAGESEL	$
	MOVF	SYSINTEGERTEMPX,W
	MOVWF	LINEDIFFY
	MOVF	SYSINTEGERTEMPX_H,W
	MOVWF	LINEDIFFY_H
;LineDiffX_x2 = LineDiffX*2
	MOVF	LINEDIFFX,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	LINEDIFFX_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVLW	2
	MOVWF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
	PAGESEL	SYSMULTSUBINT
	FCALL	SYSMULTSUBINT
	PAGESEL	$
	MOVF	SYSINTEGERTEMPX,W
	MOVWF	LINEDIFFX_X2
	MOVF	SYSINTEGERTEMPX_H,W
	MOVWF	LINEDIFFX_X2_H
;LineDiffY_x2 = LineDiffY*2
	MOVF	LINEDIFFY,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	LINEDIFFY_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVLW	2
	MOVWF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
	PAGESEL	SYSMULTSUBINT
	FCALL	SYSMULTSUBINT
	PAGESEL	$
	MOVF	SYSINTEGERTEMPX,W
	MOVWF	LINEDIFFY_X2
	MOVF	SYSINTEGERTEMPX_H,W
	MOVWF	LINEDIFFY_X2_H
;if ( LineDiffX >= LineDiffY) then
	MOVF	LINEDIFFX,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	LINEDIFFX_H,W
	MOVWF	SYSINTEGERTEMPA_H
	MOVF	LINEDIFFY,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	LINEDIFFY_H,W
	MOVWF	SYSINTEGERTEMPB_H
	PAGESEL	SYSCOMPLESSTHANINT
	FCALL	SYSCOMPLESSTHANINT
	PAGESEL	$
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	LJMP	ELSE62_1
;LineErr = LineDiffY_x2 - LineDiffX
	MOVF	LINEDIFFX,W
	SUBWF	LINEDIFFY_X2,W
	MOVWF	LINEERR
	MOVF	LINEDIFFX_H,W
	SUBWFB	LINEDIFFY_X2_H,W
	MOVWF	LINEERR_H
;do while (   LineX1 <>  LineX2 )
GLOBAL	SYSDOLOOP_S4
SYSDOLOOP_S4:
	MOVF	LINEX1,W
	MOVWF	SYSWORDTEMPA
	MOVF	LINEX1_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVF	LINEX2,W
	MOVWF	SYSWORDTEMPB
	MOVF	LINEX2_H,W
	MOVWF	SYSWORDTEMPB_H
	PAGESEL	SYSCOMPEQUAL16
	FCALL	SYSCOMPEQUAL16
	PAGESEL	$
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	LJMP	SYSDOLOOP_E4
;PSet (   LineX1,   LineY1, LineColour )
	MOVF	LINEX1,W
	MOVWF	GLCDX
	MOVF	LINEY1,W
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;LineX1 += LineStepX
	MOVF	LINESTEPX,W
	ADDWF	LINEX1,F
	MOVF	LINESTEPX_H,W
	ADDWFC	LINEX1_H,F
;if ( LineErr < 0) then
	MOVF	LINEERR,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	LINEERR_H,W
	MOVWF	SYSINTEGERTEMPA_H
	CLRF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
	PAGESEL	SYSCOMPLESSTHANINT
	FCALL	SYSCOMPLESSTHANINT
	PAGESEL	$
	BTFSS	SYSBYTETEMPX,0
	LJMP	ELSE63_1
;LineErr += LineDiffY_x2
	MOVF	LINEDIFFY_X2,W
	ADDWF	LINEERR,F
	MOVF	LINEDIFFY_X2_H,W
	ADDWFC	LINEERR_H,F
;else
	LJMP	ENDIF63
GLOBAL	ELSE63_1
ELSE63_1:
;LineErr += ( LineDiffY_x2 - LineDiffX_x2 )
	MOVF	LINEDIFFX_X2,W
	SUBWF	LINEDIFFY_X2,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	LINEDIFFX_X2_H
	MOVF	LINEDIFFX_X2_H,W
	SUBWFB	LINEDIFFY_X2_H,W
	BANKSEL	SYSTEMP2_H
	MOVWF	SYSTEMP2_H
	MOVF	SYSTEMP2,W
	BANKSEL	LINEERR
	ADDWF	LINEERR,F
	BANKSEL	SYSTEMP2_H
	MOVF	SYSTEMP2_H,W
	BANKSEL	LINEERR_H
	ADDWFC	LINEERR_H,F
;LineY1 += LineStepY
	MOVF	LINESTEPY,W
	ADDWF	LINEY1,F
	MOVF	LINESTEPY_H,W
	ADDWFC	LINEY1_H,F
;end if
GLOBAL	ENDIF63
ENDIF63:
;loop
	LJMP	SYSDOLOOP_S4
GLOBAL	SYSDOLOOP_E4
SYSDOLOOP_E4:
;PSet (   LineX1,   LineY1, LineColour )
	MOVF	LINEX1,W
	MOVWF	GLCDX
	MOVF	LINEY1,W
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;else
	LJMP	ENDIF62
GLOBAL	ELSE62_1
ELSE62_1:
;LineErr = LineDiffX_x2 - LineDiffY
	MOVF	LINEDIFFY,W
	SUBWF	LINEDIFFX_X2,W
	MOVWF	LINEERR
	MOVF	LINEDIFFY_H,W
	SUBWFB	LINEDIFFX_X2_H,W
	MOVWF	LINEERR_H
;do while (   LineY1 <>  LineY2)
GLOBAL	SYSDOLOOP_S5
SYSDOLOOP_S5:
	MOVF	LINEY1,W
	MOVWF	SYSWORDTEMPA
	MOVF	LINEY1_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVF	LINEY2,W
	MOVWF	SYSWORDTEMPB
	MOVF	LINEY2_H,W
	MOVWF	SYSWORDTEMPB_H
	PAGESEL	SYSCOMPEQUAL16
	FCALL	SYSCOMPEQUAL16
	PAGESEL	$
	COMF	SYSBYTETEMPX,F
	BTFSS	SYSBYTETEMPX,0
	LJMP	SYSDOLOOP_E5
;PSet (   LineX1,   LineY1, LineColour )
	MOVF	LINEX1,W
	MOVWF	GLCDX
	MOVF	LINEY1,W
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;LineY1 += LineStepY
	MOVF	LINESTEPY,W
	ADDWF	LINEY1,F
	MOVF	LINESTEPY_H,W
	ADDWFC	LINEY1_H,F
;if ( LineErr < 0) then
	MOVF	LINEERR,W
	MOVWF	SYSINTEGERTEMPA
	MOVF	LINEERR_H,W
	MOVWF	SYSINTEGERTEMPA_H
	CLRF	SYSINTEGERTEMPB
	CLRF	SYSINTEGERTEMPB_H
	PAGESEL	SYSCOMPLESSTHANINT
	FCALL	SYSCOMPLESSTHANINT
	PAGESEL	$
	BTFSS	SYSBYTETEMPX,0
	LJMP	ELSE64_1
;LineErr += LineDiffX_x2
	MOVF	LINEDIFFX_X2,W
	ADDWF	LINEERR,F
	MOVF	LINEDIFFX_X2_H,W
	ADDWFC	LINEERR_H,F
;else
	LJMP	ENDIF64
GLOBAL	ELSE64_1
ELSE64_1:
;LineErr += ( LineDiffX_x2 - LineDiffY_x2 )
	MOVF	LINEDIFFY_X2,W
	SUBWF	LINEDIFFX_X2,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	BANKSEL	LINEDIFFY_X2_H
	MOVF	LINEDIFFY_X2_H,W
	SUBWFB	LINEDIFFX_X2_H,W
	BANKSEL	SYSTEMP2_H
	MOVWF	SYSTEMP2_H
	MOVF	SYSTEMP2,W
	BANKSEL	LINEERR
	ADDWF	LINEERR,F
	BANKSEL	SYSTEMP2_H
	MOVF	SYSTEMP2_H,W
	BANKSEL	LINEERR_H
	ADDWFC	LINEERR_H,F
;LineX1 += LineStepX
	MOVF	LINESTEPX,W
	ADDWF	LINEX1,F
	MOVF	LINESTEPX_H,W
	ADDWFC	LINEX1_H,F
;end if
GLOBAL	ENDIF64
ENDIF64:
;loop
	LJMP	SYSDOLOOP_S5
GLOBAL	SYSDOLOOP_E5
SYSDOLOOP_E5:
;PSet (   LineX1,   LineY1, LineColour )
	MOVF	LINEX1,W
	MOVWF	GLCDX
	MOVF	LINEY1,W
	MOVWF	GLCDY
	MOVF	LINECOLOUR,W
	MOVWF	GLCDCOLOUR
	MOVF	LINECOLOUR_H,W
	MOVWF	GLCDCOLOUR_H
	PAGESEL	PSET_SSD1306
	FCALL	PSET_SSD1306
	PAGESEL	$
;end if
GLOBAL	ENDIF62
ENDIF62:
	RETURN

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 1
	ORG	2048
;SOURCE: STRING.H (536)
GLOBAL	FN_CHR
FN_CHR:
;Empty input?
;If SysChar < 0 Then
	MOVLW	0
	BANKSEL	SYSCHAR
	SUBWF	SYSCHAR,W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	LJMP	ENDIF76
;Chr(0) = 0
	BANKSEL	SYSCHR_0
	CLRF	SYSCHR_0
;Exit Function
BANKSEL	STATUS
	RETURN
;End If
GLOBAL	ENDIF76
ENDIF76:
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

;SOURCE: GLCD_SSD1306.H (1032)
GLOBAL	CURSOR_POSITION_SSD1306
CURSOR_POSITION_SSD1306:
;dim  PosCharX, PosCharX as Word
;PosCharY = LocY / 8
;faster than /8
;PosCharY = LocY
	MOVF	LOCY,W
	MOVWF	POSCHARY
;Repeat 3
	MOVLW	3
	BANKSEL	SYSREPEATTEMP4
	MOVWF	SYSREPEATTEMP4
GLOBAL	SYSREPEATLOOP4
SYSREPEATLOOP4:
;Set C Off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate PosCharY Right
	BANKSEL	POSCHARY
	RRF	POSCHARY,F
;End Repeat
	BANKSEL	SYSREPEATTEMP4
	DECFSZ	SYSREPEATTEMP4,F
	LJMP	SYSREPEATLOOP4
GLOBAL	SYSREPEATLOOPEND4
SYSREPEATLOOPEND4:
;Write_Command_SSD1306( 0xB0 + PosCharY )   ' set page address
	MOVLW	176
	BANKSEL	POSCHARY
	ADDWF	POSCHARY,W
	BANKSEL	SSD1306SENDBYTE
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;PosCharX = ( LocX  & 0x0f )  ' lower nibble
	MOVLW	15
	ANDWF	LOCX,W
	BANKSEL	POSCHARX
	MOVWF	POSCHARX
	CLRF	POSCHARX_H
;Write_Command_SSD1306( PosCharX )
	MOVF	POSCHARX,W
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	FCALL	WRITE_COMMAND_SSD1306
;PosCharX = LocX
	MOVF	LOCX,W
	BANKSEL	POSCHARX
	MOVWF	POSCHARX
	CLRF	POSCHARX_H
;Repeat 4
	MOVLW	4
	MOVWF	SYSREPEATTEMP4
GLOBAL	SYSREPEATLOOP5
SYSREPEATLOOP5:
;Set C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate PosCharX Right
	RRF	POSCHARX_H,F
	RRF	POSCHARX,F
;End Repeat
	DECFSZ	SYSREPEATTEMP4,F
	LJMP	SYSREPEATLOOP5
GLOBAL	SYSREPEATLOOPEND5
SYSREPEATLOOPEND5:
;PosCharX = ( PosCharX & 0x0F ) + 0x10
	MOVLW	15
	ANDWF	POSCHARX,W
	MOVWF	SYSTEMP1
	CLRF	SYSTEMP1_H
	MOVLW	16
	ADDWF	SYSTEMP1,W
	MOVWF	POSCHARX
	MOVLW	0
	ADDWFC	SYSTEMP1_H,W
	MOVWF	POSCHARX_H
;Write_Command_SSD1306 ( PosCharX )
	MOVF	POSCHARX,W
	MOVWF	SSD1306SENDBYTE
BANKSEL	STATUS
	LJMP	WRITE_COMMAND_SSD1306

;********************************************************************************

GLOBAL	DELAY_MS
DELAY_MS:
	INCF	SYSWAITTEMPMS_H, F
GLOBAL	DMS_START
DMS_START:
	MOVLW	14
	MOVWF	DELAYTEMP2
GLOBAL	DMS_OUTER
DMS_OUTER:
	MOVLW	189
	MOVWF	DELAYTEMP
GLOBAL	DMS_INNER
DMS_INNER:
	DECFSZ	DELAYTEMP, F
	LJMP	DMS_INNER
	DECFSZ	DELAYTEMP2, F
	LJMP	DMS_OUTER
	DECFSZ	SYSWAITTEMPMS, F
	LJMP	DMS_START
	DECFSZ	SYSWAITTEMPMS_H, F
	LJMP	DMS_START
	RETURN

;********************************************************************************

GLOBAL	DELAY_S
DELAY_S:
GLOBAL	DS_START
DS_START:
	MOVLW	232
	MOVWF	SYSWAITTEMPMS
	MOVLW	3
	MOVWF	SYSWAITTEMPMS_H
	FCALL	DELAY_MS
	DECFSZ	SYSWAITTEMPS, F
	LJMP	DS_START
	RETURN

;********************************************************************************

GLOBAL	GLCDCHARCOL3
GLCDCHARCOL3:
	MOVLW	113
	SUBWF	SYSSTRINGA, W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	RETLW	0
	MOVF	SYSSTRINGA, W
	ADDLW	LOW TABLEGLCDCHARCOL3
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH TABLEGLCDCHARCOL3) & 127
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	ADDLW	1
MOVWF	PCLATH
	MOVF	SYSSTRINGA, W
MOVWF	PCL
GLOBAL	TABLEGLCDCHARCOL3
TABLEGLCDCHARCOL3:
	RETLW	112
	RETLW	0
	RETLW	16
	RETLW	12
	RETLW	10
	RETLW	136
	RETLW	34
	RETLW	56
	RETLW	32
	RETLW	8
	RETLW	32
	RETLW	16
	RETLW	16
	RETLW	128
	RETLW	128
	RETLW	64
	RETLW	4
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	40
	RETLW	72
	RETLW	70
	RETLW	108
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	40
	RETLW	16
	RETLW	0
	RETLW	16
	RETLW	0
	RETLW	64
	RETLW	124
	RETLW	0
	RETLW	132
	RETLW	130
	RETLW	48
	RETLW	78
	RETLW	120
	RETLW	6
	RETLW	108
	RETLW	12
	RETLW	0
	RETLW	0
	RETLW	16
	RETLW	40
	RETLW	0
	RETLW	4
	RETLW	100
	RETLW	248
	RETLW	254
	RETLW	124
	RETLW	254
	RETLW	254
	RETLW	254
	RETLW	124
	RETLW	254
	RETLW	0
	RETLW	64
	RETLW	254
	RETLW	254
	RETLW	254
	RETLW	254
	RETLW	124
	RETLW	254
	RETLW	124
	RETLW	254
	RETLW	76
	RETLW	2
	RETLW	126
	RETLW	62
	RETLW	126
	RETLW	198
	RETLW	14
	RETLW	194
	RETLW	0
	RETLW	4
	RETLW	0
	RETLW	8
	RETLW	128
	RETLW	0
	RETLW	64
	RETLW	254
	RETLW	112
	RETLW	112
	RETLW	112
	RETLW	16
	RETLW	16
	RETLW	254
	RETLW	0
	RETLW	64
	RETLW	254
	RETLW	0
	RETLW	248
	RETLW	248
	RETLW	112
	RETLW	248
	RETLW	16
	RETLW	248
	RETLW	144
	RETLW	16
	RETLW	120
	RETLW	56
	RETLW	120
	RETLW	136
	RETLW	24
	RETLW	136
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	32
	RETLW	120
	ALIGN	2;X4

;********************************************************************************

GLOBAL	GLCDCHARCOL4
GLCDCHARCOL4:
	MOVLW	113
	SUBWF	SYSSTRINGA, W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	RETLW	0
	MOVF	SYSSTRINGA, W
	ADDLW	LOW TABLEGLCDCHARCOL4
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH TABLEGLCDCHARCOL4) & 127
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	ADDLW	1
MOVWF	PCLATH
	MOVF	SYSSTRINGA, W
MOVWF	PCL
GLOBAL	TABLEGLCDCHARCOL4
TABLEGLCDCHARCOL4:
	RETLW	112
	RETLW	254
	RETLW	56
	RETLW	10
	RETLW	6
	RETLW	204
	RETLW	102
	RETLW	124
	RETLW	112
	RETLW	4
	RETLW	64
	RETLW	16
	RETLW	56
	RETLW	136
	RETLW	162
	RETLW	112
	RETLW	28
	RETLW	0
	RETLW	0
	RETLW	14
	RETLW	254
	RETLW	84
	RETLW	38
	RETLW	146
	RETLW	10
	RETLW	56
	RETLW	130
	RETLW	16
	RETLW	16
	RETLW	160
	RETLW	16
	RETLW	192
	RETLW	32
	RETLW	162
	RETLW	132
	RETLW	194
	RETLW	130
	RETLW	40
	RETLW	138
	RETLW	148
	RETLW	2
	RETLW	146
	RETLW	146
	RETLW	108
	RETLW	172
	RETLW	40
	RETLW	40
	RETLW	130
	RETLW	2
	RETLW	146
	RETLW	36
	RETLW	146
	RETLW	130
	RETLW	130
	RETLW	146
	RETLW	18
	RETLW	130
	RETLW	16
	RETLW	130
	RETLW	128
	RETLW	16
	RETLW	128
	RETLW	4
	RETLW	8
	RETLW	130
	RETLW	18
	RETLW	130
	RETLW	18
	RETLW	146
	RETLW	2
	RETLW	128
	RETLW	64
	RETLW	128
	RETLW	40
	RETLW	16
	RETLW	162
	RETLW	254
	RETLW	8
	RETLW	130
	RETLW	4
	RETLW	128
	RETLW	2
	RETLW	168
	RETLW	144
	RETLW	136
	RETLW	136
	RETLW	168
	RETLW	252
	RETLW	168
	RETLW	16
	RETLW	144
	RETLW	128
	RETLW	32
	RETLW	130
	RETLW	8
	RETLW	16
	RETLW	136
	RETLW	40
	RETLW	40
	RETLW	16
	RETLW	168
	RETLW	124
	RETLW	128
	RETLW	64
	RETLW	128
	RETLW	80
	RETLW	160
	RETLW	200
	RETLW	16
	RETLW	0
	RETLW	130
	RETLW	16
	RETLW	68
	ALIGN	2;X4

;********************************************************************************

GLOBAL	GLCDCHARCOL5
GLCDCHARCOL5:
	MOVLW	113
	SUBWF	SYSSTRINGA, W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	RETLW	0
	MOVF	SYSSTRINGA, W
	ADDLW	LOW TABLEGLCDCHARCOL5
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH TABLEGLCDCHARCOL5) & 127
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	ADDLW	1
MOVWF	PCLATH
	MOVF	SYSSTRINGA, W
MOVWF	PCL
GLOBAL	TABLEGLCDCHARCOL5
TABLEGLCDCHARCOL5:
	RETLW	112
	RETLW	124
	RETLW	124
	RETLW	0
	RETLW	0
	RETLW	238
	RETLW	238
	RETLW	124
	RETLW	168
	RETLW	254
	RETLW	254
	RETLW	84
	RETLW	84
	RETLW	148
	RETLW	148
	RETLW	124
	RETLW	124
	RETLW	0
	RETLW	158
	RETLW	0
	RETLW	40
	RETLW	254
	RETLW	16
	RETLW	170
	RETLW	6
	RETLW	68
	RETLW	68
	RETLW	124
	RETLW	124
	RETLW	96
	RETLW	16
	RETLW	192
	RETLW	16
	RETLW	146
	RETLW	254
	RETLW	162
	RETLW	138
	RETLW	36
	RETLW	138
	RETLW	146
	RETLW	226
	RETLW	146
	RETLW	146
	RETLW	108
	RETLW	108
	RETLW	68
	RETLW	40
	RETLW	68
	RETLW	162
	RETLW	242
	RETLW	34
	RETLW	146
	RETLW	130
	RETLW	130
	RETLW	146
	RETLW	18
	RETLW	146
	RETLW	16
	RETLW	254
	RETLW	130
	RETLW	40
	RETLW	128
	RETLW	24
	RETLW	16
	RETLW	130
	RETLW	18
	RETLW	162
	RETLW	50
	RETLW	146
	RETLW	254
	RETLW	128
	RETLW	128
	RETLW	112
	RETLW	16
	RETLW	224
	RETLW	146
	RETLW	130
	RETLW	16
	RETLW	130
	RETLW	2
	RETLW	128
	RETLW	4
	RETLW	168
	RETLW	136
	RETLW	136
	RETLW	136
	RETLW	168
	RETLW	18
	RETLW	168
	RETLW	8
	RETLW	250
	RETLW	136
	RETLW	80
	RETLW	254
	RETLW	240
	RETLW	8
	RETLW	136
	RETLW	40
	RETLW	40
	RETLW	8
	RETLW	168
	RETLW	144
	RETLW	128
	RETLW	128
	RETLW	96
	RETLW	32
	RETLW	160
	RETLW	168
	RETLW	108
	RETLW	254
	RETLW	108
	RETLW	16
	RETLW	66
	ALIGN	2;X4

;********************************************************************************

GLOBAL	GLCDCHARCOL6
GLCDCHARCOL6:
	MOVLW	113
	SUBWF	SYSSTRINGA, W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	RETLW	0
	MOVF	SYSSTRINGA, W
	ADDLW	LOW TABLEGLCDCHARCOL6
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH TABLEGLCDCHARCOL6) & 127
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	ADDLW	1
MOVWF	PCLATH
	MOVF	SYSSTRINGA, W
MOVWF	PCL
GLOBAL	TABLEGLCDCHARCOL6
TABLEGLCDCHARCOL6:
	RETLW	112
	RETLW	56
	RETLW	254
	RETLW	12
	RETLW	10
	RETLW	204
	RETLW	102
	RETLW	124
	RETLW	32
	RETLW	4
	RETLW	64
	RETLW	56
	RETLW	16
	RETLW	162
	RETLW	136
	RETLW	112
	RETLW	28
	RETLW	0
	RETLW	0
	RETLW	14
	RETLW	254
	RETLW	84
	RETLW	200
	RETLW	68
	RETLW	0
	RETLW	130
	RETLW	56
	RETLW	16
	RETLW	16
	RETLW	0
	RETLW	16
	RETLW	0
	RETLW	8
	RETLW	138
	RETLW	128
	RETLW	146
	RETLW	150
	RETLW	254
	RETLW	138
	RETLW	146
	RETLW	18
	RETLW	146
	RETLW	82
	RETLW	0
	RETLW	0
	RETLW	130
	RETLW	40
	RETLW	40
	RETLW	18
	RETLW	130
	RETLW	36
	RETLW	146
	RETLW	130
	RETLW	68
	RETLW	146
	RETLW	18
	RETLW	146
	RETLW	16
	RETLW	130
	RETLW	126
	RETLW	68
	RETLW	128
	RETLW	4
	RETLW	32
	RETLW	130
	RETLW	18
	RETLW	66
	RETLW	82
	RETLW	146
	RETLW	2
	RETLW	128
	RETLW	64
	RETLW	128
	RETLW	40
	RETLW	16
	RETLW	138
	RETLW	130
	RETLW	32
	RETLW	254
	RETLW	4
	RETLW	128
	RETLW	8
	RETLW	168
	RETLW	136
	RETLW	136
	RETLW	144
	RETLW	168
	RETLW	2
	RETLW	168
	RETLW	8
	RETLW	128
	RETLW	122
	RETLW	136
	RETLW	128
	RETLW	8
	RETLW	8
	RETLW	136
	RETLW	40
	RETLW	48
	RETLW	8
	RETLW	168
	RETLW	128
	RETLW	64
	RETLW	64
	RETLW	128
	RETLW	80
	RETLW	160
	RETLW	152
	RETLW	130
	RETLW	0
	RETLW	16
	RETLW	32
	RETLW	68
	ALIGN	2;X4

;********************************************************************************

GLOBAL	GLCDCHARCOL7
GLCDCHARCOL7:
	MOVLW	113
	SUBWF	SYSSTRINGA, W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	RETLW	0
	MOVF	SYSSTRINGA, W
	ADDLW	LOW TABLEGLCDCHARCOL7
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH TABLEGLCDCHARCOL7) & 127
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	ADDLW	1
MOVWF	PCLATH
	MOVF	SYSSTRINGA, W
MOVWF	PCL
GLOBAL	TABLEGLCDCHARCOL7
TABLEGLCDCHARCOL7:
	RETLW	112
	RETLW	16
	RETLW	0
	RETLW	10
	RETLW	6
	RETLW	136
	RETLW	34
	RETLW	56
	RETLW	62
	RETLW	8
	RETLW	32
	RETLW	16
	RETLW	16
	RETLW	128
	RETLW	128
	RETLW	64
	RETLW	4
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	40
	RETLW	36
	RETLW	196
	RETLW	160
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	40
	RETLW	16
	RETLW	0
	RETLW	16
	RETLW	0
	RETLW	4
	RETLW	124
	RETLW	0
	RETLW	140
	RETLW	98
	RETLW	32
	RETLW	114
	RETLW	96
	RETLW	14
	RETLW	108
	RETLW	60
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	40
	RETLW	16
	RETLW	12
	RETLW	124
	RETLW	248
	RETLW	108
	RETLW	68
	RETLW	56
	RETLW	130
	RETLW	2
	RETLW	244
	RETLW	254
	RETLW	0
	RETLW	2
	RETLW	130
	RETLW	128
	RETLW	254
	RETLW	254
	RETLW	124
	RETLW	12
	RETLW	188
	RETLW	140
	RETLW	100
	RETLW	2
	RETLW	126
	RETLW	62
	RETLW	126
	RETLW	198
	RETLW	14
	RETLW	134
	RETLW	0
	RETLW	64
	RETLW	0
	RETLW	8
	RETLW	128
	RETLW	0
	RETLW	240
	RETLW	112
	RETLW	64
	RETLW	254
	RETLW	48
	RETLW	4
	RETLW	120
	RETLW	240
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	240
	RETLW	240
	RETLW	112
	RETLW	16
	RETLW	248
	RETLW	16
	RETLW	64
	RETLW	64
	RETLW	248
	RETLW	56
	RETLW	120
	RETLW	136
	RETLW	120
	RETLW	136
	RETLW	0
	RETLW	0
	RETLW	0
	RETLW	16
	RETLW	120
	ALIGN	2;X4

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (419)
GLOBAL	GLCDCLS_SSD1306
GLCDCLS_SSD1306:
;initialise global variable. Required variable for Circle in all DEVICE DRIVERS- DO NOT DELETE
;GLCD_yordinate = 0
	CLRF	GLCD_YORDINATE
	CLRF	GLCD_YORDINATE_H
;For SSD1306_BufferLocationCalc = 0 to 128
	MOVLW	255
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	MOVWF	SSD1306_BUFFERLOCATIONCALC
	MOVWF	SSD1306_BUFFERLOCATIONCALC_H
GLOBAL	SYSFORLOOP13
SYSFORLOOP13:
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	INCF	SSD1306_BUFFERLOCATIONCALC,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = 0
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
CLRF	INDF0
;Next
	MOVF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	SYSWORDTEMPA
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	128
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
	LJMP	SYSFORLOOP13
GLOBAL	SYSFORLOOPEND13
SYSFORLOOPEND13:
;1.14 changed to transaction
;For SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
	MOVLW	248
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	MOVWF	SSD1306_BUFFERLOCATIONCALC
	MOVLW	255
	MOVWF	SSD1306_BUFFERLOCATIONCALC_H
GLOBAL	SYSFORLOOP14
SYSFORLOOP14:
	MOVLW	8
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,F
	MOVLW	0
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,F
;Cursor_Position_SSD1306 ( 0 , SSD1306_BufferLocationCalc )
	BANKSEL	LOCX
	CLRF	LOCX
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	MOVF	SSD1306_BUFFERLOCATIONCALC,W
	BANKSEL	LOCY
	MOVWF	LOCY
	FCALL	CURSOR_POSITION_SSD1306
;Open_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1210)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStart
	FCALL	HI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE
	FCALL	HI2CSEND
;HI2CSend 0x40
	MOVLW	64
	MOVWF	I2CBYTE
	FCALL	HI2CSEND
;For GLCDTemp = 0 to 127
	MOVLW	255
	MOVWF	GLCDTEMP
GLOBAL	SYSFORLOOP15
SYSFORLOOP15:
	INCF	GLCDTEMP,F
;Write_Transaction_Data_SSD1306(GLCDBackground)
;Macro Source: glcd_ssd1306.h (1241)
;HI2CSend SSD1306SendByte
	MOVF	GLCDBACKGROUND,W
	MOVWF	I2CBYTE
	FCALL	HI2CSEND
;Next
	MOVLW	127
	SUBWF	GLCDTEMP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOP15
GLOBAL	SYSFORLOOPEND15
SYSFORLOOPEND15:
;Close_Transaction_SSD1306
;Macro Source: glcd_ssd1306.h (1274)
;4wire not supported, see Write_Transaction_Data_SSD1306
;HI2CStop
	FCALL	HI2CSTOP
;Next
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	MOVF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	SYSWORDTEMPA
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	SYSWORDTEMPA_H
	MOVLW	63
	MOVWF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
	LJMP	SYSFORLOOP14
GLOBAL	SYSFORLOOPEND14
SYSFORLOOPEND14:
;Removed at 1.14. Retained for documentation only
;Cursor_Position_SSD1306 ( 0 , 0 )
;for SSD1306_BufferLocationCalc = 0 to GLCD_HEIGHT-1 step 8
;for GLCDTemp = 0 to 127
;Write_Data_SSD1306(GLCDBackground)
;Next
;next
;Cursor_Position_SSD1306 ( 0 , 0 )
	CLRF	LOCX
	CLRF	LOCY
	FCALL	CURSOR_POSITION_SSD1306
;PrintLocX =0
	BANKSEL	PRINTLOCX
	CLRF	PRINTLOCX
;PrintLocY =0
	CLRF	PRINTLOCY
BANKSEL	STATUS
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: WORD:WORD:STRING:, SOURCE: GLCD.H (934)
GLOBAL	GLCDPRINT32
GLCDPRINT32:
;GLCD.h Sub GLCDPrint
;Dim GLCDPrintLoc  as word
;Dim GLCDPrint_String_Counter, GLCDPrintLen as byte
;GLCDPrintLen = LCDPrintData(0)
	BANKSEL	SYSLCDPRINTDATAHANDLER
	MOVF	SYSLCDPRINTDATAHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSLCDPRINTDATAHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	GLCDPRINTLEN
	MOVWF	GLCDPRINTLEN
;If GLCDPrintLen = 0 Then Exit Sub
	MOVF	GLCDPRINTLEN,F
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	RETURN
;GLCDPrintLoc = PrintLocX
	BANKSEL	PRINTLOCX
	MOVF	PRINTLOCX,W
	BANKSEL	GLCDPRINTLOC
	MOVWF	GLCDPRINTLOC
	BANKSEL	PRINTLOCX_H
	MOVF	PRINTLOCX_H,W
	BANKSEL	GLCDPRINTLOC_H
	MOVWF	GLCDPRINTLOC_H
;Write Data
;For GLCDPrint_String_Counter = 1 To GLCDPrintLen
	CLRF	GLCDPRINT_STRING_COUNTER
	MOVLW	1
	SUBWF	GLCDPRINTLEN,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOPEND8
GLOBAL	SYSFORLOOP8
SYSFORLOOP8:
	INCF	GLCDPRINT_STRING_COUNTER,F
;GLCDDrawChar  GLCDPrintLoc, PrintLocY, LCDPrintData(GLCDPrint_String_Counter)
	MOVF	GLCDPRINTLOC,W
	MOVWF	CHARLOCX
	MOVF	GLCDPRINTLOC_H,W
	MOVWF	CHARLOCX_H
	BANKSEL	PRINTLOCY
	MOVF	PRINTLOCY,W
	BANKSEL	CHARLOCY
	MOVWF	CHARLOCY
	BANKSEL	PRINTLOCY_H
	MOVF	PRINTLOCY_H,W
	BANKSEL	CHARLOCY_H
	MOVWF	CHARLOCY_H
	MOVF	GLCDPRINT_STRING_COUNTER,W
	BANKSEL	SYSLCDPRINTDATAHANDLER
	ADDWF	SYSLCDPRINTDATAHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSLCDPRINTDATAHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	CHARCODE
	MOVWF	CHARCODE
	MOVF	GLCDFOREGROUND,W
	MOVWF	LINECOLOUR
	MOVF	GLCDFOREGROUND_H,W
	MOVWF	LINECOLOUR_H
	PAGESEL	GLCDDRAWCHAR_SSD1306
	FCALL	GLCDDRAWCHAR_SSD1306
	PAGESEL	$
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1172)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	MOVF	GLCDFONTWIDTH,W
	MOVWF	SYSBYTETEMPA
	MOVF	GLCDFNTDEFAULTSIZE,W
	MOVWF	SYSBYTETEMPB
	FCALL	SYSMULTSUB
	MOVF	SYSBYTETEMPX,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	BANKSEL	GLCDPRINTLOC
	ADDWF	GLCDPRINTLOC,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	MOVLW	0
	BANKSEL	GLCDPRINTLOC_H
	ADDWFC	GLCDPRINTLOC_H,W
	BANKSEL	SYSTEMP2_H
	MOVWF	SYSTEMP2_H
	MOVLW	1
	ADDWF	SYSTEMP2,W
	BANKSEL	GLCDPRINTLOC
	MOVWF	GLCDPRINTLOC
	MOVLW	0
	BANKSEL	SYSTEMP2_H
	ADDWFC	SYSTEMP2_H,W
	BANKSEL	GLCDPRINTLOC_H
	MOVWF	GLCDPRINTLOC_H
;Next
	MOVF	GLCDPRINTLEN,W
	SUBWF	GLCDPRINT_STRING_COUNTER,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOP8
GLOBAL	SYSFORLOOPEND8
SYSFORLOOPEND8:
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	MOVF	GLCDPRINTLOC,W
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	BANKSEL	GLCDPRINTLOC_H
	MOVF	GLCDPRINTLOC_H,W
	BANKSEL	PRINTLOCX_H
	MOVWF	PRINTLOCX_H
BANKSEL	STATUS
	RETURN

;********************************************************************************

;OVERLOADED SIGNATURE: WORD:WORD:LONG:, SOURCE: GLCD.H (1047)
GLOBAL	GLCDPRINT35
GLCDPRINT35:
;Dim SysCalcTempA As Long
;Dim GLCDPrintLoc as word
;Dim SysPrintBuffer(10)
;SysPrintBuffLen = 0
	BANKSEL	SYSPRINTBUFFLEN
	CLRF	SYSPRINTBUFFLEN
;Do
GLOBAL	SYSDOLOOP_S2
SYSDOLOOP_S2:
;Divide number by 10, remainder into buffer
;SysPrintBuffLen += 1
	BANKSEL	SYSPRINTBUFFLEN
	INCF	SYSPRINTBUFFLEN,F
;SysPrintBuffer(SysPrintBuffLen) = LCDValue % 10
	MOVLW	LOW(SYSPRINTBUFFER)
	ADDWF	SYSPRINTBUFFLEN,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	CLRF	SYSTEMP1
	MOVLW	HIGH(SYSPRINTBUFFER)
	ADDWFC	SYSTEMP1,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	BANKSEL	LCDVALUE
	MOVF	LCDVALUE,W
	MOVWF	SYSLONGTEMPA
	MOVF	LCDVALUE_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	LCDVALUE_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	LCDVALUE_E,W
	MOVWF	SYSLONGTEMPA_E
	MOVLW	10
	MOVWF	SYSLONGTEMPB
	CLRF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	FCALL	SYSDIVSUB32
	MOVF	SYSLONGTEMPX,W
MOVWF	INDF0
;LCDValue = SysCalcTempA
	MOVF	SYSCALCTEMPA,W
	MOVWF	LCDVALUE
	MOVF	SYSCALCTEMPA_H,W
	MOVWF	LCDVALUE_H
	MOVF	SYSCALCTEMPA_U,W
	MOVWF	LCDVALUE_U
	MOVF	SYSCALCTEMPA_E,W
	MOVWF	LCDVALUE_E
;Loop While LCDValue <> 0
	MOVF	LCDVALUE,W
	MOVWF	SYSLONGTEMPA
	MOVF	LCDVALUE_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	LCDVALUE_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	LCDVALUE_E,W
	MOVWF	SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB
	CLRF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
	FCALL	SYSCOMPEQUAL32
	COMF	SYSBYTETEMPX,F
	BTFSC	SYSBYTETEMPX,0
	LJMP	SYSDOLOOP_S2
GLOBAL	SYSDOLOOP_E2
SYSDOLOOP_E2:
;Display
;GLCDPrintLoc = PrintLocX
	BANKSEL	PRINTLOCX
	MOVF	PRINTLOCX,W
	BANKSEL	GLCDPRINTLOC
	MOVWF	GLCDPRINTLOC
	BANKSEL	PRINTLOCX_H
	MOVF	PRINTLOCX_H,W
	BANKSEL	GLCDPRINTLOC_H
	MOVWF	GLCDPRINTLOC_H
;For GLCDPrint_String_Counter = SysPrintBuffLen To 1 Step -1
	BANKSEL	SYSPRINTBUFFLEN
	INCF	SYSPRINTBUFFLEN,W
	BANKSEL	GLCDPRINT_STRING_COUNTER
	MOVWF	GLCDPRINT_STRING_COUNTER
	MOVLW	1
	BANKSEL	SYSPRINTBUFFLEN
	SUBWF	SYSPRINTBUFFLEN,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOPEND9
GLOBAL	SYSFORLOOP9
SYSFORLOOP9:
	BANKSEL	GLCDPRINT_STRING_COUNTER
	DECF	GLCDPRINT_STRING_COUNTER,F
;GLCDDrawChar GLCDPrintLoc, PrintLocY, SysPrintBuffer(GLCDPrint_String_Counter) + 48
	MOVF	GLCDPRINTLOC,W
	MOVWF	CHARLOCX
	MOVF	GLCDPRINTLOC_H,W
	MOVWF	CHARLOCX_H
	BANKSEL	PRINTLOCY
	MOVF	PRINTLOCY,W
	BANKSEL	CHARLOCY
	MOVWF	CHARLOCY
	BANKSEL	PRINTLOCY_H
	MOVF	PRINTLOCY_H,W
	BANKSEL	CHARLOCY_H
	MOVWF	CHARLOCY_H
	MOVLW	LOW(SYSPRINTBUFFER)
	ADDWF	GLCDPRINT_STRING_COUNTER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	MOVLW	HIGH(SYSPRINTBUFFER)
	ADDWFC	SYSTEMP1,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVLW	48
	ADDWF	INDF0,W
	BANKSEL	CHARCODE
	MOVWF	CHARCODE
	MOVF	GLCDFOREGROUND,W
	MOVWF	LINECOLOUR
	MOVF	GLCDFOREGROUND_H,W
	MOVWF	LINECOLOUR_H
	PAGESEL	GLCDDRAWCHAR_SSD1306
	FCALL	GLCDDRAWCHAR_SSD1306
	PAGESEL	$
;GLCDPrintIncrementPixelPositionMacro
;Macro Source: glcd.h (1172)
;GLCDPrintLoc = GLCDPrintLoc + ( GLCDFontWidth * GLCDfntDefaultsize )+1
	MOVF	GLCDFONTWIDTH,W
	MOVWF	SYSBYTETEMPA
	MOVF	GLCDFNTDEFAULTSIZE,W
	MOVWF	SYSBYTETEMPB
	FCALL	SYSMULTSUB
	MOVF	SYSBYTETEMPX,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	BANKSEL	GLCDPRINTLOC
	ADDWF	GLCDPRINTLOC,W
	BANKSEL	SYSTEMP2
	MOVWF	SYSTEMP2
	MOVLW	0
	BANKSEL	GLCDPRINTLOC_H
	ADDWFC	GLCDPRINTLOC_H,W
	BANKSEL	SYSTEMP2_H
	MOVWF	SYSTEMP2_H
	MOVLW	1
	ADDWF	SYSTEMP2,W
	BANKSEL	GLCDPRINTLOC
	MOVWF	GLCDPRINTLOC
	MOVLW	0
	BANKSEL	SYSTEMP2_H
	ADDWFC	SYSTEMP2_H,W
	BANKSEL	GLCDPRINTLOC_H
	MOVWF	GLCDPRINTLOC_H
;Next
	MOVF	GLCDPRINT_STRING_COUNTER,W
	SUBLW	1
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOP9
GLOBAL	SYSFORLOOPEND9
SYSFORLOOPEND9:
;Update the current X position for GLCDPrintString
;PrintLocX = GLCDPrintLoc
	BANKSEL	GLCDPRINTLOC
	MOVF	GLCDPRINTLOC,W
	BANKSEL	PRINTLOCX
	MOVWF	PRINTLOCX
	BANKSEL	GLCDPRINTLOC_H
	MOVF	GLCDPRINTLOC_H,W
	BANKSEL	PRINTLOCX_H
	MOVWF	PRINTLOCX_H
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (249)
GLOBAL	HI2CMODE
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
	LJMP	ENDIF11
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
GLOBAL	ENDIF11
ENDIF11:
;if HI2CCurrentMode = Slave then
	BANKSEL	HI2CCURRENTMODE
	MOVF	HI2CCURRENTMODE,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	LJMP	ENDIF12
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
GLOBAL	ENDIF12
ENDIF12:
;if HI2CCurrentMode = Slave10 then
	MOVLW	3
	BANKSEL	HI2CCURRENTMODE
	SUBWF	HI2CCURRENTMODE,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	LJMP	ENDIF13
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
GLOBAL	ENDIF13
ENDIF13:
;Enable I2C
;set SSPCON1.SSPEN on
BANKSEL	SSP1CON1
;B7: ASM Source was:  BSF SSP1CON1,SSPEN
	BSF	SSP1CON1,5
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (416)
GLOBAL	HI2CSEND
HI2CSEND:
;asm showdebug  This method sets the registers and register bits to send I2C data
GLOBAL	RETRYHI2CSEND
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
	FCALL	HI2CWAITMSSP
;if ACKSTAT =  1 then
BANKSEL	SSP1CON2
;B7: ASM Source was:  BTFSS SSP1CON2,ACKSTAT
	BTFSS	SSP1CON2,6
	LJMP	ELSE16_1
;HI2CAckPollState = true
	MOVLW	255
	BANKSEL	HI2CACKPOLLSTATE
	MOVWF	HI2CACKPOLLSTATE
;else
	LJMP	ENDIF16
GLOBAL	ELSE16_1
ELSE16_1:
;HI2CAckPollState = false
	BANKSEL	HI2CACKPOLLSTATE
	CLRF	HI2CACKPOLLSTATE
;end if
GLOBAL	ENDIF16
ENDIF16:
;If SSPCON1.WCOL = On Then
BANKSEL	SSP1CON1
;B7: ASM Source was:  BTFSS SSP1CON1,WCOL
	BTFSS	SSP1CON1,7
	LJMP	ENDIF17
;If HI2CCurrentMode <= 10 Then Goto RetryHI2CSend
	BANKSEL	HI2CCURRENTMODE
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	LJMP	RETRYHI2CSEND
;End If
GLOBAL	ENDIF17
ENDIF17:
;Release clock (only needed by slave)
;If HI2CCurrentMode <= 10 Then Set SSPCON1.CKP On
	BANKSEL	HI2CCURRENTMODE
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	ENDIF18
BANKSEL	SSP1CON1
;B7: ASM Source was:  BSF SSP1CON1,CKP
	BSF	SSP1CON1,4
GLOBAL	ENDIF18
ENDIF18:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (304)
GLOBAL	HI2CSTART
HI2CSTART:
;asm showdebug  This method sets the registers and register bits to generate the I2C  START signal
;If HI2CCurrentMode > 10 Then
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	LJMP	ELSE14_1
;Master_mode operational
;Set SEN On
BANKSEL	SSP1CON2
;B7: ASM Source was:  BSF SSP1CON2,SEN
	BSF	SSP1CON2,0
;HI2CWaitMSSP
BANKSEL	STATUS
	FCALL	HI2CWAITMSSP
;for device with SEN_SSP1CON2 and therefore devices including the 18FxxK40
;Else
	LJMP	ENDIF14
GLOBAL	ELSE14_1
ELSE14_1:
;Slave mode operational
;Wait Until SSPSTAT.S = On
GLOBAL	SYSWAITLOOP1
SYSWAITLOOP1:
BANKSEL	SSP1STAT
;B7: ASM Source was:  BTFSS SSP1STAT,S
	BTFSS	SSP1STAT,3
	LJMP	SYSWAITLOOP1
;End If
GLOBAL	ENDIF14
ENDIF14:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (351)
GLOBAL	HI2CSTOP
HI2CSTOP:
;Master_mode
;If HI2CCurrentMode > 10 Then
	MOVF	HI2CCURRENTMODE,W
	SUBLW	10
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	LJMP	ELSE15_1
;set SSPIE OFF; disable SSP interrupt, tested by Anobium but not implemented.
;wait while R_NOT_W = 1   'wait for completion of activities
GLOBAL	SYSWAITLOOP2
SYSWAITLOOP2:
BANKSEL	SSP1STAT
;B7: ASM Source was:  BTFSC SSP1STAT,R_NOT_W
	BTFSC	SSP1STAT,2
	LJMP	SYSWAITLOOP2
;Set SSPCON2.PEN On
;B7: ASM Source was:  BSF SSP1CON2,PEN
	BSF	SSP1CON2,2
;HI2CWaitMSSP
BANKSEL	STATUS
	FCALL	HI2CWAITMSSP
;Slave mode
;Else
	LJMP	ENDIF15
GLOBAL	ELSE15_1
ELSE15_1:
;Wait Until SSPSTAT.P = On
GLOBAL	SYSWAITLOOP3
SYSWAITLOOP3:
BANKSEL	SSP1STAT
;B7: ASM Source was:  BTFSS SSP1STAT,P
	BTFSS	SSP1STAT,4
	LJMP	SYSWAITLOOP3
;End If
GLOBAL	ENDIF15
ENDIF15:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: HWI2C.H (502)
GLOBAL	HI2CWAITMSSP
HI2CWAITMSSP:
;HI2CWaitMSSPTimeout = 0
	CLRF	HI2CWAITMSSPTIMEOUT
GLOBAL	HI2CWAITMSSPWAIT
HI2CWAITMSSPWAIT:
;HI2CWaitMSSPTimeout++
	BANKSEL	HI2CWAITMSSPTIMEOUT
	INCF	HI2CWAITMSSPTIMEOUT,F
;if HI2CWaitMSSPTimeout < 255 then
	MOVLW	255
	SUBWF	HI2CWAITMSSPTIMEOUT,W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	LJMP	ENDIF20
;'Support for SSP1IF
;if SSP1IF = 0 then goto HI2CWaitMSSPWait
BANKSEL	PIR3
;B7: ASM Source was:  BTFSS PIR3,SSP1IF
	BTFSS	PIR3,0
	LJMP	HI2CWAITMSSPWAIT
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
	LJMP	HI2CWAITMSSPWAIT
;SSPIF = 0
;B7: ASM Source was:  BCF PIR3,SSP1IF
	BCF	PIR3,0
;exit Sub
BANKSEL	STATUS
	RETURN
;end if
GLOBAL	ENDIF20
ENDIF20:
	RETURN

;********************************************************************************

;SOURCE: STRING.H (582)
GLOBAL	FN_PAD
FN_PAD:
;Check length of SysInString
;If SysInString(0) = longer or equal SysStrLen then
;give back SysInString and exit function
;If SysInString(0) < SysStrLen Then
	BANKSEL	SYSSYSINSTRINGHANDLER
	MOVF	SYSSYSINSTRINGHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	SYSSTRLEN,W
	SUBWF	INDF0,W
;B7: ASM Source was:  BTFSC STATUS, C
	BTFSC	STATUS,0
	LJMP	ELSE77_1
;SysCharCount = SysInString(0)
	MOVF	SYSSYSINSTRINGHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SYSCHARCOUNT
;clear output string
;Pad=""
	MOVLW	LOW PAD
MOVWF	FSR1L
	MOVLW	HIGH PAD
MOVWF	FSR1H
	MOVLW	LOW STRINGTABLE100
	MOVWF	SYSSTRINGA
	MOVLW	(HIGH STRINGTABLE100) & 127
	MOVWF	SYSSTRINGA_H
BANKSEL	STATUS
	FCALL	SYSREADSTRING
;Copy leftmost characters
;For SysStringTemp = 1 To SysCharCount
	BANKSEL	SYSSTRINGTEMP
	CLRF	SYSSTRINGTEMP
	MOVLW	1
	SUBWF	SYSCHARCOUNT,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOPEND20
GLOBAL	SYSFORLOOP20
SYSFORLOOP20:
	INCF	SYSSTRINGTEMP,F
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	MOVF	SYSSTRINGTEMP,W
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
	MOVLW	LOW(PAD)
	ADDWF	SYSSTRINGTEMP,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	CLRF	SYSTEMP1
	MOVLW	HIGH(PAD)
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
	LJMP	SYSFORLOOP20
GLOBAL	SYSFORLOOPEND20
SYSFORLOOPEND20:
;For SysStringTemp = SysCharCount+1 to SysStrLen
	INCF	SYSCHARCOUNT,W
	MOVWF	SYSTEMP1
	DECF	SYSTEMP1,W
	MOVWF	SYSSTRINGTEMP
	INCF	SYSCHARCOUNT,W
	MOVWF	SYSTEMP1
	MOVWF	SYSBYTETEMPB
	MOVF	SYSSTRLEN,W
	MOVWF	SYSBYTETEMPA
BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN
	BTFSC	SYSBYTETEMPX,0
	LJMP	SYSFORLOOPEND21
GLOBAL	SYSFORLOOP21
SYSFORLOOP21:
	BANKSEL	SYSSTRINGTEMP
	INCF	SYSSTRINGTEMP,F
;Pad(SysStringTemp) = SysInString3(1)
	MOVLW	1
	ADDWF	SYSSYSINSTRING3HANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSSYSINSTRING3HANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SYSARRAYTEMP2
	MOVWF	SYSARRAYTEMP1
	MOVLW	LOW(PAD)
	ADDWF	SYSSTRINGTEMP,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	CLRF	SYSTEMP1
	MOVLW	HIGH(PAD)
	ADDWFC	SYSTEMP1,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	SYSARRAYTEMP1,W
MOVWF	INDF0
;Next
	MOVF	SYSSTRLEN,W
	SUBWF	SYSSTRINGTEMP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOP21
GLOBAL	SYSFORLOOPEND21
SYSFORLOOPEND21:
;set new length to PAD
;Pad(0) = SysStrLen
	BANKSEL	SYSSTRLEN
	MOVF	SYSSTRLEN,W
	BANKSEL	SYSPAD_0
	MOVWF	SYSPAD_0
;else
	LJMP	ENDIF77
GLOBAL	ELSE77_1
ELSE77_1:
;SysInString is equal or longer than SysStrLen
;give back old string; copy SysInString to Pad
;For SysStringTemp = 1 To SysInString(0)
	CLRF	SYSSTRINGTEMP
	MOVF	SYSSYSINSTRINGHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVLW	1
	SUBWF	INDF0,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOPEND22
GLOBAL	SYSFORLOOP22
SYSFORLOOP22:
	INCF	SYSSTRINGTEMP,F
;Pad(SysStringTemp) = SysInString(SysStringTemp)
	MOVF	SYSSTRINGTEMP,W
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
	MOVLW	LOW(PAD)
	ADDWF	SYSSTRINGTEMP,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	CLRF	SYSTEMP1
	MOVLW	HIGH(PAD)
	ADDWFC	SYSTEMP1,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	SYSARRAYTEMP2,W
MOVWF	INDF0
;Next
	MOVF	SYSSYSINSTRINGHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	SUBWF	SYSSTRINGTEMP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	LJMP	SYSFORLOOP22
GLOBAL	SYSFORLOOPEND22
SYSFORLOOPEND22:
;PAD(0) = SysInString(0)
	MOVF	SYSSYSINSTRINGHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVF	SYSSYSINSTRINGHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	SYSARRAYTEMP1
	BANKSEL	SYSPAD_0
	MOVWF	SYSPAD_0
;End If
GLOBAL	ENDIF77
ENDIF77:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (875)
GLOBAL	PSET_SSD1306
PSET_SSD1306:
;Set pixel at X, Y on LCD to State
;X is 0 to 127
;Y is 0 to 63
;Origin in top left
;anything off screen with be rejected
;if GLCDX => GLCD_WIDTH OR GLCDY => GLCD_HEIGHT Then
	MOVF	GLCDX,W
	MOVWF	SYSBYTETEMPA
	MOVLW	128
	MOVWF	SYSBYTETEMPB
	FCALL	SYSCOMPLESSTHAN
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	BANKSEL	GLCDY
	MOVF	GLCDY,W
	MOVWF	SYSBYTETEMPA
	MOVLW	64
	MOVWF	SYSBYTETEMPB
	FCALL	SYSCOMPLESSTHAN
	COMF	SYSBYTETEMPX,F
	BANKSEL	SYSTEMP1
	MOVF	SYSTEMP1,W
	IORWF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP2
	BTFSS	SYSTEMP2,0
	LJMP	ENDIF54
;exit sub
BANKSEL	STATUS
	RETURN
;end if
GLOBAL	ENDIF54
ENDIF54:
;1.14 Addresses correct device horizonal page
;Is YPOS addressing the page we need?
;SSD1306_BufferLocationCalc = GLCDY
;Repeat 3
;Set C Off
;Rotate SSD1306_BufferLocationCalc Right
;End Repeat
;if SSD1306_BufferLocationCalc = _GLCDPage then
;GLCDY_Temp = ( GLCDY / 8 )* GLCD_WIDTH
;faster than /8
;GLCDY_Temp = GLCDY
	BANKSEL	GLCDY
	MOVF	GLCDY,W
	MOVWF	GLCDY_TEMP
;Repeat 3
	MOVLW	3
	BANKSEL	SYSREPEATTEMP2
	MOVWF	SYSREPEATTEMP2
GLOBAL	SYSREPEATLOOP2
SYSREPEATLOOP2:
;Set C Off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate GLCDY_Temp Right
	BANKSEL	GLCDY_TEMP
	RRF	GLCDY_TEMP,F
;End Repeat
	BANKSEL	SYSREPEATTEMP2
	DECFSZ	SYSREPEATTEMP2,F
	LJMP	SYSREPEATLOOP2
GLOBAL	SYSREPEATLOOPEND2
SYSREPEATLOOPEND2:
;if GLCDY_Temp = _GLCDPage then
	MOVF	_GLCDPAGE,W
	BANKSEL	GLCDY_TEMP
	SUBWF	GLCDY_TEMP,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	LJMP	ELSE55_1
;Mod the YPOS to get the correct pixel with the page
;GLCDY = GLCDY mod 8
	MOVF	GLCDY,W
	MOVWF	SYSBYTETEMPA
	MOVLW	8
	MOVWF	SYSBYTETEMPB
	FCALL	SYSDIVSUB
	MOVF	SYSBYTETEMPX,W
	MOVWF	GLCDY
;Else
	LJMP	ENDIF55
GLOBAL	ELSE55_1
ELSE55_1:
;Exit if not the page we are looking for
;exit sub
	RETURN
;end if
GLOBAL	ENDIF55
ENDIF55:
;buffer location in LOWMEMORY_GLCD_MODE always equals GLCDX + 1
;SSD1306_BufferLocationCalc = GLCDX + 1
	MOVLW	1
	ADDWF	GLCDX,W
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	MOVWF	SSD1306_BUFFERLOCATIONCALC
	CLRF	SSD1306_BUFFERLOCATIONCALC_H
;B7: ASM Source was:  BTFSC STATUS,C
	BTFSC	STATUS,0
	INCF	SSD1306_BUFFERLOCATIONCALC_H,F
;don't need to do these calculations for in LOWMEMORY_GLCD_MODE
;anything beyond buffer boundary?
;why? X = 127 and Y = 64 (Y is over 63!) will have passed first check....
;if SSD1306_BufferLocationCalc > GLCD_HEIGHT * GLCD_WIDTH Then
	MOVF	SSD1306_BUFFERLOCATIONCALC,W
	MOVWF	SYSWORDTEMPB
	MOVF	SSD1306_BUFFERLOCATIONCALC_H,W
	MOVWF	SYSWORDTEMPB_H
	CLRF	SYSWORDTEMPA
	MOVLW	32
	MOVWF	SYSWORDTEMPA_H
BANKSEL	STATUS
	FCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
;exit sub
	RETURN
;end if
;GLCDDataTemp = SSD1306_BufferAlias(SSD1306_BufferLocationCalc)
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	BANKSEL	GLCDDATATEMP
	MOVWF	GLCDDATATEMP
;Change data to set/clear pixel
;GLCDBitNo = GLCDY And 7
	MOVLW	7
	ANDWF	GLCDY,W
	MOVWF	GLCDBITNO
;If GLCDColour.0 = 0 Then
	BTFSC	GLCDCOLOUR,0
	LJMP	ELSE57_1
;GLCDChange = 254
	MOVLW	254
	MOVWF	GLCDCHANGE
;Set C On
;B7: ASM Source was:  BSF STATUS,C
	BSF	STATUS,0
;Else
	LJMP	ENDIF57
GLOBAL	ELSE57_1
ELSE57_1:
;GLCDChange = 1
	MOVLW	1
	MOVWF	GLCDCHANGE
;Set C Off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;End If
GLOBAL	ENDIF57
ENDIF57:
;Repeat GLCDBitNo
	MOVF	GLCDBITNO,W
	BANKSEL	SYSREPEATTEMP2
	MOVWF	SYSREPEATTEMP2
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	LJMP	SYSREPEATLOOPEND3
GLOBAL	SYSREPEATLOOP3
SYSREPEATLOOP3:
;Rotate GLCDChange Left
	BANKSEL	GLCDCHANGE
	RLF	GLCDCHANGE,F
;End Repeat
	BANKSEL	SYSREPEATTEMP2
	DECFSZ	SYSREPEATTEMP2,F
	LJMP	SYSREPEATLOOP3
GLOBAL	SYSREPEATLOOPEND3
SYSREPEATLOOPEND3:
;If GLCDColour.0 = 0 Then
	BANKSEL	GLCDCOLOUR
	BTFSC	GLCDCOLOUR,0
	LJMP	ELSE58_1
;GLCDDataTemp = GLCDDataTemp And GLCDChange
	MOVF	GLCDDATATEMP,W
	ANDWF	GLCDCHANGE,W
	MOVWF	GLCDDATATEMP
;Else
	LJMP	ENDIF58
GLOBAL	ELSE58_1
ELSE58_1:
;GLCDDataTemp = GLCDDataTemp Or GLCDChange
	MOVF	GLCDDATATEMP,W
	IORWF	GLCDCHANGE,W
	MOVWF	GLCDDATATEMP
;End If
GLOBAL	ENDIF58
ENDIF58:
;added 1.14 to isolate from full glcd mode
;restore address the correct page by adjustng the Y
;GLCDY = GLCDY + ( 8 * _GLCDPage )
	BANKSEL	_GLCDPAGE
	MOVF	_GLCDPAGE,W
	MOVWF	SYSBYTETEMPA
	MOVLW	8
	MOVWF	SYSBYTETEMPB
BANKSEL	STATUS
	FCALL	SYSMULTSUB
	MOVF	SYSBYTETEMPX,W
	BANKSEL	SYSTEMP1
	MOVWF	SYSTEMP1
	BANKSEL	GLCDY
	ADDWF	GLCDY,F
;if SSD1306_BufferAlias(SSD1306_BufferLocationCalc) <> GLCDDataTemp then
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	BANKSEL	GLCDDATATEMP
	MOVF	GLCDDATATEMP,W
	SUBWF	INDF0,W
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
	LJMP	ENDIF59
;SSD1306_BufferAlias(SSD1306_BufferLocationCalc) = GLCDDataTemp
	MOVLW	LOW(SSD1306_BUFFERALIAS)
	BANKSEL	SSD1306_BUFFERLOCATIONCALC
	ADDWF	SSD1306_BUFFERLOCATIONCALC,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	HIGH(SSD1306_BUFFERALIAS)
	ADDWFC	SSD1306_BUFFERLOCATIONCALC_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	BANKSEL	GLCDDATATEMP
	MOVF	GLCDDATATEMP,W
MOVWF	INDF0
;end if
GLOBAL	ENDIF59
ENDIF59:
;revised 1.14 to isolate from low memory mode
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2923)
GLOBAL	SYSCOMPEQUAL16
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

;SOURCE: SYSTEM.H (2977)
GLOBAL	SYSCOMPEQUAL32
SYSCOMPEQUAL32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;Test low, exit if false
;movf SysLongTempA, W
	MOVF	SYSLONGTEMPA, W
;subwf SysLongTempB, W
	SUBWF	SYSLONGTEMPB, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test high, exit if false
;movf SysLongTempA_H, W
	MOVF	SYSLONGTEMPA_H, W
;subwf SysLongTempB_H, W
	SUBWF	SYSLONGTEMPB_H, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test upper, exit if false
;movf SysLongTempA_U, W
	MOVF	SYSLONGTEMPA_U, W
;subwf SysLongTempB_U, W
	SUBWF	SYSLONGTEMPB_U, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;Test exp, exit if false
;movf SysLongTempA_E, W
	MOVF	SYSLONGTEMPA_E, W
;subwf SysLongTempB_E, W
	SUBWF	SYSLONGTEMPB_E, W
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;return
	RETURN
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3064)
GLOBAL	SYSCOMPLESSTHAN
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

;SOURCE: SYSTEM.H (3094)
GLOBAL	SYSCOMPLESSTHAN16
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
	LJMP	SCLT16TRUE
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
GLOBAL	SCLT16TRUE
SCLT16TRUE:
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (3246)
GLOBAL	SYSCOMPLESSTHANINT
SYSCOMPLESSTHANINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysDivMultA as Integer
;Clear result
;SysByteTempX = 0
	CLRF	SYSBYTETEMPX
;Compare sign bits
;-A
;If SysIntegerTempA.15 = On Then
	BTFSS	SYSINTEGERTEMPA_H,7
	LJMP	ELSE73_1
;-A, +B, return true
;If SysIntegerTempB.15 = Off Then
	BTFSC	SYSINTEGERTEMPB_H,7
	LJMP	ENDIF74
;Set SysByteTempX to 255
;SysByteTempX = Not SysByteTempX
	COMF	SYSBYTETEMPX,F
;Exit Sub
	RETURN
;End If
GLOBAL	ENDIF74
ENDIF74:
;-A, -B, negate both and swap
;SysDivMultA = -SysIntegerTempA
	COMF	SYSINTEGERTEMPA,W
	MOVWF	SYSDIVMULTA
	COMF	SYSINTEGERTEMPA_H,W
	MOVWF	SYSDIVMULTA_H
	INCF	SYSDIVMULTA,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SYSDIVMULTA_H,F
;SysIntegerTempA = -SysIntegerTempB
	COMF	SYSINTEGERTEMPB,W
	MOVWF	SYSINTEGERTEMPA
	COMF	SYSINTEGERTEMPB_H,W
	MOVWF	SYSINTEGERTEMPA_H
	INCF	SYSINTEGERTEMPA,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPA_H,F
;SysIntegerTempB = SysDivMultA
	MOVF	SYSDIVMULTA,W
	MOVWF	SYSINTEGERTEMPB
	MOVF	SYSDIVMULTA_H,W
	MOVWF	SYSINTEGERTEMPB_H
;+A
;Else
	LJMP	ENDIF73
GLOBAL	ELSE73_1
ELSE73_1:
;+A, -B, return false
;If SysIntegerTempB.15 = On Then
	BTFSC	SYSINTEGERTEMPB_H,7
;Exit Sub
	RETURN
;End If
;End If
GLOBAL	ENDIF73
ENDIF73:
;Test High, exit if more
;movf SysIntegerTempA_H,W
	MOVF	SYSINTEGERTEMPA_H,W
;subwf SysIntegerTempB_H,W
	SUBWF	SYSINTEGERTEMPB_H,W
;btfss STATUS,C
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
;return
	RETURN
;Test high, exit true if less
;movf SysIntegerTempB_H,W
	MOVF	SYSINTEGERTEMPB_H,W
;subwf SysIntegerTempA_H,W
	SUBWF	SYSINTEGERTEMPA_H,W
;btfss STATUS,C
;B7: ASM Source was:  BTFSS STATUS,C
	BTFSS	STATUS,0
;goto SCLTIntTrue
	LJMP	SCLTINTTRUE
;Test Low, exit if more or equal
;movf SysIntegerTempB,W
	MOVF	SYSINTEGERTEMPB,W
;subwf SysIntegerTempA,W
	SUBWF	SYSINTEGERTEMPA,W
;btfsc STATUS,C
;B7: ASM Source was:  BTFSC STATUS,C
	BTFSC	STATUS,0
;return
	RETURN
GLOBAL	SCLTINTTRUE
SCLTINTTRUE:
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (1305)
GLOBAL	SYSCOPYSTRING
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
	LJMP	SYSCOPYSTRINGCHECK
;When appending, add length to counter
GLOBAL	SYSCOPYSTRINGPART
SYSCOPYSTRINGPART:
;movf INDF0, W
	MOVF	INDF0, W
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;addwf SysStringLength, F
	ADDWF	SYSSTRINGLENGTH, F
GLOBAL	SYSCOPYSTRINGCHECK
SYSCOPYSTRINGCHECK:
;Exit if length = 0
;movf SysCalcTempA,F
	MOVF	SYSCALCTEMPA,F
;btfsc STATUS,Z
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
;return
	RETURN
GLOBAL	SYSSTRINGCOPY
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
	LJMP	SYSSTRINGCOPY
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2673)
GLOBAL	SYSDIVSUB
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
GLOBAL	SYSDIV8START
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
	LJMP	DIV8NOTNEG
;bcf SysByteTempA, 0
	BCF	SYSBYTETEMPA, 0
;movf SysByteTempB, W
	MOVF	SYSBYTETEMPB, W
;addwf SysByteTempX, F
	ADDWF	SYSBYTETEMPX, F
GLOBAL	DIV8NOTNEG
DIV8NOTNEG:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv8Start
	LJMP	SYSDIV8START
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2741)
GLOBAL	SYSDIVSUB16
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
	FCALL	SYSCOMPEQUAL16
	BTFSS	SYSBYTETEMPX,0
	LJMP	ENDIF89
;SysWordTempA = 0
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
;exit sub
	RETURN
;end if
GLOBAL	ENDIF89
ENDIF89:
;Main calc routine
;SysDivLoop = 16
	MOVLW	16
	MOVWF	SYSDIVLOOP
GLOBAL	SYSDIV16START
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
	LJMP	ENDIF90
;Set SysDivMultA.0 Off
	BCF	SYSDIVMULTA,0
;SysDivMultX = SysDivMultX + SysDivMultB
	MOVF	SYSDIVMULTB,W
	ADDWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTB_H,W
	ADDWFC	SYSDIVMULTX_H,F
;End If
GLOBAL	ENDIF90
ENDIF90:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv16Start
	LJMP	SYSDIV16START
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

;SOURCE: SYSTEM.H (2817)
GLOBAL	SYSDIVSUB32
SYSDIVSUB32:
;dim SysLongTempA as long
;dim SysLongTempB as long
;dim SysLongTempX as long
;#ifdef PIC
;dim SysLongDivMultA as long
;dim SysLongDivMultB as long
;dim SysLongDivMultX as long
;#endif
;SysLongDivMultA = SysLongTempA
	MOVF	SYSLONGTEMPA,W
	BANKSEL	SYSLONGDIVMULTA
	MOVWF	SYSLONGDIVMULTA
	MOVF	SYSLONGTEMPA_H,W
	MOVWF	SYSLONGDIVMULTA_H
	MOVF	SYSLONGTEMPA_U,W
	MOVWF	SYSLONGDIVMULTA_U
	MOVF	SYSLONGTEMPA_E,W
	MOVWF	SYSLONGDIVMULTA_E
;SysLongDivMultB = SysLongTempB
	MOVF	SYSLONGTEMPB,W
	MOVWF	SYSLONGDIVMULTB
	MOVF	SYSLONGTEMPB_H,W
	MOVWF	SYSLONGDIVMULTB_H
	MOVF	SYSLONGTEMPB_U,W
	MOVWF	SYSLONGDIVMULTB_U
	MOVF	SYSLONGTEMPB_E,W
	MOVWF	SYSLONGDIVMULTB_E
;SysLongDivMultX = 0
	CLRF	SYSLONGDIVMULTX
	CLRF	SYSLONGDIVMULTX_H
	CLRF	SYSLONGDIVMULTX_U
	CLRF	SYSLONGDIVMULTX_E
;Avoid division by zero
;if SysLongDivMultB = 0 then
	MOVF	SYSLONGDIVMULTB,W
	MOVWF	SYSLONGTEMPA
	MOVF	SYSLONGDIVMULTB_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	SYSLONGDIVMULTB_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	SYSLONGDIVMULTB_E,W
	MOVWF	SYSLONGTEMPA_E
	CLRF	SYSLONGTEMPB
	CLRF	SYSLONGTEMPB_H
	CLRF	SYSLONGTEMPB_U
	CLRF	SYSLONGTEMPB_E
BANKSEL	STATUS
	FCALL	SYSCOMPEQUAL32
	BTFSS	SYSBYTETEMPX,0
	LJMP	ENDIF71
;SysLongTempA = 0
	CLRF	SYSLONGTEMPA
	CLRF	SYSLONGTEMPA_H
	CLRF	SYSLONGTEMPA_U
	CLRF	SYSLONGTEMPA_E
;exit sub
	RETURN
;end if
GLOBAL	ENDIF71
ENDIF71:
;Main calc routine
;SysDivLoop = 32
	MOVLW	32
	MOVWF	SYSDIVLOOP
GLOBAL	SYSDIV32START
SYSDIV32START:
;set C off
;B7: ASM Source was:  BCF STATUS,C
	BCF	STATUS,0
;Rotate SysLongDivMultA Left
	BANKSEL	SYSLONGDIVMULTA
	RLF	SYSLONGDIVMULTA,F
	RLF	SYSLONGDIVMULTA_H,F
	RLF	SYSLONGDIVMULTA_U,F
	RLF	SYSLONGDIVMULTA_E,F
;Rotate SysLongDivMultX Left
	RLF	SYSLONGDIVMULTX,F
	RLF	SYSLONGDIVMULTX_H,F
	RLF	SYSLONGDIVMULTX_U,F
	RLF	SYSLONGDIVMULTX_E,F
;SysLongDivMultX = SysLongDivMultX - SysLongDivMultB
	MOVF	SYSLONGDIVMULTB,W
	SUBWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTB_H,W
	SUBWFB	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTB_U,W
	SUBWFB	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTB_E,W
	SUBWFB	SYSLONGDIVMULTX_E,F
;Set SysLongDivMultA.0 On
	BSF	SYSLONGDIVMULTA,0
;If C Off Then
;B7: ASM Source was:  BTFSC STATUS,C
	BTFSC	STATUS,0
	LJMP	ENDIF72
;Set SysLongDivMultA.0 Off
	BCF	SYSLONGDIVMULTA,0
;SysLongDivMultX = SysLongDivMultX + SysLongDivMultB
	MOVF	SYSLONGDIVMULTB,W
	ADDWF	SYSLONGDIVMULTX,F
	MOVF	SYSLONGDIVMULTB_H,W
	ADDWFC	SYSLONGDIVMULTX_H,F
	MOVF	SYSLONGDIVMULTB_U,W
	ADDWFC	SYSLONGDIVMULTX_U,F
	MOVF	SYSLONGDIVMULTB_E,W
	ADDWFC	SYSLONGDIVMULTX_E,F
;End If
GLOBAL	ENDIF72
ENDIF72:
;decfsz SysDivLoop, F
	DECFSZ	SYSDIVLOOP, F
;goto SysDiv32Start
	LJMP	SYSDIV32START
;SysLongTempA = SysLongDivMultA
	MOVF	SYSLONGDIVMULTA,W
	MOVWF	SYSLONGTEMPA
	MOVF	SYSLONGDIVMULTA_H,W
	MOVWF	SYSLONGTEMPA_H
	MOVF	SYSLONGDIVMULTA_U,W
	MOVWF	SYSLONGTEMPA_U
	MOVF	SYSLONGDIVMULTA_E,W
	MOVWF	SYSLONGTEMPA_E
;SysLongTempX = SysLongDivMultX
	MOVF	SYSLONGDIVMULTX,W
	MOVWF	SYSLONGTEMPX
	MOVF	SYSLONGDIVMULTX_H,W
	MOVWF	SYSLONGTEMPX_H
	MOVF	SYSLONGDIVMULTX_U,W
	MOVWF	SYSLONGTEMPX_U
	MOVF	SYSLONGDIVMULTX_E,W
	MOVWF	SYSLONGTEMPX_E
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2795)
GLOBAL	SYSDIVSUBINT
SYSDIVSUBINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	MOVF	SYSINTEGERTEMPA_H,W
	XORWF	SYSINTEGERTEMPB_H,W
	MOVWF	SYSSIGNBYTE
;If SysIntegerTempA.15 Then SysIntegerTempA = -SysIntegerTempA
	BTFSS	SYSINTEGERTEMPA_H,7
	LJMP	ENDIF68
	COMF	SYSINTEGERTEMPA,F
	COMF	SYSINTEGERTEMPA_H,F
	INCF	SYSINTEGERTEMPA,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPA_H,F
GLOBAL	ENDIF68
ENDIF68:
;If SysIntegerTempB.15 Then SysIntegerTempB = -SysIntegerTempB
	BTFSS	SYSINTEGERTEMPB_H,7
	LJMP	ENDIF69
	COMF	SYSINTEGERTEMPB,F
	COMF	SYSINTEGERTEMPB_H,F
	INCF	SYSINTEGERTEMPB,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPB_H,F
GLOBAL	ENDIF69
ENDIF69:
;Call word divide routine
;SysDivSub16
	FCALL	SYSDIVSUB16
;Negate result if necessary
;If SysSignByte.7 Then
	BTFSS	SYSSIGNBYTE,7
	LJMP	ENDIF70
;SysIntegerTempA = -SysIntegerTempA
	COMF	SYSINTEGERTEMPA,F
	COMF	SYSINTEGERTEMPA_H,F
	INCF	SYSINTEGERTEMPA,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPA_H,F
;SysIntegerTempX = -SysIntegerTempX
	COMF	SYSINTEGERTEMPX,F
	COMF	SYSINTEGERTEMPX_H,F
	INCF	SYSINTEGERTEMPX,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPX_H,F
;End If
GLOBAL	ENDIF70
ENDIF70:
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2449)
GLOBAL	SYSMULTSUB
SYSMULTSUB:
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
GLOBAL	MUL8LOOP
MUL8LOOP:
;movf SysByteTempA, W
	MOVF	SYSBYTETEMPA, W
;btfsc SysByteTempB, 0
	BTFSC	SYSBYTETEMPB, 0
;addwf SysByteTempX, F
	ADDWF	SYSBYTETEMPX, F
;bcf STATUS, C
;B7: ASM Source was:  BCF STATUS, C
	BCF	STATUS,0
;rrf SysByteTempB, F
	RRF	SYSBYTETEMPB, F
;bcf STATUS, C
;B7: ASM Source was:  BCF STATUS, C
	BCF	STATUS,0
;rlf SysByteTempA, F
	RLF	SYSBYTETEMPA, F
;movf SysByteTempB, F
	MOVF	SYSBYTETEMPB, F
;btfss STATUS, Z
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
;goto MUL8LOOP
	LJMP	MUL8LOOP
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2496)
GLOBAL	SYSMULTSUB16
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
GLOBAL	MUL16LOOP
MUL16LOOP:
;IF SysDivMultB.0 ON then SysDivMultX += SysDivMultA
	BTFSS	SYSDIVMULTB,0
	LJMP	ENDIF87
	MOVF	SYSDIVMULTA,W
	ADDWF	SYSDIVMULTX,F
	MOVF	SYSDIVMULTA_H,W
	ADDWFC	SYSDIVMULTX_H,F
GLOBAL	ENDIF87
ENDIF87:
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
	FCALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
	LJMP	MUL16LOOP
;SysWordTempX = SysDivMultX
	MOVF	SYSDIVMULTX,W
	MOVWF	SYSWORDTEMPX
	MOVF	SYSDIVMULTX_H,W
	MOVWF	SYSWORDTEMPX_H
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2594)
GLOBAL	SYSMULTSUBINT
SYSMULTSUBINT:
;Dim SysIntegerTempA, SysIntegerTempB, SysIntegerTempX As Integer
;Dim SysSignByte As Byte
;Make both inputs positive, decide output type
;SysSignByte = SysIntegerTempA_H xor SysIntegerTempB_H
	MOVF	SYSINTEGERTEMPA_H,W
	XORWF	SYSINTEGERTEMPB_H,W
	MOVWF	SYSSIGNBYTE
;if SysIntegerTempA.15 then SysIntegerTempA = -SysIntegerTempA
	BTFSS	SYSINTEGERTEMPA_H,7
	LJMP	ENDIF65
	COMF	SYSINTEGERTEMPA,F
	COMF	SYSINTEGERTEMPA_H,F
	INCF	SYSINTEGERTEMPA,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPA_H,F
GLOBAL	ENDIF65
ENDIF65:
;if SysIntegerTempB.15 then SysIntegerTempB = -SysIntegerTempB
	BTFSS	SYSINTEGERTEMPB_H,7
	LJMP	ENDIF66
	COMF	SYSINTEGERTEMPB,F
	COMF	SYSINTEGERTEMPB_H,F
	INCF	SYSINTEGERTEMPB,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPB_H,F
GLOBAL	ENDIF66
ENDIF66:
;Call word multiply routine
;SysMultSub16
	FCALL	SYSMULTSUB16
;Negate result if necessary
;if SysSignByte.7 then SysIntegerTempX = -SysIntegerTempX
	BTFSS	SYSSIGNBYTE,7
	LJMP	ENDIF67
	COMF	SYSINTEGERTEMPX,F
	COMF	SYSINTEGERTEMPX_H,F
	INCF	SYSINTEGERTEMPX,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SYSINTEGERTEMPX_H,F
GLOBAL	ENDIF67
ENDIF67:
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (1502)
GLOBAL	SYSREADSTRING
SYSREADSTRING:
;Dim SysCalcTempA As Byte
;Dim SysStringLength As Byte
;Get length
;call SysStringTables
	FCALL	SYSSTRINGTABLES
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;movwf INDF1
MOVWF	INDF1
;goto SysStringReadCheck
	LJMP	SYSSTRINGREADCHECK
GLOBAL	SYSREADSTRINGPART
SYSREADSTRINGPART:
;Get length
;call SysStringTables
	FCALL	SYSSTRINGTABLES
;movwf SysCalcTempA
	MOVWF	SYSCALCTEMPA
;addwf SysStringLength,F
	ADDWF	SYSSTRINGLENGTH,F
;Check length
GLOBAL	SYSSTRINGREADCHECK
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
GLOBAL	SYSSTRINGREAD
SYSSTRINGREAD:
;Get char
;call SysStringTables
	FCALL	SYSSTRINGTABLES
;Set char
;addfsr 1,1
	ADDFSR	1,1
;movwf INDF1
MOVWF	INDF1
;decfsz SysCalcTempA, F
	DECFSZ	SYSCALCTEMPA, F
;goto SysStringRead
	LJMP	SYSSTRINGREAD
	RETURN

;********************************************************************************

GLOBAL	SYSSTRINGTABLES
SYSSTRINGTABLES:
	MOVF	SYSSTRINGA_H,W
MOVWF	PCLATH
	MOVF	SYSSTRINGA,W
	INCF	SYSSTRINGA,F
;B7: ASM Source was:  BTFSC STATUS,Z
	BTFSC	STATUS,2
	INCF	SYSSTRINGA_H,F
MOVWF	PCL

GLOBAL	STRINGTABLE1
STRINGTABLE1:
	RETLW	15
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

	ALIGN	2;X3

GLOBAL	STRINGTABLE2
STRINGTABLE2:
	RETLW	12
	RETLW	65	;A
	RETLW	110	;N
	RETLW	111	;O
	RETLW	98	;B
	RETLW	105	;I
	RETLW	117	;U
	RETLW	109	;M
	RETLW	32	;
	RETLW	50	;2
	RETLW	48	;0
	RETLW	50	;2
	RETLW	49	;1

	ALIGN	2;X3

GLOBAL	STRINGTABLE3
STRINGTABLE3:
	RETLW	1
	RETLW	42	;*

	ALIGN	2;X3

GLOBAL	STRINGTABLE4
STRINGTABLE4:
	RETLW	15
	RETLW	86	;V
	RETLW	101	;E
	RETLW	114	;R
	RETLW	115	;S
	RETLW	105	;I
	RETLW	111	;O
	RETLW	110	;N
	RETLW	32	;
	RETLW	48	;0
	RETLW	46	;.
	RETLW	57	;9
	RETLW	56	;8
	RETLW	46	;.
	RETLW	48	;0
	RETLW	55	;7

	ALIGN	2;X3

GLOBAL	STRINGTABLE5
STRINGTABLE5:
	RETLW	12
	RETLW	76	;L
	RETLW	77	;M
	RETLW	32	;
	RETLW	71	;G
	RETLW	76	;L
	RETLW	67	;C
	RETLW	68	;D
	RETLW	32	;
	RETLW	77	;M
	RETLW	79	;O
	RETLW	68	;D
	RETLW	69	;E

	ALIGN	2;X3

GLOBAL	STRINGTABLE6
STRINGTABLE6:
	RETLW	21
	RETLW	71	;G
	RETLW	76	;L
	RETLW	67	;C
	RETLW	68	;D
	RETLW	95	;_
	RETLW	66	;B
	RETLW	117	;U
	RETLW	102	;F
	RETLW	102	;F
	RETLW	101	;E
	RETLW	114	;R
	RETLW	61	; (EQUALS)
	RETLW	49	;1
	RETLW	50	;2
	RETLW	56	;8
	RETLW	32	;
	RETLW	98	;B
	RETLW	121	;Y
	RETLW	116	;T
	RETLW	101	;E
	RETLW	115	;S

	ALIGN	2;X3

GLOBAL	STRINGTABLE8
STRINGTABLE8:
	RETLW	8
	RETLW	80	;P
	RETLW	114	;R
	RETLW	105	;I
	RETLW	110	;N
	RETLW	116	;T
	RETLW	83	;S
	RETLW	116	;T
	RETLW	114	;R

	ALIGN	2;X3

GLOBAL	STRINGTABLE9
STRINGTABLE9:
	RETLW	1
	RETLW	64	;

	ALIGN	2;X3

GLOBAL	STRINGTABLE10
STRINGTABLE10:
	RETLW	3
	RETLW	77	;M
	RETLW	104	;H
	RETLW	122	;Z

	ALIGN	2;X3

GLOBAL	STRINGTABLE11
STRINGTABLE11:
	RETLW	7
	RETLW	68	;D
	RETLW	114	;R
	RETLW	97	;A
	RETLW	119	;W
	RETLW	83	;S
	RETLW	116	;T
	RETLW	114	;R

	ALIGN	2;X3

GLOBAL	STRINGTABLE12
STRINGTABLE12:
	RETLW	1
	RETLW	61	; (EQUALS)

	ALIGN	2;X3

GLOBAL	STRINGTABLE67
STRINGTABLE67:
	RETLW	1
	RETLW	32	;

	ALIGN	2;X3

GLOBAL	STRINGTABLE100
STRINGTABLE100:
	RETLW	0

	ALIGN	2;X3

;********************************************************************************

;SOURCE: GLCD_SSD1306.H (216)
GLOBAL	WRITE_COMMAND_SSD1306
WRITE_COMMAND_SSD1306:
;HI2CStart
	FCALL	HI2CSTART
;HI2CSend GLCD_I2C_Address
	MOVLW	120
	MOVWF	I2CBYTE
	FCALL	HI2CSEND
;HI2CSend 0x00
	CLRF	I2CBYTE
	FCALL	HI2CSEND
;HI2CSend SSD1306SendByte
	BANKSEL	SSD1306SENDBYTE
	MOVF	SSD1306SENDBYTE,W
	BANKSEL	I2CBYTE
	MOVWF	I2CBYTE
	FCALL	HI2CSEND
;HI2CStop
	LJMP	HI2CSTOP

;********************************************************************************

;START OF PROGRAM MEMORY PAGE 2
	ORG	4096
;START OF PROGRAM MEMORY PAGE 3
	ORG	6144
	ALIGN	2;X2
;
; Declare Power-On-Reset entry point
;
 END     RESETVEC
