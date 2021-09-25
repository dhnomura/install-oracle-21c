#!/usr/bin/python3

# libs

import os           #OS module
import subprocess   #Import subprocess
import shlex        #Pass SO parameters
import json         #Working with json

# Functions

def ask_yn(a):
    check=a
    try:
        if check.lower() == 'y':
            print(a)
            return True
        elif check.lower() == 'n':
            print(a)
            return False
        else:
            print(a)
            print('Invalid Input')
    except Exception as error:
        print("Please enter valid inputs")
        print(error)
        return ask_yn()

# Main Code
print('################################################################')
print('')
print('Hello, you are AWESOME! Let me help you install your database!')
print('You just need to answer some questions.')
print('')
print('################################################################')
print('')

Q_STARTING=input('Can we start? (Y/N)') or "Y"
print(Q_STARTING)
ask_yn(Q_STARTING)
print('')

Q_SOFT_DOWNLOADED=input("Did you already download the software? (Y/N)") or "Y"
ask_yn(Q_SOFT_DOWNLOADED)
print('')

PRODUCT_GROUP=input("Product group (oinstall) : ") or "oinstall"
print(PRODUCT_GROUP)

RDBMS_OWNER=input("RDBMS Owner (oracle) : ") or "oracle"
print(RDBMS_OWNER)

RDBMS_GROUP=input("RDBMS group (dba) : ") or "dba"
print(RDBMS_GROUP)

STG_DIR=input("Stage area: ") 
print(STG_DIR)

TFA_DIR=input("TFA Dir: (/u01/app/tfa) ") or "/u01/app/tfa"
print(TFA_DIR)

ORACLE_BASE=input("Oracle Base dir: (/u01/app/oracle) ") or "/u01/app/oracle"
print(ORACLE_BASE)

ORACLE_HOME=input("Oracle Home dir: (/u01/app/oracle/product/21.0.0/rdbms) ") or "/u01/app/oracle/product/21.0.0/rdbms"
print(ORACLE_HOME)

ORACLE_INVENTORY=input("Oracle Inventory: (/u01/app/oraInventory) ") or "/u01/app/oraInventory"
print(ORACLE_INVENTORY)

Q_SOFT_LOCATION=input("Software download location (path) :")
print(Q_SOFT_LOCATION)

Q_SOFT_NAME=input("Software binary name, should be (LINUX.X64_213000_db_home.zip) :") or "LINUX.X64_213000_db_home.zip"
print(Q_SOFT_NAME)

Q_CREATE_USERS=input("Would you like to create users and groups? (Y/N)") or "Y"
if Q_CREATE_USERS.lower() == 'y':
    print('legal')
    os.system('./create-users.sh')
else:
    print('Chato')

Q_CREATE_USERS=input("Would you like to directories? (Y/N)") or "Y"
if Q_CREATE_USERS.lower() == 'y':
    print('legal')
    os.system('./create-directories.sh')
else:
    print('Chato')

Q_INSTALL_PACKAGES=input("Would you like to install missing package? (Y/N)")
if Q_INSTALL_PACKAGES.lower() == 'y':
    print('legal')
    os.system('install-missing-packagessh')
    os.system('install-missing-packagessh')
else:
    print('Chato')

PARAMETERS={
        'install_package' : Q_INSTALL_PACKAGES,
        'create_users' : Q_CREATE_USERS,
        'operating_system': {
        'os_users': {
            'rdbms_owner': RDBMS_OWNER
        },
        'os_groups':{
            'product_group' : PRODUCT_GROUP,
            'rdbms_group' : RDBMS_GROUP,
            'rdbms_owner' : RDBMS_OWNER,
        },
        'directories': {
            'tfa_home': TFA_DIR,
            'oracle_base': ORACLE_BASE,
            'oracle_home': ORACLE_HOME,
            'oracle_nventory': ORACLE_INVENTORY}}}

with open('parameters.json','w') as jsonFile:
    json.dump(PARAMETERS, jsonFile, indent=4)
