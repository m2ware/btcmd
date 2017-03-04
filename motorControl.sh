#!/bin/bash

COMMAND=$1
PULSES=$2
DEBUG=$3
LRPIN=20
UDPIN=21
UP=4
DOWN=22
LEFT=23
RIGHT=8
LRNEUTRAL=15
UDNEUTRAL=13

if [ ! -z $DEBUG ]; then
  if [ $DEBUG -eq 1 ]
  then
    echo "Command = $COMMAND"
    echo "Pulses  = $PULSES"
  fi
fi

# LEFT
if [ $COMMAND == "a" ]
then
  gpio_pwm $LRPIN 10000 $PULSES $LEFT &
fi
# RIGHT
if [ $COMMAND == "d" ]
then
  gpio_pwm $LRPIN 10000 $PULSES $RIGHT &
fi
# UP
if [ $COMMAND == "w" ]
then
  gpio_pwm $UDPIN 10000 $PULSES $UP &
fi
# DOWN
if [ $COMMAND == "x" ]
then
  gpio_pwm $UDPIN 10000 $PULSES $DOWN &
fi

# Start -> go to neutral
if [ $COMMAND == "s" ]
then
  gpio_pwm $LRPIN 10000 25 $LRNEUTRAL &
  gpio_pwm $UDPIN 10000 25 $UDNEUTRAL &
fi

# LeftBumper -> Up-Left
if [ $COMMAND == "q" ]
then
  gpio_pwm $LRPIN 10000 35 $LEFT &
  gpio_pwm $UDPIN 10000 35 $UP &
fi

# RightBumper -> Up-Right
if [ $COMMAND == "e" ]
then
  gpio_pwm $LRPIN 10000 35 $RIGHT &
  gpio_pwm $UDPIN 10000 35 $UP &
fi

# -> Down-Left
if [ $COMMAND == "z" ]
then
  gpio_pwm $LRPIN 10000 35 $LEFT &
  gpio_pwm $UDPIN 10000 35 $DOWN &
fi

# -> Down-Right
if [ $COMMAND == "c" ]
then
  gpio_pwm $LRPIN 10000 35 $RIGHT &
  gpio_pwm $UDPIN 10000 35 $DOWN &
fi

#BtmRight btn -> do a dance
if [ $COMMAND == "0" ]
then
  gpio_pwm $LRPIN 10000 15 15 &
  gpio_pwm $UDPIN 10000 15 14
  gpio_pwm $LRPIN 10000 25 19 &
  gpio_pwm $UDPIN 10000 25 19
  gpio_pwm $LRPIN 10000 25 10 &
  gpio_pwm $UDPIN 10000 25 10
  gpio_pwm $LRPIN 10000 25 15 &
  gpio_pwm $UDPIN 10000 25 14
  gpio_pwm $LRPIN 10000 25 10 &
  gpio_pwm $UDPIN 10000 25 19
  gpio_pwm $LRPIN 10000 25 19 &
  gpio_pwm $UDPIN 10000 25 10
  gpio_pwm $LRPIN 10000 25 10 &
  gpio_pwm $UDPIN 10000 25 10
  gpio_pwm $LRPIN 10000 25 19 &
  gpio_pwm $UDPIN 10000 25 10
  gpio_pwm $LRPIN 10000 25 19 &
  gpio_pwm $UDPIN 10000 25 19
  gpio_pwm $LRPIN 10000 25 10 &
  gpio_pwm $UDPIN 10000 25 19
  gpio_pwm $LRPIN 10000 20 15 &
  gpio_pwm $UDPIN 10000 20 14
fi


