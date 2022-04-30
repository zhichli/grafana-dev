#!/bin/bash

host=grafana-dev-postgresql.postgres.database.azure.com
dbname=grafanadev
user=grafanaadmin
pswdname=grafana-dev-postgresql-admin-pswd

subId=9ae4be82-c5a9-4053-b0fa-a23c5e503297 # Dev-zhichli
kvname=grafana-dev-kv

az login
az account set -s $subId
pswd=$(az keyvault secret show --name "$pswdname" --vault-name $kvname --query "value" -o tsv)
psql "host=$host port=5432 dbname=$dbname user=$user password=$pswd sslmode=require"
