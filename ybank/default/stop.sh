#!/usr/bin/env bash
#./stop.sh -p /home/crom/apps/ybank/default -a ybank
echo $# $*

while getopts ":p:a:" opt
do
	case ${opt} in
		p) project_home=${OPTARG};;
		a) app_name=${OPTARG};;
	esac
done

project_home=${project_home:=/home/crom/apps/ybank/default}
app_name=${app_name:=ybank}
cd ${project_home}

KPID=`ps -eaf | grep "${app_name}.wsgi" | grep -v grep | awk '{print $2}'`
if [[ "" !=  "$KPID" ]]; then
  echo "KILL TERM Tomcat $KPID"
  kill -TERM $KPID
fi

sleep 3
KPID=`ps -eaf | grep "${app_name}.wsgi" | grep -v grep | awk '{print $2}'`
if [[ "" !=  "$KPID" ]]; then
  echo "KILL 9 Tomcat $KPID"
  kill -9 $KPID
fi