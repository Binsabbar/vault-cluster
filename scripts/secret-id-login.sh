#!/bin/bash

if [ -z "$APPROLE_ID" ]; then
  echo "APPROLE_ID is not set"
  exit
fi

if [ -z "$APPROLE_SECRET_ID" ]; then
  echo "APPROLE_SECRET_ID is not set"
  exit
fi

vault write auth/approle/login role_id=$APPROLE_ID secret_id=$APPROLE_SECRET_ID
