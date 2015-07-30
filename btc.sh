#  Need to run this with SUDO to work...
PULSES=1
HIDPATH="/dev/hidraw0"
stdbuf -oL ../hidapi/hidapi/linux/btcmd $HIDPATH |
while IFR= read -r VALUE
do

#echo $VALUE

# LEFT
if [ $VALUE -eq 4 ]
then
  gpio_pwm 20 10000 $PULSES 25 &
fi
# RIGHT
if [ $VALUE -eq 7 ]
then
  gpio_pwm 20 10000 $PULSES 5 &
fi
# UP
if [ $VALUE -eq 26 ]
then
  gpio_pwm 21 10000 $PULSES 25 &
fi
# DOWN
if [ $VALUE -eq 27 ]
then
  gpio_pwm 21 10000 $PULSES 5 &
fi

# Start -> go to neutral
if [ $VALUE -eq 24 ]
then
  gpio_pwm 20 10000 25 15 &
  gpio_pwm 21 10000 25 14 &
fi

# LeftBumper -> Go full
if [ $VALUE -eq 11 ]
then
  gpio_pwm 20 10000 35 5 &
  gpio_pwm 21 10000 35 5 &
fi

# RightBumper -> Go full
if [ $VALUE -eq 13 ]
then
  gpio_pwm 20 10000 35 25 &
  gpio_pwm 21 10000 35 25 &
fi

# UpperLeft btn -> Low-Hi
if [ $VALUE -eq 12 ]
then
  PULSES=15
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
  PULSES=30
  echo Speed=$PULSES
fi

#BtmRight btn -> do a dance
if [ $VALUE -eq 15 ]
then
  gpio_pwm 20 10000 15 15 &
  gpio_pwm 21 10000 15 14
  gpio_pwm 20 10000 35 25 &
  gpio_pwm 21 10000 35 25
  gpio_pwm 20 10000 35 5 &
  gpio_pwm 21 10000 35 5
  gpio_pwm 20 10000 35 25 &
  gpio_pwm 21 10000 35 25
  gpio_pwm 20 10000 35 5 &
  gpio_pwm 21 10000 35 5
  gpio_pwm 20 10000 35 25 &
  gpio_pwm 21 10000 35 25
  gpio_pwm 20 10000 35 5 &
  gpio_pwm 21 10000 35 5
  gpio_pwm 20 10000 20 15 &
  gpio_pwm 21 10000 20 14
fi


done
