# install-oracle-21c


# Prerequisite

## Oracle Software

Already downloaded Oracle software and transfer to database server

## RAM

At least 1 GB RAM for Oracle Database installations. 2 GB RAM recommended.

## OS

Red Hat Enterprise Linux 8.2: 4.18.0-193.19.1.el8_2.x86_64 or later

## Server Configuration

/tmp - 1GB
SWAP - 2GB - 16GB

Storage Check List - 50 GB

## Installing

./install-oracle.py 

################################################################

Hello, you are AWESOME! Let me help you install your database!
You just need to answer some questions.

################################################################

Can we start? (Y/N) : Y
Y
Y

Did you already download the software? (Y/N) : Y
Y

Product group (oinstall) : 
oinstall

RDBMS Owner (oracle) : 
oracle

RDBMS group (dba) : 
dba

TFA Dir: (/u01/app/tfa) : 
/u01/app/tfa

Oracle Base dir: (/u01/app/oracle) : 
/u01/app/oracle

Oracle Home dir: (/u01/app/oracle/product/21.0.0/rdbms) : 
/u01/app/oracle/product/21.0.0/rdbms

Oracle Inventory: (/u01/app/oraInventory) : 
/u01/app/oraInventory

Software download location (/u01/install) : /tmp/stage_oracle/install-oracle-21c-main
/tmp/stage_oracle/install-oracle-21c-main

Software binary name, should be (LINUX.X64_213000_db_home.zip) : 
LINUX.X64_213000_db_home.zip

Would you like to create users and groups? (Y/N) : Y
creating users and groups

Would you like to directories? (Y/N) : Y

Would you like to extract Oracle Software Binary? (Y/N) : Y

Would you like to install missing package? (Y/N) : Y

Would you like adjust kernel parameters? (Y/N) : Y
Adjusting kernel parameters

Would you like to create the installation response file? (Y/N) : Y
Create universal installer response file
chown: invalid user: ‘/u01/app/oracle/product/21.0.0/rdbms:oinstall’
chmod: cannot access 'setuprdbms.rsp': No such file or directory

