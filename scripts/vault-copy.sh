#!/bin/bash

usage() {
    echo "Usage: $0 source destination"
    exit 1
}

[[ $# -lt 2 ]] && usage

SRC_VAULT_PATH=$1
DST_VAULT_PATH=$2

SECRET_LIST=$(vault list "$SRC_VAULT_PATH" | tail -n+3)
for SECRET in $SECRET_LIST; do
    SRC_SECRET_NAME="${SRC_VAULT_PATH}/${SECRET}"
    DST_SECRET_NAME="${DST_VAULT_PATH}/${SECRET}"
    vault read -format=json -field=data "$SRC_SECRET_NAME" | vault write "$DST_SECRET_NAME" -
done
