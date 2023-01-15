# Version #1.0 and date 20-Nov-2011 [script created]
DT=`date +%H%M%S_%d%m%y`
LDEST="/usr/es/sbin/cluster/snapshots"
RSRVR="rsupbur3"
RDEST="/Sysconfig_html"
/usr/es/sbin/cluster/utilities/clsnapshot -c -i -n `/usr/es/sbin/cluster/utilities/clshowres | grep Participating  | head -n 1 | awk '{print $4"_"$5}'`  -d `/usr/es/sbin/cluster/utilities/cltopinfo | egrep "Cluster Name" | awk '{print $3}'`
df | grep $RSRVR | grep $RDEST
if [ $? = 1 ]; then
mount $RSRVR:$RDEST /mnt16
fi
mv `/usr/es/sbin/cluster/utilities/clshowres | grep Participating  | head -n 1 | awk '{print $4"_"$5}'.info /mnt16
mv `/usr/es/sbin/cluster/utilities/clshowres | grep Participating  | head -n 1 | awk '{print $4"_"$5}'.odm /mnt16
find $RDEST -name *.odm -mtime +50 -exec rm {} \;
find $RDEST -name *.info -mtime +50 -exec rm {} \;
umount $RDEST
