#!/bin/bash

subId=9ae4be82-c5a9-4053-b0fa-a23c5e503297 # Dev-zhichli
kvname=grafana-dev-kv
secretname_adx=CLIENTSECRET-zhichli-grafana-adx-sp
secretname_prom_mdm=grafana-aad-app-client-secret

az login
az account set -s $subId
clientsecret_adx=$(az keyvault secret show --name "$secretname_adx" --vault-name $kvname --query "value" -o tsv | tr -d '\r')
clientsecret_prom_mdm=$(az keyvault secret show --name "$secretname_prom_mdm" --vault-name $kvname --query "value" -o tsv | tr -d '\r')
provisioningfolder=provisioning
datasourcesyaml=datasources.yaml
cp $provisioningfolder/template_$datasourcesyaml $datasourcesyaml
sed -i "s|$secretname_adx|$clientsecret_adx|g" $datasourcesyaml
sed -i "s|$secretname_prom_mdm|$clientsecret_prom_mdm|g" $datasourcesyaml

sudo apt install dos2unix
dos2unix $datasourcesyaml
ln -s -f ../../../../grafana-dev/$datasourcesyaml ~/grafana/conf/provisioning/datasources/dev.yaml

# plugins (only used for testing the published plugins; do not use this when testing local plugins)
pluginsyaml=$provisioningfolder/plugins.yaml
dos2unix $pluginsyaml
#ln -s -f ../../../../grafana-dev/$pluginsyaml ~/grafana/conf/provisioning/plugins/dev.yaml

# dashboards
dashboardsyaml=$provisioningfolder/dashboards.yaml
dos2unix $dashboardsyaml
ln -s -f ../../../../grafana-dev/$dashboardsyaml ~/grafana/conf/provisioning/dashboards/dev.yaml