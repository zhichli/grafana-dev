#!/bin/bash

subId=9ae4be82-c5a9-4053-b0fa-a23c5e503297 # Dev-zhichli
kvname=grafana-dev-kv
pswdname=grafana-dev-postgresql-admin-pswd

az login
az account set -s $subId
pswd=$(az keyvault secret show --name "$pswdname" --vault-name $kvname --query "value" -o tsv | tr -d '\r')
customini=custom.ini
cp template_$customini $customini
sed -i "s|POSTGRESQL_DATABASE_PSWD|$pswd|g" $customini

sudo apt install dos2unix
dos2unix $customini

#mv $customini ~/grafana/conf
ln -s -f ../../grafana-dev/$customini ~/grafana/conf/$customini
