#!/bin/bash

declare -i group_counter=`cat /etc/group|grep -v nobody| awk -F: '{print $3}'|sort -nrk1,1| head -1`+1
declare -i user_counter=`cat /etc/passwd|grep -v nobody| awk -F: '{print $3}'|sort -nrk1,1| head -1`+1

PRODUCT_GROUP=`cat parameters.json | jq '.operating_system.os_groups.product_group'|sed -e 's/^"//' -e 's/"$//'`
RDBMS_GROUP=`cat parameters.json | jq '.operating_system.os_groups.rdbms_group'|sed -e 's/^"//' -e 's/"$//'`
GRID_GROUP=`cat parameters.json | jq '.operating_system.os_groups.grid_group'|sed -e 's/^"//' -e 's/"$//'`
GRID_OWNER=`cat parameters.json | jq '.operating_system.os_users.grid_owner'|sed -e 's/^"//' -e 's/"$//'`
RDBMS_OWNER=`cat parameters.json | jq '.operating_system.os_users.rdbms_owner'|sed -e 's/^"//' -e 's/"$//'`



groupadd $PRODUCT_GROUP -g $group_counter; group_counter=$group_counter+1
groupadd $RDBMS_GROUP -g $group_counter; group_counter=$group_counter+1
groupadd $GRID_GROUP -g $group_counter; group_counter=$group_counter+1

#groupadd backupdba -g 504
#groupadd dgdba -g 505
#groupadd kmdba -g 506
#groupadd asmadmin -g 507
#groupadd asmdba -g 508
#groupadd asmoper -g 509

#useradd -u $user_counter -g $PRODUCT_GROUP -G $RDBMS_GROUP,$GRID_GROUP $GRID_OWNER; user_counter=$user_counter+1
#useradd -u $user_counter -g $PRODUCT_GROUP -G $RDBMS_GROUP,$GRID_GROUP $RDBMS_OWNER; user_counter=$user_counter+1