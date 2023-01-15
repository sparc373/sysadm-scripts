#!/bin/sh
## Kill session script
CURRENT=`ps | grep ksh | grep -v grep | awk '{print $1}'`
PREV_SEN=`who -u | grep $LOGNAME | sort -k5,5 | egrep -v "$CURRENT" | tail -n -1 | awk '{print $7}' | sort`
OLD_SEN=`who -u | grep $LOGNAME | egrep -v "$CURRENT|$PREV_SEN" | sort -k5,5  | tail -n -1 | awk '{print $7}'`
OLDEST_SEN=`who -u | grep $LOGNAME | egrep -v "$CURRENT|$PREV_SEN|$OLD_SEN" | sort -k5,5  | tail -n -1 | awk '{print $7}'`
echo "Kindly select one of the following sessions needs to be killed"
echo " 1. Press 1 for 1stSessions    \n"
echo " 2. Press 2 for 2nd Sessions    \n"
echo " 3. Press 3 for 3rd Sessions    \n"
echo " 4. Press 4 to exit \n"

read SESSION

case $SESSION in

1) kill -HUP $OLDEST_SEN ;;
2) kill -HUP $OLD_SEN ;;
3) kill -HUP $PREV_SEN ;;
4) exit ;;
esac
