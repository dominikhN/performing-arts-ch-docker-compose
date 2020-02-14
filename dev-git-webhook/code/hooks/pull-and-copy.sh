#!/bin/sh
GIT_DIRECTORY="/git"

if [ -d "$GIT_DIRECTORY" ]; then
	cd ${GIT_DIRECTORY}/*
	git pull origin
	cp -R ./* /apps/${WEBHOOK_APP_DIRECTORY}
else
        echo "Initial GIT checkout."
        mkdir ${GIT_DIRECTORY}
        cd ${GIT_DIRECTORY}
        git clone -b ${WEBHOOK_BRANCH_LIST} ${WEBHOOK_GIT_REPOSITORY}
        cd ./*
        mkdir /apps/${WEBHOOK_APP_DIRECTORY}
        chown -R 100:101 /apps/${WEBHOOK_APP_DIRECTORY}
        cp -R ./* /apps/${WEBHOOK_APP_DIRECTORY}
fi

