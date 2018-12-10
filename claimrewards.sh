#/bin/bash
date
#Unlock wallet
/FULL_PATH/teclos wallet unlock -n WALLET_NAME --password YOUR_WALLET_PASSWORD
#Claim
/FULL_PATH/teclos push action eosio claimrewards '{"owner":"ACCOUNT_NAME"}' -p ACCOUNT_NAME@claimer
/FULL_PATH/teclos wallet lock -n WALLET_NAME
