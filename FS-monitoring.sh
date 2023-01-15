LOG=/tmp/MON.log     #Log file contains beyond threshold file-system across OS
ALERT=/tmp/ALERT.log #Log file contains that needs to be alerted
EXCLUDE=/tmp/EXCLUDEFS.log #Log file contains the filesystem needs to be excluded
MAIL=/tmp/MAIL.log #Log file for sending mail
##################################################################################
THOLD=90      # Can be modify as per the requirement
cat /dev/null > $LOG
cat /dev/null > $ALERT
cat /dev/null > $MAIL
for i in `df -g | egrep -v /proc | egrep -v sapdata | egrep -v File | awk '{print $7}'`
do if [ `df -g $i | grep -v File | awk '{print $4}' | tr -d '%'` -ge $THOLD ] ; then
echo "`df -g $i | grep -v File | awk '{print $7}'`"
fi
done >>$LOG
df -g | egrep File >>$MAIL
for i in `cat $LOG`
do
FOUND=0
  for j in `cat $EXCLUDE`
  do
     if [ $i == $j ]; then
FOUND=1
     fi
  done
  if [ $FOUND -eq 0 ]; then
     echo "$i"
  fi
done >>$ALERT
for i in `cat $ALERT` ; do df -g $i | grep -v File ; done>>$MAIL
mail -s "Test Alert from `hostname`" ab@c.com  <$MAIL

