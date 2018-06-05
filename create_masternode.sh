#!/bin/bash

BOLD="\033[1m"
RED='\033[0;31m'
YELLOW="\033[38;5;11m"
GREEN='\033[0;32m'
NC='\033[0m' # No Color

print_msg() {
	echo -e "${BOLD}${GREEN}$1${NC}"
}

print_msg "Beginning Escrow Coin (ESCO) Masternode creation\n"

read -ep "What name would you like to give to this masternode (default mn1)? " mn_name
read -ep "Masternode RPC port (default 7001): " rpc_port
read -ep "Masternode port (default 8001): " port
read -ep "Masternode RPC user (default escorpc): " rpc_user
read -ep "Masternode RPC password (default randomly generated): " rpc_password
read -ep "Masternode generated private key: (no default) " priv_key
read -ep "VPS public IP address: (default from 'hostname --ip-address') " ip

MN_NAME=${mn_name:-mn1}

print_msg "\nCreating masternode with name $MN_NAME\n"

DIR=$HOME/esco/$MN_NAME
FILENAME=Escrow.conf
FILE=$DIR/$FILENAME

IP=${ip:-`hostname --ip-address`}
PORT=${port:-8001}
RPC_PORT=${rpc_port:-7001}

MN_PRIV_KEY=${priv_key}

if [ ! -e "$FILE" ]; then
    mkdir -p $DIR
    print_msg "Creating configuration file at $FILE\n" 

    cat <<EOF > $FILE
masternode=1
server=1
listen=1
printtoconsole=1
rpcallowip=172.17.0.0/16
port=8018
rpcport=8017
externalip=$IP 
masternodeaddr=$IP:$PORT 

rpcuser=${rpc_user:-escorpc}
rpcpassword=${rpc_pass:-`dd if=/dev/urandom bs=33 count=1 2>/dev/null | base64`}
masternodeprivkey=$MN_PRIV_KEY                                           

EOF

fi

print_msg "Launching Docker container\n"
docker run -d --name $MN_NAME -v $DIR:/root/.Escrow -p $PORT:8018 -p $RPC_PORT:8017 cryppwn/esco-mn

exit


