#!/bin/bash

function check_dir {
    DIR=$VAL
    if [ -d "$DIR" ]; then
        ### Take action if $DIR exists ###
        chown $GRID_OWNER:$PRODUCT_GROUP $DIR
        chmod 775 $DIR 
    else
        ###  Control will jump here if $DIR does NOT exists ###
        mkdir -p $DIR
        chown $GRID_OWNER:$PRODUCT_GROUP $DIR 
        chmod 775 $DIR
    fi
}


TFA_HOME=`cat parameters.json | jq '.[operating_system.tfa_home'|sed -e 's/^"//' -e 's/"$//'`
ORAIVENTORY=`cat parameters.json | jq '.operating_system.oraInventory'|sed -e 's/^"//' -e 's/"$//'`
GRID_BASE=`cat parameters.json | jq '.operating_system.grid_base'|sed -e 's/^"//' -e 's/"$//'`
ORACLE_BASE=`cat parameters.json | jq '.operating_system.oracle_base'|sed -e 's/^"//' -e 's/"$//'`
GRID_HOME=`cat parameters.json | jq '.operating_system.grid_home'|sed -e 's/^"//' -e 's/"$//'`
ORACLE_HOME=`cat parameters.json | jq '.operating_system.oracle_home'|sed -e 's/^"//' -e 's/"$//'`

PRODUCT_GROUP=`cat parameters.json | jq '.operating_system.product_group'|sed -e 's/^"//' -e 's/"$//'`
RDBMS_GROUP=`cat parameters.json | jq '.operating_system.rdbms_group'|sed -e 's/^"//' -e 's/"$//'`
GRID_GROUP=`cat parameters.json | jq '.operating_system.grid_group'|sed -e 's/^"//' -e 's/"$//'`
GRID_OWNER=`cat parameters.json | jq '.operating_system.grid_owner'|sed -e 's/^"//' -e 's/"$//'`
RDBMS_OWNER=`cat parameters.json | jq '.operating_system.database_owner'|sed -e 's/^"//' -e 's/"$//'`
ORACLE_SID=`cat parameters.json | jq '.oracle_rdbms.sid_name'|sed -e 's/^"//' -e 's/"$//'`

cat parameters.json \
    |jq '.operating_system.directories' \
    |sed -e 's/^"//' -e 's/"$//' \
    |awk -F ":" '{print $2}' \
    |sed -e 's/"//' -e 's/",//' \
    |awk 'NF' \
    |while read VAL 
    do
        check_dir
    done

echo "
export ORACLE_BASE=$ORACLE_BASE
export ORACLE_HOME=$ORACLE_HOME
export ORA_INVENTORY=$ORAIVENTORY
export ORACLE_SID=cdb1
export PATH=$PATH:$PATH:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch
" >> /home/oracle/.bash_profile

echo "
export ORACLE_BASE=$GRID_BASE
export ORACLE_HOME=$GRID_HOME
export ORA_INVENTORY=$ORAIVENTORY
export ORACLE_SID=cdb1
export PATH=$PATH:$PATH:$ORACLE_HOME/bin:$ORACLE_HOME/OPatch
" >> /home/grid/.bash_profile