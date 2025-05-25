
## Objetivo
Criação de um ambiente com estrutura Hub-Spoke com NSG + Peering + Bastion

## Recursos
    -- VNET     - VNET-HUB e VNET-SPOKE01
    -- Subnet   - VNET-HUB/shared e VNET-SPOKE01/services
    -- peerings - Peering entre VNET-HUB e VNET-SPOKE01
    -- NSG      - NSG-shared (referente a VNET-HUB/shared) e NSG-services (referente a VNET-SPOKE01/services)

## Diagrama
lab01-hub-spoke.drawio

## Documentação (Doc)
Print das VNets, subnets, peerings e regras