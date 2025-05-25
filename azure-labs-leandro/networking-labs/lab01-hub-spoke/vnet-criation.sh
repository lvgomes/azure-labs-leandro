#!/bin/bash
# -----------------------------------------------------------------------------
# Nome do Script: vnet-criation.sh
# Autor: Leandro Vicente
# Data: 25/05/2025
# Descrição: Este script realiza a criação das Vnets VNET-HUB e VNET-SPOKE01, com suas respectivas Subnetes.
# Uso: ./vnet-criation.sh
# -----------------------------------------------------------------------------

## Login interativo no portal Azure
#az login

## Definindo subscription a ser utilizada
#az account set --subscription "3f67c1d8-cf4f-4ede-bfe8-ced4a1da9e1f"

## Criação do Resource Group (Network)
LOCATION="brazilsouth"
az group create -l $LOCATION -n network-rg 
resourceGroup="network-rg"

## Criação das VNETS
vnetName01=VNET-HUB
vnetAddressPrefix01=192.168.254.0/24

vnetName02=VNET-SPOKE01
vnetAddressPrefix02=192.168.1.0/24

az network vnet create \
  --name $vnetName01 \
  --resource-group $resourceGroup \
  --address-prefixes $vnetAddressPrefix01

az network vnet create \
  --name $vnetName02 \
  --resource-group $resourceGroup \
  --address-prefixes $vnetAddressPrefix02

## Criação da subrede para VNET - VNET-HUB
subnetName01=shared
az network vnet subnet create -g $resourceGroup --vnet-name $vnetName01 -n $subnetName01 --address-prefixes 192.168.254.0/25

## Criação da subrede para VNET - VNET-SPOKE01
subnetName02=services
az network vnet subnet create -g $resourceGroup --vnet-name $vnetName02 -n $subnetName02 --address-prefixes 192.168.1.0/25

## Criando uma NSG e associando a subrede VNET-HUB/shared
nsgName01="NSG-shared"
az network nsg create -g $resourceGroup -n $nsgName01
nsgId01=$(az network nsg show --name $nsgName01 --resource-group $resourceGroup --query id -o tsv)
az network vnet subnet update -g $resourceGroup --vnet-name $vnetName01 -n $subnetName01 --network-security-group $nsgId01