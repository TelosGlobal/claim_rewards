# TELOS CLAIMREWARDS script
This document explains how to setup an automatic recurring claimreward action for bp's on TELOS.  This should work on other EOSIO chains with minimal changes.

## OVERVIEW
1.  First, we create a new permission "ACCOUNT/claimer" with a unique KEY

- This unique key will only be allowed to claim tokens to YOUR account.  This way, if they key gets compromised it will do little or argueably "no" harm.

2.  Next, we create a separate wallet "claim" and provide ONLY this unique KEY

3.  Create a shell script "claimrewards.sh" to:
- Unlock this wallet
- Execute the claimrewards action
- Lock the wallet

4.  Setup a LOCAL USER cron job to run every hour.  (On TELOS, unclaimed rewards don't expire, so we don't need to worry about missing a claim)


## INSTALLATION
1.  Create new EOS KEY Pair (there are many ways to do this).

- NOTE: **SAVE the KEY info!**

2.  Create permission:

`cleos set account permission ACCOUNT_NAME claimer '{"threshold":1,"keys":[{"key":"YOUR_NEW_CLAIMER_PUB_KEY","weight":1}]}' "active" -p ACCOUNT_NAME@active`

`cleos set action permission ACCOUNT_NAME eosio claimrewards claimer`

3.  Create Wallet

`cleos wallet create -n WALLET_NAME -f KEY_FILE_NAME`

- NOTE: **SAVE the wallet key!**
	
4.  Add NEW key pair to the wallet

`cleos wallet import -n WALLET_NAME`

- paste PRIVATE key when prompted

5.  LOCK THE WALLET (OPTIONAL STEP.  We do this so it's in correct state for the script)

`cleos wallet lock -n WALLET_NAME`

5a. COPY THE WALLET from `$HOME/telos-wallet` folder to `$HOME/eosio-wallet 
- NOTE:  I'm not sure why, but seems cleos looks for this wallet in the eosio-wallet folder ¯\\_(ツ)_/¯

`cp $HOME/telos-wallet/YOUR_WALLET_NAME.wallet $HOME/eosio-wallet/.`

6.  Create the file "claimrewards.sh".  See file in this repo.

7.  Make the file executable

`sudo chmod 755 claimrewards.sh`

8.  Setup LOCAL_USER crontab job

- NOTE: Need to have local user added to /etc/cron.d/cron.allow
- - If file doesn't exist, create it and all 2 lines:
- - - root
- - - LOCAL_USERNAME **<-replace with your specific username**

`crontab -e`

- ADD THE FOLLOWING LINE ( will run every top of the hour ):

`5 * * * * /FULL_PATH/claimrewards.sh  >>/FULL_PATH/claims.log 2>&1`

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTU3ODYwNDMzOCwxMzQ3NDc0NTY5LDE1Nj
EzOTg3MzhdfQ==
-->
