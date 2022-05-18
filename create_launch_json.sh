#!/bin/bash

subId=9ae4be82-c5a9-4053-b0fa-a23c5e503297 # Dev-zhichli
kvname=grafana-dev-kv
identityheadername=AuthContext--IDENTITYHEADER

az login
az account set -s $subId
identityheader=$(az keyvault secret show --name "$identityheadername" --vault-name $kvname --query "value" -o tsv | tr -d '\r')
launchjson=launch.json
cp template_$launchjson $launchjson
sed -i "s|IDENTITYHEADER|$identityheader|g" $launchjson

sudo apt install dos2unix
dos2unix $launchjson

#mv $launchjson ~/grafana/.vscode
ln -s -f ../../grafana-dev/$launchjson ~/grafana/.vscode/$launchjson
