;Program compiled by Great Cow BASIC (0.98.<<>> 2021-02-09 (Windows 64 bit)) for Microchip PIC-AS
;Need help? See the GCBASIC forums at http://sourceforge.net/projects/gcbasic/forums,
;check the documentation or email evan+picas at anobium  dot co dot uk.

;********************************************************************************


;Set up the assembler options (Chip type, clock source, other bits and pieces)
;PROCESSOR   16F18855
 PAGEWIDTH   132
 RADIX       DEC
 TITLE       "D:\GCB@Syn39\GreatCowBasic\Demos\vendor_boards\mplab_xpress_board_pic16f18855\29_ws2812_led_using_clcorbitbanging.S"
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
 ADREADPORT                       EQU 32                    ; 0X20
 COLORARRAY                       EQU 9179                    ; 0X23DB
 COLOROFLED                       EQU 33                    ; 0X21
 COLOROFLED_E                     EQU 36                    ; 0X24
 COLOROFLED_H                     EQU 34                    ; 0X22
 COLOROFLED_U                     EQU 35                    ; 0X23
 COLORTOSEND                      EQU 37                    ; 0X25
 COLORTOSEND_E                    EQU 40                    ; 0X28
 COLORTOSEND_H                    EQU 38                    ; 0X26
 COLORTOSEND_U                    EQU 39                    ; 0X27
 CURRENTADDESSEDLED               EQU 41                    ; 0X29
 CURRENTLEDCOLORSEQUENCE          EQU 42                    ; 0X2A
 DELAYTEMP                        EQU 112                    ; 0X70
 DELAYTEMP2                       EQU 113                    ; 0X71
 ELEMENTPOINTER                   EQU 43                    ; 0X2B
 ELEMENTVALUE                     EQU 44                    ; 0X2C
 ELEMENTVALUE_E                   EQU 47                    ; 0X2F
 ELEMENTVALUE_H                   EQU 45                    ; 0X2D
 ELEMENTVALUE_U                   EQU 46                    ; 0X2E
 GETLONGARRAYVALUEHANDLER         EQU 48                    ; 0X30
 GETLONGARRAYVALUEHANDLER_E       EQU 51                    ; 0X33
 GETLONGARRAYVALUEHANDLER_H       EQU 49                    ; 0X31
 GETLONGARRAYVALUEHANDLER_U       EQU 50                    ; 0X32
 LEDDISPLAYSTATE                  EQU 52                    ; 0X34
 MYDELAY                          EQU 53                    ; 0X35
 MYDELAY_H                        EQU 54                    ; 0X36
 PIXELCOUNT                       EQU 55                    ; 0X37
 READAD10                         EQU 56                    ; 0X38
 READAD10_H                       EQU 57                    ; 0X39
 SWITCHSTATE                      EQU 58                    ; 0X3A
 SYSADDRESSARRAYHANDLER           EQU 59                    ; 0X3B
 SYSADDRESSARRAYHANDLER_H         EQU 60                    ; 0X3C
 SYSBITVAR0                       EQU 61                    ; 0X3D
 SYSBYTETEMPA                     EQU 117                    ; 0X75
 SYSBYTETEMPB                     EQU 121                    ; 0X79
 SYSBYTETEMPX                     EQU 112                    ; 0X70
 SYSDIVLOOP                       EQU 116                    ; 0X74
 SYSTEMP1                         EQU 62                    ; 0X3E
 SYSTEMP2                         EQU 63                    ; 0X3F
 SYSWAITTEMP10US                  EQU 117                    ; 0X75
 SYSWAITTEMPMS                    EQU 114                    ; 0X72
 SYSWAITTEMPMS_H                  EQU 115                    ; 0X73
 SYSWORDTEMPA                     EQU 117                    ; 0X75
 SYSWORDTEMPA_H                   EQU 118                    ; 0X76
 SYSWORDTEMPB                     EQU 121                    ; 0X79
 SYSWORDTEMPB_H                   EQU 122                    ; 0X7A
 TMRNUMBER                        EQU 64                    ; 0X40
 XLOOP                            EQU 65                    ; 0X41
 XYLONARRAY                       EQU 9172                    ; 0X23D4
 XYLONELEMENTVALUE                EQU 66                    ; 0X42
 YLOOP                            EQU 67                    ; 0X43

;********************************************************************************

;ALIAS VARIABLES
 AFSR0                            EQU 4
 AFSR0_H                          EQU 5
 SYSREADAD10WORD                  EQU 56
 SYSREADAD10WORD_H                EQU 57
 SYSXYLONARRAY_1                  EQU 1589
 SYSXYLONARRAY_2                  EQU 1590
 SYSXYLONARRAY_3                  EQU 1591
 SYSXYLONARRAY_4                  EQU 1592
 SYSXYLONARRAY_5                  EQU 1593
 SYSXYLONARRAY_6                  EQU 1594

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

;START OF THE MAIN PROGRAM
;''A demonstration of Great Cow BASIC supporting the WS2812 LED devices.
;''
;''This demonstration contains three operational demonstrations, and two methods of driving the WS2812 LEDs.
;''
;''    The demos have a speed control using the Pot. This adjusts the timing.
;''
;''     Demos:
;''         1. Chaser - LED chaser
;''         2. Flash All LEDs
;''         3. Xylon Chaser, also known as Knight Rider
;''
;''     Methods of driving the WS2812:
;''         1. CLC approach using the Microchip Configurable Logic Cells (CLC) to create a specialised SPI signal in terms of timing
;''         2. Bit Banging a SPI signal, again in terms of timing.
;''
;''
;''     Operation:
;''         By default the Chaser (#1) will be operational when applying power to the microcontroller and the WS2812 LEDs.
;''         Pressing the Switch will change the operational to the Flash All LEDs (#2), pressing the Switch again with return to Chaser operation.
;''         To select the Xylon Chase press the switch when applying power to the microcontroller and the WS2812 LEDs.
;''
;''     Selecting the method of generating the specialised SPI signal:
;''         Using the Microchip CLC method as detailed in AN1606.
;''             This method can be selected by defining the constants as follows.
;''                 #define UseWS2812PWMSendData
;''                 #define WS2812SendData WS2812PWMSendData
;''         Using the bit Banging method.
;''             This method can be selected by defining the constants as follows.
;''                 #define UseWS2812BitBangSendData
;''                 #define WS2812SendData WS2812BitBangSendData
;''
;''         These are mutually exclusive - choose either CLC or Bit Banging, define the TWO constants.  The constants ensure the code is configured correctly.
;''
;''     Configuration:
;''         WS2812 DIN is connected to PORTC.7.
;''         Pot is connected to PORTA.4
;''         Switch is pulled high and connected to PORTA.5
;''
;''
;''     General commentary:
;''         The use of CLC is detailed in AN1606. Please review this document.
;''         The timing of the WS2812 is absolutely critical.  Please review the WS2812 datasheet for the specific timing that are required.
;''
;''         The Chaser demonstration simply writes to the WS2812 (for the number of LEDs) and indexes through the LEDS enabling the select color on each pass through the sequence.
;''         The Flash ALL LEDS simply writes to all the LEDS the same color.
;''         The Xylon chaser uses an ARRAY to hold the pattern. When a bit in 1 then the LEDs with be turn on.
;''
;''     This demonstration can be further developed - have fun.
;''
;''
;''************************************************************************
;''
;''PIC: 16F18855
;''Compiler: GCB
;''IDE: GCB@SYN
;''Board: Xpress Evaluation Board
;''
;''@author     EvanV
;''@licence    GPL
;''@version    1.00
;''@date       17.08.2016
;''********************************************************************************
;''
;----- Configuration
;Chip Settings.
SETUP:
;#DEFINE UseWS2812PWMSendData
;#DEFINE WS2812SendData WS2812PWMSendData
;#define UseWS2812BitBangSendData
;#define WS2812SendData WS2812BitBangSendData
;#DEFINE DoTracer
;#DEFINE DoXyLon
;----- Define Hardware settings
;Set the PPS of the microcontroller
;Set the PPS for this solution.
;-------------------LATC-----------------
;Bit#:  -7---6---5---4---3---2---1---0---
;|PWM|-----------------------------
;------|DIN|-----------------------------
;
;----- Constants
;#DEFINE USART_BAUD_RATE 115200
;#DEFINE USART_TX_BLOCKING
;STANDARD XPRESS BOARD CONSTANTS
;#DEFINE LEDD2  PORTA.0
;#DEFINE LEDD3  PORTA.1
;#DEFINE LEDD4  PORTA.2
;#DEFINE LEDD5  PORTA.3
;Dir    LEDD2 Out
	BCF	TRISA,0
;Dir    LEDD3 Out
	BCF	TRISA,1
;Dir    LEDD4 Out
	BCF	TRISA,2
;Dir    LEDD5 Out
	BCF	TRISA,3
;#DEFINE Potentiometer      PORTA.4
;Dir      Potentiometer In
	BSF	TRISA,4
;#DEFINE SWITCH_DOWN         0
;#DEFINE SWITCH_UP           1
;#DEFINE SWITCH             PORTA.5
;Dir    SWITCH              In
	BSF	TRISA,5
;WS2812 SPECIFIC CONSTANTS
;#DEFINE DIN PORTC.7
;Dir     DIN Out
	BCF	TRISC,7
;#DEFINE SSPOutRegister SSP1BUF
;----- Variables
;Dim YLOOP, PIXELCOUNT, XLOOP, XYLONELEMENTVALUE, LEDDISPLAYSTATE, SWITCHSTATE As Byte
;Number of WS2812 LEDs
;PixelCount = 8
	MOVLW	8
	MOVWF	PIXELCOUNT
;Color to send to LEDs 6 byte  color address
;ColorofLED = 0
	CLRF	COLOROFLED
	CLRF	COLOROFLED_H
	CLRF	COLOROFLED_U
	CLRF	COLOROFLED_E
;Curent LED being address - between 1 and the PixelCount
;CurrentAddessedLED = 1
	MOVLW	1
	MOVWF	CURRENTADDESSEDLED
;Current LED sequence pointer. Simply points to the array of colors
;CurrentLEDColorSequence = 0
	CLRF	CURRENTLEDCOLORSEQUENCE
;LEDDisplayState = 0 or 1.  0 = LEDs addressed is sequence 1-2-3-4 etc OR 1 = ALL on 'not' sequential
;LEDDisplayState = 1
	MOVLW	1
	MOVWF	LEDDISPLAYSTATE
;State of the switch tracker.  Toggle LEDDisplayState 1 | 0
;SwitchState = SWITCH_UP
	MOVLW	1
	MOVWF	SWITCHSTATE
;Dim CurrentAddessedLED, CurrentLEDColorSequence As Byte
;Dim ColortoSend, ColorofLED As Long
;----- Main body of program commences here.
MAINCODE:
;WS2812_Init
	CALL	WS2812_INIT
;If SWITCH = SWITCH_DOWN Then
	BTFSC	PORTA,5
	GOTO	ELSE1_1
;Data array of Xylon LEDs
;#DEFINE XyLonSteps  6
;Dim XyLonArray( XyLonSteps )
;XyLonArray(1)  = 0b10000001
	MOVLW	129
	BANKSEL	SYSXYLONARRAY_1
	MOVWF	SYSXYLONARRAY_1
;XyLonArray(2)  = 0b01000010
	MOVLW	66
	MOVWF	SYSXYLONARRAY_2
;XyLonArray(3)  = 0b00100100
	MOVLW	36
	MOVWF	SYSXYLONARRAY_3
;XyLonArray(4)  = 0b00011000
	MOVLW	24
	MOVWF	SYSXYLONARRAY_4
;XyLonArray(5)  = 0b00100100
	MOVLW	36
	MOVWF	SYSXYLONARRAY_5
;XyLonArray(6)  = 0b01000010
	MOVLW	66
	MOVWF	SYSXYLONARRAY_6
;Do
SYSDOLOOP_S1:
;Send data
;For yloop =1 To XyLonSteps
	BANKSEL	YLOOP
	CLRF	YLOOP
SYSFORLOOP1:
	INCF	YLOOP,F
;XyLonElementValue = XyLonArray(yloop)
	MOVLW	LOW(XYLONARRAY)
	ADDWF	YLOOP,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	CLRF	SYSTEMP1
	MOVLW	HIGH(XYLONARRAY)
	ADDWFC	SYSTEMP1,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	XYLONELEMENTVALUE
;For xloop = 1 To PixelCount
	CLRF	XLOOP
	MOVLW	1
	SUBWF	PIXELCOUNT,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOPEND2
SYSFORLOOP2:
	INCF	XLOOP,F
;If XyLonElementValue.7 = 1 Then
	BTFSS	XYLONELEMENTVALUE,7
	GOTO	ELSE3_1
;Red
;ColortoSend = 0x00ff00
	CLRF	COLORTOSEND
	MOVLW	255
	MOVWF	COLORTOSEND_H
	CLRF	COLORTOSEND_U
	CLRF	COLORTOSEND_E
;Else
	GOTO	ENDIF3
ELSE3_1:
;black
;ColortoSend = 0
	CLRF	COLORTOSEND
	CLRF	COLORTOSEND_H
	CLRF	COLORTOSEND_U
	CLRF	COLORTOSEND_E
;End If
ENDIF3:
;Send the data - either to the CLC or bit banging
;WS2812SendData ( ColortoSend )
	CALL	WS2812PWMSENDDATA
;Rotate XyLonElementValue Left
	RLF	XYLONELEMENTVALUE,F
;Next
	MOVF	PIXELCOUNT,W
	SUBWF	XLOOP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP2
SYSFORLOOPEND2:
;The minimum delay is 50us. This will SURELY never happen....
;Dim mydelay As Word
;mydelay =  ReadAD10( AN4 )
	MOVLW	4
	MOVWF	ADREADPORT
	CALL	FN_READAD1013
	MOVF	SYSREADAD10WORD,W
	MOVWF	MYDELAY
	MOVF	SYSREADAD10WORD_H,W
	MOVWF	MYDELAY_H
;If mydelay > 0 Then
	MOVF	MYDELAY,W
	MOVWF	SYSWORDTEMPB
	MOVF	MYDELAY_H,W
	MOVWF	SYSWORDTEMPB_H
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ELSE5_1
;Wait mydelay ms
	MOVF	MYDELAY,W
	MOVWF	SYSWAITTEMPMS
	MOVF	MYDELAY_H,W
	MOVWF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;Else
	GOTO	ENDIF5
ELSE5_1:
;Wait While ReadAD10( AN4 ) = 0
SYSWAITLOOP1:
	MOVLW	4
	MOVWF	ADREADPORT
	CALL	FN_READAD1013
	MOVF	SYSREADAD10WORD,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSREADAD10WORD_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	BTFSC	SYSBYTETEMPX,0
	GOTO	SYSWAITLOOP1
;End If
ENDIF5:
;If mydelay > 1015 Then
	MOVF	MYDELAY,W
	MOVWF	SYSWORDTEMPB
	MOVF	MYDELAY_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVLW	247
	MOVWF	SYSWORDTEMPA
	MOVLW	3
	MOVWF	SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF6
;Do
SYSDOLOOP_S2:
;Loop While ReadAD10( AN4 ) > 1000
	MOVLW	4
	MOVWF	ADREADPORT
	CALL	FN_READAD1013
	MOVF	SYSREADAD10WORD,W
	MOVWF	SYSWORDTEMPB
	MOVF	SYSREADAD10WORD_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVLW	232
	MOVWF	SYSWORDTEMPA
	MOVLW	3
	MOVWF	SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
	GOTO	SYSDOLOOP_S2
SYSDOLOOP_E2:
;End If
ENDIF6:
;Next
	MOVLW	6
	SUBWF	YLOOP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP1
SYSFORLOOPEND1:
;Loop
	GOTO	SYSDOLOOP_S1
SYSDOLOOP_E1:
;Else
	GOTO	ENDIF1
ELSE1_1:
;Set of colors stored in an array for simplicity - they can be addressed with a pointer.
;5 long element in the array = 5 * 4 = 20
;Dim colorArray( 20)
;Set the values of the array to the colors.  Five colors are defined. You can add more.....
;RED
;SetLongArrayValueHandler ( colorArray, 0, 0x00FF00 )
	MOVLW	LOW COLORARRAY
	MOVWF	SYSADDRESSARRAYHANDLER
	MOVLW	HIGH COLORARRAY
	MOVWF	SYSADDRESSARRAYHANDLER_H
	CLRF	ELEMENTPOINTER
	CLRF	ELEMENTVALUE
	MOVLW	255
	MOVWF	ELEMENTVALUE_H
	CLRF	ELEMENTVALUE_U
	CLRF	ELEMENTVALUE_E
	CALL	SETLONGARRAYVALUEHANDLER
;yellow
;SetLongArrayValueHandler ( colorArray, 1, 0xFFFF00 )
	MOVLW	LOW COLORARRAY
	MOVWF	SYSADDRESSARRAYHANDLER
	MOVLW	HIGH COLORARRAY
	MOVWF	SYSADDRESSARRAYHANDLER_H
	MOVLW	1
	MOVWF	ELEMENTPOINTER
	CLRF	ELEMENTVALUE
	MOVLW	255
	MOVWF	ELEMENTVALUE_H
	MOVWF	ELEMENTVALUE_U
	CLRF	ELEMENTVALUE_E
	CALL	SETLONGARRAYVALUEHANDLER
;GREEN
;SetLongArrayValueHandler ( colorArray, 2, 0xFF0000 )
	MOVLW	LOW COLORARRAY
	MOVWF	SYSADDRESSARRAYHANDLER
	MOVLW	HIGH COLORARRAY
	MOVWF	SYSADDRESSARRAYHANDLER_H
	MOVLW	2
	MOVWF	ELEMENTPOINTER
	CLRF	ELEMENTVALUE
	CLRF	ELEMENTVALUE_H
	MOVLW	255
	MOVWF	ELEMENTVALUE_U
	CLRF	ELEMENTVALUE_E
	CALL	SETLONGARRAYVALUEHANDLER
;WHITE
;SetLongArrayValueHandler ( colorArray, 3, 0xFFFFFF )
	MOVLW	LOW COLORARRAY
	MOVWF	SYSADDRESSARRAYHANDLER
	MOVLW	HIGH COLORARRAY
	MOVWF	SYSADDRESSARRAYHANDLER_H
	MOVLW	3
	MOVWF	ELEMENTPOINTER
	MOVLW	255
	MOVWF	ELEMENTVALUE
	MOVWF	ELEMENTVALUE_H
	MOVWF	ELEMENTVALUE_U
	CLRF	ELEMENTVALUE_E
	CALL	SETLONGARRAYVALUEHANDLER
;BLACK
;SetLongArrayValueHandler ( colorArray, 4, 0x000000 )
	MOVLW	LOW COLORARRAY
	MOVWF	SYSADDRESSARRAYHANDLER
	MOVLW	HIGH COLORARRAY
	MOVWF	SYSADDRESSARRAYHANDLER_H
	MOVLW	4
	MOVWF	ELEMENTPOINTER
	CLRF	ELEMENTVALUE
	CLRF	ELEMENTVALUE_H
	CLRF	ELEMENTVALUE_U
	CLRF	ELEMENTVALUE_E
	CALL	SETLONGARRAYVALUEHANDLER
;Do
SYSDOLOOP_S3:
;This gets the long value of color from the array - CurrentLEDColorSequence is a index into the array
;ColorofLED = GetLongArrayValueHandler ( ColorArray, CurrentLEDColorSequence )
	MOVLW	LOW COLORARRAY
	MOVWF	SYSADDRESSARRAYHANDLER
	MOVLW	HIGH COLORARRAY
	MOVWF	SYSADDRESSARRAYHANDLER_H
	MOVF	CURRENTLEDCOLORSEQUENCE,W
	MOVWF	ELEMENTPOINTER
	CALL	FN_GETLONGARRAYVALUEHANDLER
	MOVF	GETLONGARRAYVALUEHANDLER,W
	MOVWF	COLOROFLED
	MOVF	GETLONGARRAYVALUEHANDLER_H,W
	MOVWF	COLOROFLED_H
	MOVF	GETLONGARRAYVALUEHANDLER_U,W
	MOVWF	COLOROFLED_U
	MOVF	GETLONGARRAYVALUEHANDLER_E,W
	MOVWF	COLOROFLED_E
;first loop - as we interate through the first loop to get the tracer display working
;For yloop = 1 To PixelCount
	CLRF	YLOOP
	MOVLW	1
	SUBWF	PIXELCOUNT,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOPEND3
SYSFORLOOP3:
	INCF	YLOOP,F
;second loop - loop sends data to the LEDs
;For xloop = 1 To PixelCount
	CLRF	XLOOP
	MOVLW	1
	SUBWF	PIXELCOUNT,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOPEND4
SYSFORLOOP4:
	INCF	XLOOP,F
;Set the color or set to black
;If xloop = CurrentAddessedLED Then
	MOVF	CURRENTADDESSEDLED,W
	SUBWF	XLOOP,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ELSE10_1
;ColortoSend = ColorofLED
	MOVF	COLOROFLED,W
	MOVWF	COLORTOSEND
	MOVF	COLOROFLED_H,W
	MOVWF	COLORTOSEND_H
	MOVF	COLOROFLED_U,W
	MOVWF	COLORTOSEND_U
	MOVF	COLOROFLED_E,W
	MOVWF	COLORTOSEND_E
;Else
	GOTO	ENDIF10
ELSE10_1:
;If LEDDisplayState = 1 Then
	DECF	LEDDISPLAYSTATE,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ELSE17_1
;black
;ColortoSend = 0x000000
	CLRF	COLORTOSEND
	CLRF	COLORTOSEND_H
	CLRF	COLORTOSEND_U
	CLRF	COLORTOSEND_E
;Else
	GOTO	ENDIF17
ELSE17_1:
;This has to reset here... why? As the output function destroys the long value when ROTATING the number.
;ColortoSend = ColorofLED
	MOVF	COLOROFLED,W
	MOVWF	COLORTOSEND
	MOVF	COLOROFLED_H,W
	MOVWF	COLORTOSEND_H
	MOVF	COLOROFLED_U,W
	MOVWF	COLORTOSEND_U
	MOVF	COLOROFLED_E,W
	MOVWF	COLORTOSEND_E
;End If
ENDIF17:
;End If
ENDIF10:
;Send the data - either to the CLC or bit banging
;WS2812SendData ( ColortoSend )
	CALL	WS2812PWMSENDDATA
;Next
	MOVF	PIXELCOUNT,W
	SUBWF	XLOOP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP4
SYSFORLOOPEND4:
;Increment the LED being addressed
;CurrentAddessedLED++
	INCF	CURRENTADDESSEDLED,F
;The minimum delay is 50us. This will SURELY never happen....
;Dim mydelay As Word
;mydelay =  ReadAD10( AN4 )
	MOVLW	4
	MOVWF	ADREADPORT
	CALL	FN_READAD1013
	MOVF	SYSREADAD10WORD,W
	MOVWF	MYDELAY
	MOVF	SYSREADAD10WORD_H,W
	MOVWF	MYDELAY_H
;If mydelay > 0 Then
	MOVF	MYDELAY,W
	MOVWF	SYSWORDTEMPB
	MOVF	MYDELAY_H,W
	MOVWF	SYSWORDTEMPB_H
	CLRF	SYSWORDTEMPA
	CLRF	SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ELSE12_1
;Wait mydelay ms
	MOVF	MYDELAY,W
	MOVWF	SYSWAITTEMPMS
	MOVF	MYDELAY_H,W
	MOVWF	SYSWAITTEMPMS_H
	CALL	DELAY_MS
;Else
	GOTO	ENDIF12
ELSE12_1:
;Wait While ReadAD10( AN4 ) = 0
SYSWAITLOOP2:
	MOVLW	4
	MOVWF	ADREADPORT
	CALL	FN_READAD1013
	MOVF	SYSREADAD10WORD,W
	MOVWF	SYSWORDTEMPA
	MOVF	SYSREADAD10WORD_H,W
	MOVWF	SYSWORDTEMPA_H
	CLRF	SYSWORDTEMPB
	CLRF	SYSWORDTEMPB_H
	CALL	SYSCOMPEQUAL16
	BTFSC	SYSBYTETEMPX,0
	GOTO	SYSWAITLOOP2
;End If
ENDIF12:
;If mydelay > 1015 Then
	MOVF	MYDELAY,W
	MOVWF	SYSWORDTEMPB
	MOVF	MYDELAY_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVLW	247
	MOVWF	SYSWORDTEMPA
	MOVLW	3
	MOVWF	SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSS	SYSBYTETEMPX,0
	GOTO	ENDIF13
;Do
SYSDOLOOP_S4:
;Loop While ReadAD10( AN4 ) > 1000
	MOVLW	4
	MOVWF	ADREADPORT
	CALL	FN_READAD1013
	MOVF	SYSREADAD10WORD,W
	MOVWF	SYSWORDTEMPB
	MOVF	SYSREADAD10WORD_H,W
	MOVWF	SYSWORDTEMPB_H
	MOVLW	232
	MOVWF	SYSWORDTEMPA
	MOVLW	3
	MOVWF	SYSWORDTEMPA_H
	CALL	SYSCOMPLESSTHAN16
	BTFSC	SYSBYTETEMPX,0
	GOTO	SYSDOLOOP_S4
SYSDOLOOP_E4:
;End If
ENDIF13:
;If Switch = SWITCH_DOWN AND SwitchState = SWITCH_UP Then
	CLRF	SYSBYTETEMPX
	BTFSS	PORTA,5
	COMF	SYSBYTETEMPX,F
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP1
	MOVF	SWITCHSTATE,W
	MOVWF	SYSBYTETEMPA
	MOVLW	1
	MOVWF	SYSBYTETEMPB
	CALL	SYSCOMPEQUAL
	MOVF	SYSTEMP1,W
	ANDWF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP2
	BTFSS	SYSTEMP2,0
	GOTO	ENDIF14
;LEDDisplayState = !LEDDisplayState
	COMF	LEDDISPLAYSTATE,F
;SwitchState = SWITCH_DOWN
	CLRF	SWITCHSTATE
;End If
ENDIF14:
;If Switch = SWITCH_UP Then
	BTFSS	PORTA,5
	GOTO	ENDIF15
;SwitchState = SWITCH_UP
	MOVLW	1
	MOVWF	SWITCHSTATE
;End If
ENDIF15:
;Next
	MOVF	PIXELCOUNT,W
	SUBWF	YLOOP,W
;B7: ASM Source was:  BTFSS STATUS, C
	BTFSS	STATUS,0
	GOTO	SYSFORLOOP3
SYSFORLOOPEND3:
;Reset the addressed LED
;CurrentAddessedLED = 1
	MOVLW	1
	MOVWF	CURRENTADDESSEDLED
;Resequence LEDs the start of the color sequence
;CurrentLEDColorSequence = ( CurrentLEDColorSequence + 1 ) mod 4
	INCF	CURRENTLEDCOLORSEQUENCE,W
	MOVWF	SYSTEMP1
	MOVWF	SYSBYTETEMPA
	MOVLW	4
	MOVWF	SYSBYTETEMPB
	CALL	SYSDIVSUB
	MOVF	SYSBYTETEMPX,W
	MOVWF	CURRENTLEDCOLORSEQUENCE
;Loop
	GOTO	SYSDOLOOP_S3
SYSDOLOOP_E3:
;End If
ENDIF1:
;End
	GOTO	BASPROGRAMEND
;----- Support methods.  Subroutines and Functions
;Initialise the LED device, timers etc.
;#DEFINE period_us   0x1B00
;Uses SSP1BUF as the output buffer - change the define at the top for your chip
;Returns the long of a color for a specific element
;Sets the array element to a specific long value
BASPROGRAMEND:
	SLEEP
	GOTO	BASPROGRAMEND

;********************************************************************************

DELAY_10US:
D10US_START:
	MOVLW	25
	MOVWF	DELAYTEMP
DELAYUS0:
	DECFSZ	DELAYTEMP,F
	GOTO	DELAYUS0
	NOP
	DECFSZ	SYSWAITTEMP10US, F
	GOTO	D10US_START
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

;SOURCE: 29_WS2812_LED_USING_CLCORBITBANGING.GCB (509)
FN_GETLONGARRAYVALUEHANDLER:
;ElementPointer = ( ElementPointer * 4 ) + ElementPointer
	MOVF	ELEMENTPOINTER,W
	MOVWF	SYSBYTETEMPA
	MOVLW	4
	MOVWF	SYSBYTETEMPB
	CALL	SYSMULTSUB
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP1
	MOVF	ELEMENTPOINTER,W
	ADDWF	SYSTEMP1,W
	MOVWF	ELEMENTPOINTER
;GetLongArrayValueHandler = AddressArray(ElementPointer)
	ADDWF	SYSADDRESSARRAYHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSADDRESSARRAYHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	GETLONGARRAYVALUEHANDLER
	CLRF	GETLONGARRAYVALUEHANDLER_H
	CLRF	GETLONGARRAYVALUEHANDLER_U
	CLRF	GETLONGARRAYVALUEHANDLER_E
;GetLongArrayValueHandler_H = AddressArray(ElementPointer+1)
	INCF	ELEMENTPOINTER,W
	MOVWF	SYSTEMP1
	ADDWF	SYSADDRESSARRAYHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSADDRESSARRAYHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	GETLONGARRAYVALUEHANDLER_H
;GetLongArrayValueHandler_U = AddressArray(ElementPointer+2)
	MOVLW	2
	ADDWF	ELEMENTPOINTER,W
	MOVWF	SYSTEMP1
	ADDWF	SYSADDRESSARRAYHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSADDRESSARRAYHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	GETLONGARRAYVALUEHANDLER_U
;GetLongArrayValueHandler_E = AddressArray(ElementPointer+3)
	MOVLW	3
	ADDWF	ELEMENTPOINTER,W
	MOVWF	SYSTEMP1
	ADDWF	SYSADDRESSARRAYHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSADDRESSARRAYHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	INDF0,W
	MOVWF	GETLONGARRAYVALUEHANDLER_E
	RETURN

;********************************************************************************

;SOURCE: 29_WS2812_LED_USING_CLCORBITBANGING.GCB (86)
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
;Setup CLC inputs and outputs
;RC4->MSSP1:SDI1
;SSP1DATPPS = 0x0014
	MOVLW	20
MOVWF	SSP1DATPPS
;RA7->CLC1:CLCIN0
;CLCIN0PPS = 0x0007
	MOVLW	7
MOVWF	CLCIN0PPS
;RA7->CLC1:CLCIN1
;CLCIN1PPS = 0x0007
	MOVLW	7
MOVWF	CLCIN1PPS
;RB6->CLC1:CLCIN2
;CLCIN2PPS = 0x000E
	MOVLW	14
MOVWF	CLCIN2PPS
;RB7->CLC1:CLCIN3
;CLCIN3PPS = 0x000F
	MOVLW	15
MOVWF	CLCIN3PPS
;RB4->CCP1:CCP1
;RB4PPS = 0x0009
	MOVLW	9
BANKSEL	RB4PPS
MOVWF	RB4PPS
;RC3->TMR2:T2IN
;T2AINPPS = 0x0013
	MOVLW	19
BANKSEL	T2AINPPS
MOVWF	T2AINPPS
;Setup SPI and the outout for DIN
;RB1->MSSP1:SDO1
;RB1PPS = 0x0015
	MOVLW	21
BANKSEL	RB1PPS
MOVWF	RB1PPS
;RB0->MSSP1:SCK1
;RB0PPS = 0x0014
	MOVLW	20
MOVWF	RB0PPS
;RC7->CLC1:CLC1OUT
;RC7PPS = 0x0001
	MOVLW	1
MOVWF	RC7PPS
;Setup PWM
;RA0->PWM6:PWM6OUT
;RA0PPS = 0x000E
	MOVLW	14
MOVWF	RA0PPS
;Setup RS232
;RC0->EUSART:TX
;RC0PPS = 0x0010
	MOVLW	16
MOVWF	RC0PPS
;RC1->EUSART:RX
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

;OVERLOADED SIGNATURE: BYTE:, SOURCE: A-D.H (2002)
FN_READAD1013:
;Always RIGHT justified
;SET ADFM ON
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,ADFRM0
	BSF	ADCON0,2
;ADPCH = ADReadPort
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,W
BANKSEL	ADPCH
MOVWF	ADPCH
;Do conversion
;LLReadAD 0
;Macro Source: a-d.h (371)
;***  'Special section for 16F1688x Chips ***
;'Configure ANSELA/B/C/D
;Select Case ADReadPort 'Configure ANSELA/B/C/D @DebugADC_H
;Case 0: Set ANSELA.0 On
SYSSELECT1CASE1:
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,F
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE2
BANKSEL	ANSELA
	BSF	ANSELA,0
;Case 1: Set ANSELA.1 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE2:
	DECF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE3
BANKSEL	ANSELA
	BSF	ANSELA,1
;Case 2: Set ANSELA.2 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE3:
	MOVLW	2
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE4
BANKSEL	ANSELA
	BSF	ANSELA,2
;Case 3: Set ANSELA.3 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE4:
	MOVLW	3
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE5
BANKSEL	ANSELA
	BSF	ANSELA,3
;Case 4: Set ANSELA.4 ON
	GOTO	SYSSELECTEND1
SYSSELECT1CASE5:
	MOVLW	4
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE6
BANKSEL	ANSELA
	BSF	ANSELA,4
;Case 5: Set ANSELA.5 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE6:
	MOVLW	5
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE7
BANKSEL	ANSELA
	BSF	ANSELA,5
;Case 6: Set ANSELA.6 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE7:
	MOVLW	6
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE8
BANKSEL	ANSELA
	BSF	ANSELA,6
;Case 7: Set ANSELA.7 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE8:
	MOVLW	7
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE9
BANKSEL	ANSELA
	BSF	ANSELA,7
;Case 8: Set ANSELB.0 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE9:
	MOVLW	8
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE10
BANKSEL	ANSELB
	BSF	ANSELB,0
;Case 9: Set ANSELB.1 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE10:
	MOVLW	9
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE11
BANKSEL	ANSELB
	BSF	ANSELB,1
;Case 10: Set ANSELB.2 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE11:
	MOVLW	10
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE12
BANKSEL	ANSELB
	BSF	ANSELB,2
;Case 11: Set ANSELB.3 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE12:
	MOVLW	11
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE13
BANKSEL	ANSELB
	BSF	ANSELB,3
;Case 12: Set ANSELB.4 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE13:
	MOVLW	12
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE14
BANKSEL	ANSELB
	BSF	ANSELB,4
;Case 13: Set ANSELB.5 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE14:
	MOVLW	13
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE15
BANKSEL	ANSELB
	BSF	ANSELB,5
;Case 14: Set ANSELB.6 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE15:
	MOVLW	14
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE16
BANKSEL	ANSELB
	BSF	ANSELB,6
;Case 15: Set ANSELB.7 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE16:
	MOVLW	15
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE17
BANKSEL	ANSELB
	BSF	ANSELB,7
;Case 16: Set ANSELC.0 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE17:
	MOVLW	16
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE18
BANKSEL	ANSELC
	BSF	ANSELC,0
;Case 17: Set ANSELC.1 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE18:
	MOVLW	17
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE19
BANKSEL	ANSELC
	BSF	ANSELC,1
;Case 18: Set ANSELC.2 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE19:
	MOVLW	18
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE20
BANKSEL	ANSELC
	BSF	ANSELC,2
;Case 19: Set ANSELC.3 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE20:
	MOVLW	19
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE21
BANKSEL	ANSELC
	BSF	ANSELC,3
;Case 20: Set ANSELC.4 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE21:
	MOVLW	20
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE22
BANKSEL	ANSELC
	BSF	ANSELC,4
;Case 21: Set ANSELC.5 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE22:
	MOVLW	21
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE23
BANKSEL	ANSELC
	BSF	ANSELC,5
;Case 22: Set ANSELC.6 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE23:
	MOVLW	22
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECT1CASE24
BANKSEL	ANSELC
	BSF	ANSELC,6
;Case 23: Set ANSELC.7 On
	GOTO	SYSSELECTEND1
SYSSELECT1CASE24:
	MOVLW	23
	SUBWF	ADREADPORT,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	SYSSELECTEND1
BANKSEL	ANSELC
	BSF	ANSELC,7
;End Select  '*** ANSEL Bits should now be set ***
SYSSELECTEND1:
;*** ANSEL Bits are now set ***
;Set voltage reference
;ADREF = 0  'Default = 0 /Vref+ = Vdd/ Vref-  = Vss
;Configure AD clock defaults
;Set ADCS off 'Clock source = FOSC/ADCLK
BANKSEL	ADCON0
;B7: ASM Source was:  BCF ADCON0,ADCS
	BCF	ADCON0,4
;ADCLK = 1 ' default to FOSC/2
	MOVLW	1
MOVWF	ADCLK
;Conversion Clock Speed
;SET ADCS OFF  'ADCON0.4
;B7: ASM Source was:  BCF ADCON0,ADCS
	BCF	ADCON0,4
;ADCLK = 15    'FOSC/16
	MOVLW	15
MOVWF	ADCLK
;Result formatting
;if ADLeftadjust = 0 then  '10-bit
;Set ADCON0.2 ON
;Set ADFM ON
;B7: ASM Source was:  BSF ADCON0,ADFRM0
	BSF	ADCON0,2
;Set ADFM0 ON
;B7: ASM Source was:  BSF ADCON0,ADFM0
	BSF	ADCON0,2
;Else
;Select Channel
;ADPCH = ADReadPort  'Configure AD read Channel
	BANKSEL	ADREADPORT
	MOVF	ADREADPORT,W
BANKSEL	ADPCH
MOVWF	ADPCH
;Enable A/D
;SET ADON ON
;B7: ASM Source was:  BSF ADCON0,ADON
	BSF	ADCON0,7
;Acquisition Delay
;Wait AD_Delay
	MOVLW	2
	MOVWF	SYSWAITTEMP10US
BANKSEL	STATUS
	CALL	DELAY_10US
;Read A/D
;SET GO_NOT_DONE ON
BANKSEL	ADCON0
;B7: ASM Source was:  BSF ADCON0,GO_NOT_DONE
	BSF	ADCON0,0
;nop
	NOP
;Wait While GO_NOT_DONE ON
SYSWAITLOOP6:
;B7: ASM Source was:  BTFSC ADCON0,GO_NOT_DONE
	BTFSC	ADCON0,0
	GOTO	SYSWAITLOOP6
;Switch off A/D
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
;Write output
;ReadAD10 = ADRESL
BANKSEL	ADRESL
	MOVF	ADRESL,W
	BANKSEL	READAD10
	MOVWF	READAD10
	CLRF	READAD10_H
;ReadAD10_H = ADRESH
BANKSEL	ADRESH
	MOVF	ADRESH,W
	BANKSEL	READAD10_H
	MOVWF	READAD10_H
;Put A/D format back to normal
;SET ADFM OFF
BANKSEL	ADCON0
;B7: ASM Source was:  BCF ADCON0,ADFRM0
	BCF	ADCON0,2
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: 29_WS2812_LED_USING_CLCORBITBANGING.GCB (520)
SETLONGARRAYVALUEHANDLER:
;ElementPointer = ( ElementPointer * 4 ) + ElementPointer
	MOVF	ELEMENTPOINTER,W
	MOVWF	SYSBYTETEMPA
	MOVLW	4
	MOVWF	SYSBYTETEMPB
	CALL	SYSMULTSUB
	MOVF	SYSBYTETEMPX,W
	MOVWF	SYSTEMP1
	MOVF	ELEMENTPOINTER,W
	ADDWF	SYSTEMP1,W
	MOVWF	ELEMENTPOINTER
;AddressArray(ElementPointer)   = ElementValue
	ADDWF	SYSADDRESSARRAYHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSADDRESSARRAYHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	ELEMENTVALUE,W
MOVWF	INDF0
;AddressArray(ElementPointer+1)  = ElementValue_H
	INCF	ELEMENTPOINTER,W
	MOVWF	SYSTEMP1
	ADDWF	SYSADDRESSARRAYHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSADDRESSARRAYHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	ELEMENTVALUE_H,W
MOVWF	INDF0
;AddressArray(ElementPointer+2) = ElementValue_U
	MOVLW	2
	ADDWF	ELEMENTPOINTER,W
	MOVWF	SYSTEMP1
	ADDWF	SYSADDRESSARRAYHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSADDRESSARRAYHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	ELEMENTVALUE_U,W
MOVWF	INDF0
;AddressArray(ElementPointer+3) = ElementValue_E
	MOVLW	3
	ADDWF	ELEMENTPOINTER,W
	MOVWF	SYSTEMP1
	ADDWF	SYSADDRESSARRAYHANDLER,W
;B9: ASM Source was:  MOVWF AFSR0
MOVWF	FSR0L
	MOVLW	0
	ADDWFC	SYSADDRESSARRAYHANDLER_H,W
;B9: ASM Source was:  MOVWF AFSR0_H
MOVWF	FSR0H
	MOVF	ELEMENTVALUE_E,W
MOVWF	INDF0
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
	GOTO	ENDIF23
BANKSEL	T1CON
;B7: ASM Source was:  BSF T1CON,TMR1ON
	BSF	T1CON,0
ENDIF23:
;IF TMRNumber = 2 then Set TMR2ON on
	MOVLW	2
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF24
BANKSEL	T2CON
;B7: ASM Source was:  BSF T2CON,TMR2ON
	BSF	T2CON,7
ENDIF24:
;IF TMRNumber = 3 then Set TMR3ON on
	MOVLW	3
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF25
BANKSEL	T3CON
;B7: ASM Source was:  BSF T3CON,TMR3ON
	BSF	T3CON,0
ENDIF25:
;IF TMRNumber = 4 then Set TMR4ON on
	MOVLW	4
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF26
BANKSEL	T4CON
;B7: ASM Source was:  BSF T4CON,TMR4ON
	BSF	T4CON,7
ENDIF26:
;IF TMRNumber = 5 then Set TMR5ON on
	MOVLW	5
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF27
BANKSEL	T5CON
;B7: ASM Source was:  BSF T5CON,TMR5ON
	BSF	T5CON,0
ENDIF27:
;IF TMRNumber = 6 then Set TMR6ON on
	MOVLW	6
	BANKSEL	TMRNUMBER
	SUBWF	TMRNUMBER,W
;B7: ASM Source was:  BTFSS STATUS, Z
	BTFSS	STATUS,2
	GOTO	ENDIF28
BANKSEL	T6CON
;B7: ASM Source was:  BSF T6CON,TMR6ON
	BSF	T6CON,7
ENDIF28:
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: SYSTEM.H (2868)
SYSCOMPEQUAL:
;Dim SysByteTempA, SysByteTempB, SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
;movf SysByteTempA, W
	MOVF	SYSBYTETEMPA, W
;subwf SysByteTempB, W
	SUBWF	SYSBYTETEMPB, W
;btfsc STATUS, Z
;B7: ASM Source was:  BTFSC STATUS, Z
	BTFSC	STATUS,2
;comf SysByteTempX,F
	COMF	SYSBYTETEMPX,F
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

;SOURCE: SYSTEM.H (2420)
SYSMULTSUB:
;dim SysByteTempA as byte
;dim SysByteTempB as byte
;dim SysByteTempX as byte
;clrf SysByteTempX
	CLRF	SYSBYTETEMPX
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
	GOTO	MUL8LOOP
	RETURN

;********************************************************************************

;SOURCE: 29_WS2812_LED_USING_CLCORBITBANGING.GCB (493)
WS2812PWMSENDDATA:
;Put byte to send into buffer
;Will start transfer
;SSPOutRegister = ColortoSend_u
	MOVF	COLORTOSEND_U,W
BANKSEL	SSP1BUF
MOVWF	SSP1BUF
;Wait While BF = Off
SYSWAITLOOP3:
;B7: ASM Source was:  BTFSS SSP1STAT,BF
	BTFSS	SSP1STAT,0
	GOTO	SYSWAITLOOP3
;SSPOutRegister = ColortoSend_h
	BANKSEL	COLORTOSEND_H
	MOVF	COLORTOSEND_H,W
BANKSEL	SSP1BUF
MOVWF	SSP1BUF
;Wait While BF = Off
SYSWAITLOOP4:
;B7: ASM Source was:  BTFSS SSP1STAT,BF
	BTFSS	SSP1STAT,0
	GOTO	SYSWAITLOOP4
;SSPOutRegister = ColortoSend
	BANKSEL	COLORTOSEND
	MOVF	COLORTOSEND,W
BANKSEL	SSP1BUF
MOVWF	SSP1BUF
;Wait While BF = Off
SYSWAITLOOP5:
;B7: ASM Source was:  BTFSS SSP1STAT,BF
	BTFSS	SSP1STAT,0
	GOTO	SYSWAITLOOP5
BANKSEL	STATUS
	RETURN

;********************************************************************************

;SOURCE: 29_WS2812_LED_USING_CLCORBITBANGING.GCB (373)
WS2812_INIT:
;Set DIN Off
	BCF	LATC,7
;SSPBUF updates ignoring BF for daisy-chained operation
;BOEN = 1
BANKSEL	SSP1CON3
;B7: ASM Source was:  BSF SSP1CON3,BOEN
	BSF	SSP1CON3,4
;SMP End CKE Idle to Active
;SSP1STAT = 0x00
CLRF	SSP1STAT
;SSPEN enabled CKP Idle:Low, Active:High SPI Master mode, clock = T2_match/2
;SSP1CON1 = 0x23
	MOVLW	35
MOVWF	SSP1CON1
;SSPADD 0
;SSP1ADD = 0x00
CLRF	SSP1ADD
;Setup the PWM
;PWM6POL active_hi PWM6EN enabled
;PWM6CON = 0x80
	MOVLW	128
BANKSEL	PWM6CON
MOVWF	PWM6CON
;DC 2
;PWM6DCH = 0x02
	MOVLW	2
MOVWF	PWM6DCH
;DC 1
;PWM6DCL = 0x40
	MOVLW	64
MOVWF	PWM6DCL
;LC1G1POL inverted LC1G2POL not_inverted LC1G3POL not_inverted LC1G4POL not_inverted LC1POL not_inverted
;CLC1POL = 0x01
	MOVLW	1
BANKSEL	CLC1POL
MOVWF	CLC1POL
;LC1D1S PWM6_OUT
;CLC1SEL0 = 0x18
	MOVLW	24
MOVWF	CLC1SEL0
;LC1D2S SCK from MSSP1
;CLC1SEL1 = 0x27
	MOVLW	39
MOVWF	CLC1SEL1
;LC1D3S SDO from MSSP1
;CLC1SEL2 = 0x26
	MOVLW	38
MOVWF	CLC1SEL2
;LC1D4S CLCIN0 (CLCIN0PPS)
;CLC1SEL3 = 0x00
CLRF	CLC1SEL3
;LC1G1D3N disabled LC1G1D2N enabled LC1G1D4N disabled LC1G1D1T disabled LC1G1D3T disabled LC1G1D2T disabled LC1G1D4T disabled LC1G1D1N enabled
;CLC1GLS0 = 0x05
	MOVLW	5
MOVWF	CLC1GLS0
;LC1G2D2N disabled LC1G2D1N disabled LC1G2D4N disabled LC1G2D3N enabled LC1G2D2T disabled LC1G2D1T disabled LC1G2D4T disabled LC1G2D3T disabled
;CLC1GLS1 = 0x10
	MOVLW	16
MOVWF	CLC1GLS1
;LC1G3D1N disabled LC1G3D2N disabled LC1G3D3N disabled LC1G3D4N disabled LC1G3D1T disabled LC1G3D2T enabled LC1G3D3T disabled LC1G3D4T disabled
;CLC1GLS2 = 0x08
	MOVLW	8
MOVWF	CLC1GLS2
;LC1G4D1N disabled LC1G4D2N disabled LC1G4D3N disabled LC1G4D4N disabled LC1G4D1T disabled LC1G4D2T disabled LC1G4D3T enabled LC1G4D4T disabled
;CLC1GLS3 = 0x20
	MOVLW	32
MOVWF	CLC1GLS3
;LC1EN enabled INTN disabled INTP disabled MODE AND-OR
;CLC1CON = 0x80
	MOVLW	128
MOVWF	CLC1CON
;Set TMR2 to the options selected in the User Interface
;T2CKPS 1:1 T2OUTPS 1:1 TMR2ON off
;T2CON = 0x00
BANKSEL	T2CON
CLRF	T2CON
;T2CS FOSC/4
;T2CLKCON = 0x01
	MOVLW	1
MOVWF	T2CLKCON
;T2PSYNC Synchronized T2MODE Software control T2CKPOL Falling Edge T2CKSYNC Synchronized
;T2HLT = 0xE0
	MOVLW	224
MOVWF	T2HLT
;T2RSEL T2CKIPPS pin
;T2RST = 0x00
CLRF	T2RST
;PR2 4
;T2PR = 0x04
	MOVLW	4
MOVWF	T2PR
;TMR2 0
;T2TMR = 0x00
CLRF	T2TMR
;Clearing IF flag.
;TMR2IF = 0
BANKSEL	PIR4
;B7: ASM Source was:  BCF PIR4,TMR2IF
	BCF	PIR4,1
;Start TMR2
;StartTimer 2
	MOVLW	2
	BANKSEL	TMRNUMBER
	MOVWF	TMRNUMBER
	GOTO	STARTTIMER

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
