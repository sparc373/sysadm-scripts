#!/bin/sh
##FLAR Backup Report
for i in servera serverb serverc
do
RLOGL=`ssh $i ls -lrt /opt/backup/flar | grep flar_create | tail -1 | awk '{print $9}'`
RSLT=`ssh $i cat /opt/backup/flar/$RLOGL | grep Script | awk '{print $5}'`
STDT=`ssh $i cat /opt/backup/flar/$RLOGL | head -n +2 | tail -1 | awk '{print $3"/"$2"/"$6}'`
STTT=`ssh $i cat /opt/backup/flar/$RLOGL | head -n +2 | tail -1 | awk '{print $4}'`
ETDT=`ssh $i cat /opt/backup/flar/$RLOGL | tail -2 | head -n +1 | awk '{print $3"/"$2"/"$6}'`
ETTT=`ssh $i cat /opt/backup/flar/$RLOGL | tail -2 | head -n +1 | awk '{print $4}'`
if [ "$RSLT" == "successfully......" ] ; then
RSLT1="SUCCESS"
FLNM=`ls -lrt /backup/integration/flar_$i* | grep $i  | tail -1 | awk '{print $9}'`
FLSZ=`du -sh /backup/integration/flar_$i*/$FLNM | awk '{print $1}'`
echo -e "STATUS: \t $i \t $RSLT1 \t $STDT \t $STTT \t $ETDT \t $ETTT \t flar backup is successful in $i server" >>/home/hprasad1/log.txt
else
RSLT1="FAILED"
echo -e "STATUS: \t $i \t ---NA--- \t ---NA--- \t ---NA--- \t ---NA--- \t ---NA--- \t flar backup is failed in $i server" >>/home/hprasad1/log.txt
fi
done
