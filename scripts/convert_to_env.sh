#!/bin/bash

cat | jq ".data.data" | sed -e "s/  \"//" | sed -e "s/\":\ /=/" | sed -e "s/\",/\"/" | sed -E "s/\{|\}//"
