
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
Dim Linie(4) As Byte

Dim I As Byte , Ii As Byte , Aux_word As Word

Dim Viteza As Integer , Directie As Integer

'CONFIG PINI

Config Porta = Input

Config Portc.0 = Input
Config Portc.1 = Input
Config Portc.2 = Input
Config Portc.3 = Input

Config Pind.4 = Output
Config Pind.5 = Output
Config Pind.6 = Output
Config Pind.7 = Output

'ALTE CONFIG

Config Adc = Single , Prescaler = Auto
Start Adc



'COD


Porta = 0
Portc = 0
Portd = 0

Pwm1a = 0
Pwm1b = 0


Do

'clear screen
Printbin 27;
Print "[2J";
Printbin 27;
Print "[;H";


'citesc sharpurile
   For I = 1 To 6
      Ii = I - 1
      Aux_word = Getadc(ii)
      Aux_word = Aux_word + Sharp(i)
      Sharp(i) = Aux_word / 2
      Print "sharp " ; I ; ": " ; Sharp(i)
   Next

'citire senzor linie
   Portc.0 = 1
   Portc.1 = 1
   Portc.2 = 1
   Portc.3 = 1
   Waitus 10
   Portc.0 = 0
   Portc.1 = 0
   Portc.2 = 0
   Portc.3 = 0

   'sensibilitatea la senzorii de linie
   Waitus 20

   linie(1) = Pinc.0
   Linie(2) = Pinc.1
   Linie(3) = Pinc.2
   Linie(4) = Pinc.3

'motoare

'Portd.5 = 0
Portd.4 = 1

'fara
Portd.7 = 0
'1
Portd.6 = 1
'Wait 1
 'spate
'Portd.6 = 0
'1
'Portd.7 = 1
'Wait 1


'Portd.4 = 0

Portd.5 = 1

'Portd.2 = 0
'Portd.3 = 1
'Wait 1
Portd.2 = 1
Portd.3 = 0
'Wait 1




Waitms 200

Loop


Do




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