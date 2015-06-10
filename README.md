# btcmd

Blue tooth command line tools.

This set of hacky tools was used to control a dual-axis servo project using
an 8-Bitty bluetooth joystick.  The package has 3 main components:

btcmd utility (Created by modifying test code from hidapi)
gpio utility  (Software PWM code for controlling servo motors from cmd line)
btc.sh script (Bluetooth controller shell script)

Build instructions:
=================================================
btcmd 

1.  Download the hidapi package from github:
  
https://github.com/signal11/hidapi

2.  Go to hidapi.hidtest and 'mv hidtest.cpp hidtest.cpp.orig'
3.  Copy the included file "hidtest.cpp" into hidapi/hidtest 
4.  Copy the included Makefile into hidapi/linux
5.  Run make.  This will build the btcmd tool.

=================================================
gpio_pwm (servo soft-pwm command line tool)

1.  cd gpio
2.  Run make.  THis will build and install the gpio tool.

=================================================

Usage instructions:

1.  Pair your BT device with the your linux machine
2.  Make sure that the location of btcmd is correct in btc.sh
2.  sudo ./btc.sh 


This will run in an infinite loop, waiting to receive data from a 
BT device.  
