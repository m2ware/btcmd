#  Need to run this with SUDO to work...
PULSES=1
HIDPATH="/dev/hidraw0"

stdbuf -oL btcmd --numeric $HIDPATH |
while IFR= read -r VALUE
do

echo $VALUE
CHAR=" "

# LEFT
if [ $VALUE -eq 4 ]
then
#  let CHAR="a"
  echo "1"
fi
# RIGHT
if [ $VALUE -eq 7 ]
then
#  let CHAR="d"
  echo "1"
fi
# UP
if [ $VALUE -eq 26 ]
then
#  let CHAR="w"
  echo "1"
fi
# DOWN
if [ $VALUE -eq 27 ]
then
#  let CHAR="x"
  echo "1"
fi

# Start -> go to neutral
if [ $VALUE -eq 24 ]
then
#  let CHAR="s"
  echo "1"
fi

# LeftBumper -> Go full
if [ $VALUE -eq 11 ]
then
#  let CHAR="q"
  echo "1"
fi

# RightBumper -> Go full
if [ $VALUE -eq 13 ]
then
#  let CHAR="e"
  echo "1"
fi

#BtmRight btn -> do a dance
if [ $VALUE -eq 15 ]
then
#  let CHAR="0"
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

./motorControl.sh $CHAR $PULSES

done
