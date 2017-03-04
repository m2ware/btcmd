#!/bin/bash

#  Need to run this with SUDO to work...
PULSES=1
HIDPATH="/dev/hidraw0"

stdbuf -oL btcmd --numeric $HIDPATH |
while IFR= read -r VALUE
do

#if [ ! -z $VALUE ]
#then
#  echo "Lost bluetooth connection, terminating."
#  exit 1
#fi

echo $VALUE
CHAR="nothing"

# LEFT
if [ $VALUE -eq 4 ]
then
  CHAR="a"
  echo "1"
fi
# RIGHT
if [ $VALUE -eq 7 ]
then
  CHAR="d"
  echo "1"
fi
# UP
if [ $VALUE -eq 26 ]
then
  CHAR="w"
  echo "1"
fi
# DOWN
if [ $VALUE -eq 27 ]
then
  CHAR="x"
  echo "1"
fi

# Start -> go to neutral
if [ $VALUE -eq 24 ]
then
  CHAR="s"
  echo "1"
fi

# LeftBumper -> Go full
if [ $VALUE -eq 11 ]
then
  CHAR="q"
  echo "1"
fi

# RightBumper -> Go full
if [ $VALUE -eq 13 ]
then
  CHAR="e"
  echo "1"
fi

#BtmRight btn -> do a dance
if [ $VALUE -eq 15 ]
then
  CHAR="0"
  echo "1"
fi

# UpperLeft btn -> Low-Hi
if [ $VALUE -eq 12 ]
then
  PULSES=5
  echo Speed=$PULSES
fi

# BtmLeft btn -> Low-Low
if [ $VALUE -eq 14 ]
then
  PULSES=1
  echo Speed=$PULSES
fi

if [ $VALUE -eq 18 ]
then
  PULSES=15
  echo Speed=$PULSES
fi

# I don't know why I have to specifically invoke the bash shell here...
# but it appears to invoke via /bin/sh if I don't do this resulting in eval
# errors
/bin/bash ./motorControl.sh $CHAR $PULSES

done
