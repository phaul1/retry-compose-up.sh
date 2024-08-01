#!/bin/bash

MAX_RETRIES=5
RETRY_DELAY=10

function start_docker_compose {
  docker-compose up -d
  local status=$?
  if [ $status -ne 0 ]; then
    echo "Docker compose failed with status $status"
  fi
  return $status
}

retries=0
until start_docker_compose; do
  if [ $retries -eq $MAX_RETRIES ]; then
    echo "Max retries reached. Exiting."
    exit 1
  fi
  echo "Retrying in $RETRY_DELAY seconds..."
  sleep $RETRY_DELAY
  retries=$((retries + 1))
done
