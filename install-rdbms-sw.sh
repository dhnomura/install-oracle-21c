#!/bin/bash

Q_SOFT_LOCATION=`cat parameters.json | jq '.operating_system.directories.software_download_location'|sed -e 's/^"//' -e 's/"$//'`
Q_SOFT_NAME=`cat parameters.json | jq '.operating_system.directories.software_name'|sed -e 's/^"//' -e 's/"$//'`
ORACLE_HOME=`cat parameters.json | jq '.operating_system.directories.oracle_home'|sed -e 's/^"//' -e 's/"$//'`
RDBMS_OWNER=`cat parameters.json | jq '.operating_system.os_users.rdbms_owner'|sed -e 's/^"//' -e 's/"$//'`
echo "/u01/app/oracle/product/21.0.0/rdbms/runInstaller -ignorePrereq -waitforcompletion -silent -responseFile /tmp/setuprdbms.rsp" > /tmp/install_rdbms_ora.sh
chmod +775 /tmp/install_rdbms_ora.sh
sudo -H -u $RDBMS_OWNER bash -c '/tmp/install_rdbms_ora.sh'
