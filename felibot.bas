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

'VARIABLES
   Dim A As Bit
   Dim Adc0 As Word , Adc1 As Word , Adc2 As Word , Adc3 As Word , Adc4 As Word , Adc5 As Word , Adc6 As Word , Adc7 As Word
   Dim Sharp(6) As Word
   Dim Linie(4) As Byte

   Dim I As Byte , Ii As Byte , Aux_word As Word , Aux_integer As Integer

   Dim Speed As Integer , Direction As Integer , Max_speed As Integer
   Dim Serin_chr As Byte


'CONFIG PINS
   Config Porta = Input

   Config Portc.0 = Input
   Config Portc.1 = Input
   Config Portc.2 = Input
   Config Portc.3 = Input

   Config Pind.4 = Output
   Config Pind.5 = Output
   Config Pind.6 = Output
   Config Pind.7 = Output


'OTHER CONFIG
   Config Adc = Single , Prescaler = Auto
   Start Adc

   Config Timer1 = Pwm , Pwm = 8 , Compare A Pwm = Clear Down , Compare B Pwm = Clear Down , Prescale = 64

'ALIAS
   Left_forward Alias Portd.2
   Left_backward Alias Portd.3

   Right_forward Alias Portd.6
   Right_backward Alias Portd.7

   On Urxc Urxc_in


'CODE


   Porta = 0
   Portc = 0
   Portd = 0

   Pwm1a = 0
   Pwm1b = 0
   Speed = 0
   Direction = 0
   Max_speed = 255




   Enable Urxc
   Enable Interrupts



Do

'clear screen
   Printbin 27;
   Print "[2J";
   'go to 0,0
   Printbin 27;
   Print "[;H";
   'green text :D
   Printbin 27;
   Print "[32m";


'read sharp sensors
   For I = 1 To 6
      Ii = I - 1
      Aux_word = Getadc(ii)
      Aux_word = Aux_word + Sharp(i)
      Sharp(i) = Aux_word / 2
      'Print "sharp " ; I ; ": " ; Sharp(i)
   Next

'read line sensors
   Disable Interrupts
   Portc.0 = 1
   Portc.1 = 1
   Portc.2 = 1
   Portc.3 = 1
   Waitus 10
   Portc.0 = 0
   Portc.1 = 0
   Portc.2 = 0
   Portc.3 = 0

   'line sensors treshold value
   Waitus 20

   Linie(1) = Pinc.0
   Linie(2) = Pinc.1
   Linie(3) = Pinc.2
   Linie(4) = Pinc.3
   enable interrupts

'motors
   'full stop = BRAKE
   If Speed = 0 And Direction = 0 Then
      Pwm1a = 0
      Pwm1b = 0

      'brake
      Right_forward = 1
      Right_backward = 1
      Left_forward = 1
      Left_backward = 1

   Else

     'Curba larga
     If Direction > -128 And Direction < 128 Then
     'A or B
        If Speed > 0 Then
           'A
           Right_forward = 1
           Right_backward = 0
           Left_forward = 1
           Left_backward = 0
        Else
           'B
           Right_forward = 0
           Right_backward = 1
           Left_forward = 0
           Left_backward = 1
        End If
     End If

     'rotit pe loc spre stanga
     If Direction < -127 Then
        'C or D, left side
        If Speed > 0 Then
           'C
           Right_forward = 1
           Right_backward = 0
           Left_forward = 0
           Left_backward = 1
        Else
           'D
           Right_forward = 0
           Right_backward = 1
           Left_forward = 1
           Left_backward = 0
        End If
     End If

     'rotit pe loc spre dreapta
     If Direction > 127 Then
        'C or D, right side
        If Speed < 0 Then
           'C
           Right_forward = 1
           Right_backward = 0
           Left_forward = 0
           Left_backward = 1
        Else
           'D
           Right_forward = 0
           Right_backward = 1
           Left_forward = 1
           Left_backward = 0
        End If
     End If

     Aux_integer = Abs(direction)
     Aux_integer = 128 - Aux_integer
     Aux_integer = Abs(aux_integer)
     Aux_integer = Aux_integer * Speed
     Aux_integer = Aux_integer / 128
     Aux_integer = Abs(aux_integer)

     If Direction > 0 Then
         Pwm1b = Aux_integer
        Aux_integer = Abs(speed)
        Pwm1a =Aux_integer
     Else
         Pwm1a = Aux_integer
        Aux_integer = Abs(speed)
         Pwm1b = Aux_integer
     End If

   End If


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

Urxc_in:
   Inputbin Serin_chr
   If Serin_chr = "w" Then
      Speed = Max_speed
      Direction = 0
   End If

   If Serin_chr = "a" Then
      Speed = Max_speed
      Direction = -255
   End If

   If Serin_chr = "d" Then
      Speed = Max_speed
      Direction = 255
   End If

   If Serin_chr = "s" Or Serin_chr = " " Then
      Speed = 0
      Direction = 0
   End If

   If Serin_chr = "q" Then
      Speed = Max_speed
      Direction = -127
   End If

   If Serin_chr = "e" Then
      Speed = Max_speed
      Direction = 127
   End If

   If Serin_chr = "z" Then
      Speed = -max_speed
      Direction = -127
   End If

   If Serin_chr = "x" Then
      Speed = -50
      Direction = 0
   End If

   If Serin_chr = "c" Then
      Speed = -max_speed
      Direction = 127
   End If

Return

Return