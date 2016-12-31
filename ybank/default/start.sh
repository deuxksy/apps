#!/usr/bin/env bash
#./start.sh -p /home/crom/apps/ybank/default -a ybank
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
log_home=${project_home:=:=/home/crom/apps/log/${app_name}}
cd ${project_home}

nohup gunicorn ${app_name}.wsgi -b 0.0.0.0:8000 & > ${log_home}/log

sleep 3
SPID=`ps -eaf | grep "${app_home}.wsgi" | grep -v grep | awk '{print $2}'`
if [[ "" !=  "$SPID" ]]; then
  echo "Start Django $SPID"
fi
