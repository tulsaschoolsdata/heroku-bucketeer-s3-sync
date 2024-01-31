#!/usr/bin/env bash

set -e

export PATH="$PATH:/snap/bin"

cd /home/snipeit/heroku-bucketeer-s3-sync

docker compose up -d

# Delay for s3fs to establish mount
sleep 5

echo '---' >> logs/cron.log
date >> logs/cron.log

#./run.sh tpsdata-production--import >> logs/cron.log 2>&1
./run.sh tpsdata-production--import

echo "exit: $?" >> logs/cron.log
date >> logs/cron.log
