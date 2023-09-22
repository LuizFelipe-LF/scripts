#!/bin/bash
folderPath="/c/Users/LuizFelipe/Documents/Projects/ORGS"

projectName=$1

if [ -z "$projectName" ]
then
      echo "Por favor, forneça o nome do projeto"
      exit 1
fi

dirName=${projectName// /_}

cd "$folderPath"

sfdx project:generate --projectname "$dirName" --manifest

mv "$dirName" "$projectName"

cd "$folderPath/$projectName/scripts"
mkdir python

cd python
echo "class credential:
    username = 'your Username'
    password = 'your Password'
    security_token = 'your Security Token'
    domain = 'login' # login = Production / test = SandBox" > config.py

echo "from simple_salesforce import Salesforce
from config import credential
from datetime import date, timedelta
import time

sf = Salesforce(username=credential.username, password=credential.password, security_token=credential.security_token, domain=credential.domain)

start_time = time.time()

print(\"--- %s seconds ---\" % (f\"{time.time() - start_time:.2f}\"))" > main.py
