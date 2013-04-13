
$regfile = "m32def.dat"                                     ' specify the used micro
$crystal = 16000000                                         ' used crystal frequency
$baud = 19200                                               ' use baud rate
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


'CONFIG PINI

Config Pind.7 = Output
Config Portc.0 = Input
Config Portc.1 = Input


Portc = 0


Do

Portd.7 = 1
Portc.1 = 1
Waitus 10
Portc.1 = 0

   Do

   Loop Until Pinc.1 = 0
Portd.7 = 0
Waitus 20


'A = Pinc.0

'Portd.7 = A
'Wait 1
'Portd.7 = 0
'Wait 1



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