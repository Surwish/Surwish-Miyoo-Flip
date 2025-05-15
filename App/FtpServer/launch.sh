#!/bin/sh
echo $0 $*
cd $(dirname "$0")
if [ -f $(dirname "$0")/.on ] ; then
	# server on
	pkill -9 bftpd
	./bftpd -c bftpd.conf -d
	# delete mask
	rm $(dirname "$0")/.on
else 
	# server off
killall -9 bftpd
	# add mask
	touch $(dirname "$0")/.on
fi
sync
