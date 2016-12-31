#!/usr/bin/env bash
echo $# $*

if [ $# -ne 2 ]
then
    echo '[ERROR]./deploy.sh -p PROJECT_NAME'
    exit
fi

while getopts ":p:" opt
do
	case ${opt} in
		p) project=${OPTARG};;
	esac
done

# echo ${project}-'deploy'
project_home=/home/crom/apps/app/${project}/default
app_name=${project}
backup_home=/home/crom/apps/backup/${app_name}

${project_home}/stop.sh -p ${project_home} -a ${app_name}

folder=$(date +"%y%m%d")
now=$(date +"%H%M%S")
mkdir -p ${backup_home}/${folder}
tar -zcvf ${backup_home}/${now}.tar.gz ${project_home}/**/*

git checkout -f devleop
git reset --hard origin/devleop

sleep 1
${project_home}/start.sh -p ${project_home} -a ${app_name}
