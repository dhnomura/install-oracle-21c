#!/bin/bash

ORACLE_BASE=`cat parameters.json | jq '.operating_system.directories.oracle_base'|sed -e 's/^"//' -e 's/"$//'`
PRODUCT_GROUP=`cat parameters.json | jq '.operating_system.os_groups.product_group'|sed -e 's/^"//' -e 's/"$//'`
ORAIVENTORY=`cat parameters.json | jq '.operating_system.directories.oraInventory'|sed -e 's/^"//' -e 's/"$//'`

ASM_DISKGROUP_DATA_NAME=`cat parameters.json | jq -c '.grid.diskgroups[]|select(.dg_uso|contains("rdbms_data_cdb"     )).dg_name'|sed -e 's/^"//' -e 's/"$//'`
ASM_DISKGROUP_DATA_REDUNDANCY=`cat parameters.json | jq -c '.grid.diskgroups[]|select(.dg_uso|contains("rdbms_data_cdb"     )).dg_redundancy'|sed -e 's/^"//' -e 's/"$//'`

TFA_HOME=`cat parameters.json | jq '.operating_system.directories.tfa_home'|sed -e 's/^"//' -e 's/"$//'`
GRID_BASE=`cat parameters.json | jq '.operating_system.directories.grid_base'|sed -e 's/^"//' -e 's/"$//'`
GRID_HOME=`cat parameters.json | jq '.operating_system.directories.grid_home'|sed -e 's/^"//' -e 's/"$//'`
ORACLE_HOME=`cat parameters.json | jq '.operating_system.directories.oracle_home'|sed -e 's/^"//' -e 's/"$//'`
RDBMS_GROUP=`cat parameters.json | jq '.operating_system.os_groups.rdbms_group'|sed -e 's/^"//' -e 's/"$//'`
GRID_GROUP=`cat parameters.json | jq '.operating_system.os_groups.grid_group'|sed -e 's/^"//' -e 's/"$//'`
GRID_OWNER=`cat parameters.json | jq '.operating_system.os_users.grid_owner'|sed -e 's/^"//' -e 's/"$//'`
RDBMS_OWNER=`cat parameters.json | jq '.operating_system.os_users.database_owner'|sed -e 's/^"//' -e 's/"$//'`
ORACLE_SID=`cat parameters.json | jq '.oracle_rdbms.sid_name'|sed -e 's/^"//' -e 's/"$//'`

GRID_HOME=`cat parameters.json | jq '.grid.directories.grid_home'|sed -e 's/^"//' -e 's/"$//'`

echo " 
oracle.install.responseFileVersion=/oracle/install/rspfmt_crsinstall_response_schema_v21.0.0
oracle.install.option=INSTALL_DB_SWONLY
UNIX_GROUP_NAME=$PRODUCT_GROUP
INVENTORY_LOCATION=$ORAIVENTORY
SELECTED_LANGUAGES=en,en_GB
ORACLE_HOME=$ORACLE_HOME
ORACLE_BASE=$ORACLE_BASE
oracle.install.db.InstallEdition=EE
oracle.install.db.OSDBA_GROUP=$RDBMS_GROUP
oracle.install.db.OSBACKUPDBA_GROUP=$RDBMS_GROUP
oracle.install.db.OSDGDBA_GROUP=$RDBMS_GROUP
oracle.install.db.OSKMDBA_GROUP=$RDBMS_GROUP
oracle.install.db.OSRACDBA_GROUP=$RDBMS_GROUP
SECURITY_UPDATES_VIA_MYORACLESUPPORT=false
DECLINE_SECURITY_UPDATES=true
">/tmp/install_oracle/reponse_files/setuprdbms.rsp
chown $ORACLE_HOME:$PRODUCT_GROUP /tmp/install_oracle/reponse_files/setuprdbms.rsp