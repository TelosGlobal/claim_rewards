#/bin/bash
date
#Unlock wallet
/FULL_PATH/cleos wallet unlock -n WALLET_NAME --password YOUR_WALLET_PASSWORD
#Claim
/FULL_PATH/cleos push action eosio claimrewards '{"owner":"ACCOUNT_NAME"}' -p ACCOUNT_NAME@claimer
/FULL_PATH/cleos wallet lock -n WALLET_NAME
