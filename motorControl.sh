VALUE=$1
PULSES=$2
PIN1=20
PIN2=21
UP=4
DOWN=22
LEFT=23
RIGHT=8
LRNEUTRAL=15
UDNEUTRAL=13

# LEFT
if [ $VALUE == "a" ]
then
  gpio_pwm $PIN1 10000 $PULSES $LEFT &
fi
# RIGHT
if [ $VALUE == "d" ]
then
  gpio_pwm $PIN1 10000 $PULSES $RIGHT &
fi
# UP
if [ $VALUE == "w" ]
then
  gpio_pwm $PIN2 10000 $PULSES $UP &
fi
# DOWN
if [ $VALUE == "x" ]
then
  gpio_pwm $PIN2 10000 $PULSES $DOWN &
fi

# Start -> go to neutral
if [ $VALUE == "s" ]
then
  gpio_pwm $PIN1 10000 25 $LRNEUTRAL &
  gpio_pwm $PIN2 10000 25 $UDNEUTRAL &
fi

# LeftBumper -> Up-Left
if [ $VALUE == "q" ]
then
  gpio_pwm $PIN1 10000 35 $LEFT &
  gpio_pwm $PIN2 10000 35 $UP &
fi

# RightBumper -> Up-Right
if [ $VALUE == "e" ]
then
  gpio_pwm $PIN1 10000 35 $RIGHT &
  gpio_pwm $PIN2 10000 35 $UP &
fi

# -> Down-Left
if [ $VALUE == "z" ]
then
  gpio_pwm $PIN1 10000 35 $LEFT &
  gpio_pwm $PIN2 10000 35 $DOWN &
fi

# -> Down-Right
if [ $VALUE == "c" ]
then
  gpio_pwm $PIN1 10000 35 $RIGHT &
  gpio_pwm $PIN2 10000 35 $DOWN &
fi

#BtmRight btn -> do a dance
if [ $VALUE == "0" ]
then
  gpio_pwm $PIN1 10000 15 15 &
  gpio_pwm $PIN2 10000 15 14
  gpio_pwm $PIN1 10000 25 19 &
  gpio_pwm $PIN2 10000 25 19
  gpio_pwm $PIN1 10000 25 10 &
  gpio_pwm $PIN2 10000 25 10
  gpio_pwm $PIN1 10000 25 15 &
  gpio_pwm $PIN2 10000 25 14
  gpio_pwm $PIN1 10000 25 10 &
  gpio_pwm $PIN2 10000 25 19
  gpio_pwm $PIN1 10000 25 19 &
  gpio_pwm $PIN2 10000 25 10
  gpio_pwm $PIN1 10000 25 10 &
  gpio_pwm $PIN2 10000 25 10
  gpio_pwm $PIN1 10000 25 19 &
  gpio_pwm $PIN2 10000 25 10
  gpio_pwm $PIN1 10000 25 19 &
  gpio_pwm $PIN2 10000 25 19
  gpio_pwm $PIN1 10000 25 10 &
  gpio_pwm $PIN2 10000 25 19
  gpio_pwm $PIN1 10000 20 15 &
  gpio_pwm $PIN2 10000 20 14
fi


