
$regfile = "m32def.dat"                                     ' specify the used micro
$crystal = 16000000                                         ' used crystal frequency
$baud = 9600                                                ' use baud rate
$hwstack = 32                                               ' default use 32 for the hardware stack
$swstack = 10                                               ' default use 10 for the SW stack
$framesize = 40                                             ' default use 40 for the frame space

'$prog , &H2A , &HD8
' Notice the empty start value ! This means, do not modify
' Instead of an empty value, &HFF can be used too
' $prog &HFF , &H2A, &HD8 , &HFF

'This file is intended to test the Mega32
'The M32 has the JTAG enabled by default so you can not use
'pins PORTC.2-PORTC.5

'Use the following code to disable JTAG
Mcusr = &H80
Mcusr = &H80



'------------------------------
'DE ACI II CEVA UTIL
'----------------------

'VARIABILE

Dim A As Bit
Dim Adc0 As Word , Adc1 As Word , Adc2 As Word , Adc3 As Word , Adc4 As Word , Adc5 As Word , Adc6 As Word , Adc7 As Word
Dim Sharp(6) As Word

Dim I As Byte , Ii As Byte

'CONFIG PINI

Config Porta = Input

Config Pind.7 = Output
Config Portc.0 = Input
Config Portc.1 = Input

'ALTE CONFIG

Config Adc = Single , Prescaler = Auto
Start Adc



'COD


Porta = 0
Portc = 0

Do

'clear screen
Printbin 27;
Print "[2J";
Printbin 27;
Print "[;H";


For I = 1 To 1
   Ii = I - 1
   Sharp(i) = Getadc(ii)
   Print "sharp " ; I ; ": " ; Sharp(i)
Next

'Print "Salut"


Waitms 200

Loop


Do


Portc.1 = 1
Waitus 10
Portc.1 = 0

Waitus 20

A = Pinc.1

If A = 1 Then
   Portd.7 = 1
Else
   Portd.7 = 0
End If

Loop


'Config Com1 = Dummy , Synchrone = 0 , Parity = Even , Stopbits = 2 , Databits = 8
' when you unremark the line above make sure to change the terminal emulator settings
Do
  Print "hello world"
  Waitms 500
Loop
End

Test0:
Test:
nop

Return