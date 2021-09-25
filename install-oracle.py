#!/usr/bin/python3

# libs

import os       #Subprocess module
import shlex    #Pass SO parameters
import json     #Working with json

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

Q_STARTING=input('Can we start? (Y/N)')
print(Q_STARTING)
ask_yn(Q_STARTING)
print('')

PRODUCT_GROUP=input("Product group (oinstall) : ")
print(PRODUCT_GROUP)

RDBMS_OWNER=input("RDBMS Owner (oracle) : ")
print(RDBMS_OWNER)

RDBMS_GROUP=input("RDBMS group (dba) : ")
print(RDBMS_OWNER)

STG_DIR=input("Stage area: ")
print(STG_DIR)

TFA_DIR=input("TFA Dir: ")
print(TFA_DIR)

ORACLE_BASE=input("Oracle Base dir: (/u01/app/oracle) ")
print(ORACLE_BASE)

ORACLE_HOME=input("Oracle Home dir: (/u01/app/oracle/product/21.0.0/rdbms) ")
print(ORACLE_HOME)

ORACLE_INVENTORY=input("Oracle Inventory: (/u01/app/oraInventory) ")
print(ORACLE_INVENTORY)

Q_INSTALL_PACKAGES=input("Would you like to install missing package? (Y/N)")
ask_yn(Q_INSTALL_PACKAGES)

Q_CREATE_USERS=input("Would you like to create users and groups? (Y/N)")
ask_yn(Q_CREATE_USERS)

PARAMETERS={'operating_system': {
        'product_group' : PRODUCT_GROUP,
        'rdbms_group' : RDBMS_GROUP,
        'rdbms_owner' : RDBMS_OWNER,
        'tfa_home': TFA_DIR,
        'oracle_base': ORACLE_BASE,
        'oracle_home': ORACLE_HOME,
        'oracle_nventory': ORACLE_INVENTORY}}

with open('parameters.json','w') as jsonFile:
    json.dump(PARAMETERS, jsonFile, indent=4)
