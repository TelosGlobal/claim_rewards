#/bin/bash
date
#Unlock wallet
/ext/telos/cleos wallet unlock -n claim --password $WALLET_PWD #Uses local ENV variable
#Claim
/ext/telos/cleos push action eosio claimrewards '{"owner":"telosglobal1"}' -p telosglobal1@claimer
/ext/telos/cleos wallet lock -n claim
