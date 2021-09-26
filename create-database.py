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
print('Hello, you are AWESOME! Now let build our database!')
print('You just need to answer some questions.')
print('')
print('################################################################')
print('')

Q_STARTING=input('Can we start? (Y/N) : ') or "Y"
print(Q_STARTING)
ask_yn(Q_STARTING)
print('')

Q_SOFT_DOWNLOADED=input("Did you already finish the database installation? (Y/N): ") or "Y"
ask_yn(Q_SOFT_DOWNLOADED)
print('')

SID_NAME=input("Instance name (cdbdb01) : ") or "cdbdb01"
print(SID_NAME)

DB_CONFIG_TYPE=input("Instance type (SI\RAC\RACONENODE) : ") or "SI"
print(DB_CONFIG_TYPE)

CDB_NAME=input("Database name (cdbdb01) : ") or "cdbdb01"
print(CDB_NAME)

DB_UNQ_NAME=input("Database unique name (cdbdb01) : ") or "cdbdb01"
print(DB_UNQ_NAME)

PDB_NAME=input("PDB Name (pdb01) : ") or "pdb01"
print(PDB_NAME)

PDB_ADMIN_PASS=input("PDB admin password (oracle) : ") or "oracle"
print(PDB_ADMIN_PASS)

TEMPLATE_NAME=input("Template (/u01/app/oracle/product/21.0.0/rdbms/assistants/dbca/templates/New_Database.dbt) : ") or "/u01/app/oracle/product/21.0.0/rdbms/assistants/dbca/templates/New_Database.dbt"
print(TEMPLATE_NAME)

SYS_PASS=input("Sys Pass (oracle) : ") or "oracle"
print(SYS_PASS)

DB_FILE_PATH=input(f"Datafile Path (/u01/oradata/{SID_NAME}/data_file) : ") or f"/u01/oradata/{SID_NAME}"
print(DB_FILE_PATH)

FRA_FILE_PATH=input(f"Datafile Path (/u01/oradata/flash_recovery_area/{SID_NAME}) : ") or f"/u01/oradata/flash_recovery_area/{SID_NAME}"
print(DB_FILE_PATH)

CHARSET=input("Charset (AL32UTF8) : ") or "AL32UTF8"
print(CHARSET)

NCHARSET=input("National Charset (AL16UTF16) : ") or "AL16UTF16"
print(NCHARSET)

PARAMETERS={'oracle_rdbms': {
                'sid': SID_NAME,
                'databaseConfigType': DB_CONFIG_TYPE,
                'gdbName': CDB_NAME,
#                'db_unq_name': DB_UNQ_NAME,
                'pdbName': PDB_NAME,
                'pdbAdminPassword': PDB_ADMIN_PASS,
                'templateName': TEMPLATE_NAME,
                'sysPassword': SYS_PASS,
                'systemPassword': SYS_PASS,
                'datafileDestination': DB_FILE_PATH,
                'recoveryAreaDestination': FRA_FILE_PATH,
                'characterSet': CHARSET,
                'nationalCharacterSet': NCHARSET
            }
        }

with open('database_parameters.json','w') as jsonFile:
    json.dump(PARAMETERS, jsonFile, indent=4)

Q_CREATE_USERS=input("Would you like to create the DBCA response file? (Y/N) : ") or "Y"
if Q_CREATE_USERS.lower() == 'y':
    print('Creating DBCA response file')
    os.system('./create-dbca-response-file.sh')
else:
    print('Chato')

Q_CREATE_USERS=input("Would you like to review the DBCA response file ? (Y/N) : ") or "Y"
if Q_CREATE_USERS.lower() == 'y':
    print('creating users and groups')
    os.system('cat dbca-create-db.rsp')
else:
    print('Chato')

Q_CREATE_USERS=input("Would you like to directories? (Y/N) : ") or "Y"
if Q_CREATE_USERS.lower() == 'y':
    print('creatig directories')
#    os.system('./create-directories.sh')
else:
    print('Chato')

Q_INSTALL_PACKAGES=input("Would you like to create the database ? (Y/N) : ") or "Y"
if Q_INSTALL_PACKAGES.lower() == 'y':
    print('Lets rock the world! ')
    os.system('dbca -silent -createDatabase -responseFile dbca-create-db.rsp')
else:
    print('Chato')

print('Fim')
