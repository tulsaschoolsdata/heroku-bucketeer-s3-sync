#!/usr/bin/env bash

set -e

BUCKET_PATH="$(echo "$1" | sed 's#s3://##' | tr -s '/' | sed 's#/$##')"

[ -n "$BUCKET_PATH" ] || (>&2 echo 'bucket/path is required'; exit 1)
[ ! -f 'logs/sync.log' ] || (>&2 echo 'logs/sync.log exists'; exit 2)

function timer() {
  local start_time=$(date +%s)

  "$@"

  local elapsed_seconds="$(($(date +%s) - $start_time))"
  echo "Total time elapsed: $(seconds_format "$elapsed_seconds") (HH:MM:SS)"
}

function seconds_format_gnu() {
  date -u -d "@$1" +%T
}

function seconds_format_mac() {
  date -u -j -f "%s" "$1" +%T
}

function seconds_format() {
  (seconds_format_gnu "$1" || seconds_format_mac "$1") 2>/dev/null
}

function sync() {
  docker compose run -i --rm s3fs aws s3 sync /mnt/ "s3://$BUCKET_PATH/" --no-progress
}

function main() {
  date ; echo
  sync ; echo
  date ; echo
}

timer main | tee logs/sync.log

mv logs/sync.log "logs/sync-$(date '+%Y%m%d%H%M%S').log"
