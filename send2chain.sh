#!/bin/bash

#  Usage:  ./send2chain.sh
#  Finds out how much liquid coin is available, rounds to whole number
#  If liquid coins are available, continue
#  Opens wallet $SEND2_WALLET using key $SEND2_WALLETKEY  (Defined by env variables)
#  Sends coin to exchange $SEND2_TOACCT (using $SEND2_MEMO) from $SEND2_FRACCT 
#  Locks wallet


#FOR TESTING, USE THIS VARIABLE AND UNCOMMENT THE SENDAMT=0
#TRIGGER=50
TRIGGER=5500

AMT=`/ext/telos/cleos get account $SEND2_FRACCT -j | jq '.core_liquid_balance'`
AMTT=${AMT%.*}
COIN=${AMTT:1}

if [ $COIN -gt $TRIGGER ] 
then
    SENDAMT=`expr $COIN - 500`
    echo "Net send is "$SENDAMT

    # FOR TESTING ONLY
    # SENDAMT=10

    /ext/telos/cleos wallet unlock -n $SEND2_WALLET --password $SEND2_WALLETKEY
    echo "Balance is $AMT.  Coin is $COIN."
    /ext/telos/cleos push action eosio.token transfer "{\"from\":\""$SEND2_FRACCT"\" \"to\":\""$SEND2_TOACCT"\" \"quantity\":\""$SENDAMT".0000 TLOS\" \"memo\":\""$SEND2_MEMO"\"}" -p "$SEND2_FRACCT@tgtrsfr"
    /ext/telos/cleos wallet lock -n $SEND2_WALLET
else
    echo "Liquid balance is less than $TRIGGER.  Balance is $AMT.  Bye."
fi

