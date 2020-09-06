#!/bin/sh

ROLE_NAME=$1
vault write -wrap-ttl=60s -f auth/approle/role/$ROLE_NAME/secret-id