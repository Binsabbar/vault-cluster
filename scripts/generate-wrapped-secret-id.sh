#!/bin/sh

ROLE_NAME=$1

if [ -z "$ROLE_NAME" ]; then
  echo "ROLE_NAME is not given"
  exit
fi

vault write -wrap-ttl=60s -f auth/approle/role/$ROLE_NAME/secret-id
