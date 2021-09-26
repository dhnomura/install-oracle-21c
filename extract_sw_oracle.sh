#!/bin/bash

Q_SOFT_LOCATION=`cat parameters.json | jq '.operating_system.directories.software_download_location'|sed -e 's/^"//' -e 's/"$//'`
Q_SOFT_NAME=`cat parameters.json | jq '.operating_system.directories.software_name'|sed -e 's/^"//' -e 's/"$//'`
ORACLE_HOME=`cat parameters.json | jq '.operating_system.directories.oracle_home'|sed -e 's/^"//' -e 's/"$//'`
RDBMS_OWNER=`cat parameters.json | jq '.operating_system.os_users.rdbms_owner'|sed -e 's/^"//' -e 's/"$//'`
echo "unzip $Q_SOFT_LOCATION/$Q_SOFT_NAME -d $ORACLE_HOME" > /tmp/extract.tmp
chmod +775 /tmp/extract.tmp
sudo -H -u $RDBMS_OWNER bash -c '/tmp/extract.tmp'
