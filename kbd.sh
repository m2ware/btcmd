#  Need to run this with SUDO to work...
PULSES=1

while IFR= read -n 1 VALUE
do

echo $VALUE

# UpperLeft btn -> Low-Hi
if [ $VALUE == "1" ]
then
  PULSES=5
  echo Speed=$PULSES
fi

# BtmLeft btn -> Low-Low
if [ $VALUE == "2" ]
then
  PULSES=1
  echo Speed=$PULSES
fi

if [ $VALUE == "3" ]
then
  PULSES=15
  echo Speed=$PULSES
fi

./motorControl.sh $VALUE $PULSES

done
