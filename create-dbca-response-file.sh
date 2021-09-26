#!/bin/bash

#Parameter for Database Installation
ORACLE_BASE=`cat parameters.json | jq '.operating_system.directories.oracle_base'|sed -e 's/^"//' -e 's/"$//'`
PRODUCT_GROUP=`cat parameters.json | jq '.operating_system.directories.product_group'|sed -e 's/^"//' -e 's/"$//'`
ORAIVENTORY=`cat parameters.json | jq '.operating_system.directories.oraInventory'|sed -e 's/^"//' -e 's/"$//'`

ASM_DISKGROUP_DATA_NAME=`cat parameters.json | jq -c '.grid.diskgroups[]|select(.dg_uso|contains("rdbms_data_cdb"     )).dg_name'|sed -e 's/^"//' -e 's/"$//'`
ASM_DISKGROUP_DATA_REDUNDANCY=`cat parameters.json | jq -c '.grid.diskgroups[]|select(.dg_uso|contains("rdbms_data_cdb"     )).dg_redundancy'|sed -e 's/^"//' -e 's/"$//'`

TFA_HOME=`cat parameters.json | jq '.operating_system.directories.tfa_home'|sed -e 's/^"//' -e 's/"$//'`
GRID_BASE=`cat parameters.json | jq '.operating_system.directories.grid_base'|sed -e 's/^"//' -e 's/"$//'`
GRID_HOME=`cat parameters.json | jq '.operating_system.directories.grid_home'|sed -e 's/^"//' -e 's/"$//'`
ORACLE_HOME=`cat parameters.json | jq '.operating_system.directories.oracle_home'|sed -e 's/^"//' -e 's/"$//'`
RDBMS_GROUP=`cat parameters.json | jq '.operating_system.os_groups.rdbms_group'|sed -e 's/^"//' -e 's/"$//'`
GRID_GROUP=`cat parameters.json | jq '.operating_system.os_groups.grid_group'|sed -e 's/^"//' -e 's/"$//'`
GRID_OWNER=`cat parameters.json | jq '.operating_system.os_groups.grid_owner'|sed -e 's/^"//' -e 's/"$//'`
RDBMS_OWNER=`cat parameters.json | jq '.operating_system.os_groups.database_owner'|sed -e 's/^"//' -e 's/"$//'`
ORACLE_SID=`cat parameters.json | jq '.oracle_rdbms.sid_name'|sed -e 's/^"//' -e 's/"$//'`

# Parameter for DBCA
SID_NAME=`cat database_parameters.json | jq '.oracle_rdbms.sid'|sed -e 's/^"//' -e 's/"$//'`
DB_CONFIG_TYPE=`cat database_parameters.json | jq '.oracle_rdbms.databaseConfigType'|sed -e 's/^"//' -e 's/"$//'`
CDB_NAME=`cat database_parameters.json | jq '.oracle_rdbms.cdb_name'|sed -e 's/^"//' -e 's/"$//'`
DB_UNQ_NAME=`cat database_parameters.json | jq '.oracle_rdbms.db_unq_name'|sed -e 's/^"//' -e 's/"$//'`
PDB_NAME=`cat database_parameters.json | jq '.oracle_rdbms.pdbName'|sed -e 's/^"//' -e 's/"$//'`
PDB_ADMIN_PASS=`cat database_parameters.json | jq '.oracle_rdbms.pdbAdminPassword'|sed -e 's/^"//' -e 's/"$//'`
TEMPLATE_NAME=`cat database_parameters.json | jq '.oracle_rdbms.templateName'|sed -e 's/^"//' -e 's/"$//'`
SYS_PASS=`cat database_parameters.json | jq '.oracle_rdbms.sysPassword'|sed -e 's/^"//' -e 's/"$//'`
DB_FILE_PATH=`cat database_parameters.json | jq '.oracle_rdbms.datafileDestination'|sed -e 's/^"//' -e 's/"$//'`
FRA_FILE_PATH=`cat database_parameters.json | jq '.oracle_rdbms.recoveryAreaDestination'|sed -e 's/^"//' -e 's/"$//'`
CHARSET=`cat database_parameters.json | jq '.oracle_rdbms.characterSet'|sed -e 's/^"//' -e 's/"$//'`
NCHARSET=`cat database_parameters.json | jq '.oracle_rdbms.nationalCharacterSet'|sed -e 's/^"//' -e 's/"$//'`

echo "
responseFileVersion=/oracle/assistants/rspfmt_dbca_response_schema_v21.0.0
sid=$SID_NAME
databaseConfigType=$DB_CONFIG_TYPE
gdbName=$CDB_NAME
pdbName=$PDB_NAME
pdbAdminPassword=$PDB_ADMIN_PASS
templateName=$TEMPLATE_NAME
sysPassword=$SYS_PASS
systemPassword=$SYS_PASS
datafileDestination=$DB_FILE_PATH
recoveryAreaDestination=$FRA_FILE_PATH
characterSet=$CHARSET
nationalCharacterSet=$NCHARSET
">dbca-create-db.rsp
