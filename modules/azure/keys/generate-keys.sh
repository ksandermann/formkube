//!/bin/bash
set -euo pipefail
IFS=$'\n\t'

//credits to:
//https://gist.github.com/irvingpop/968464132ded25a206ced835d50afa6b

generate_keypair () {
    //export key paths
    export KEYS_DIR=$1
    export KEYS_NAME=$2
    export KEY_PATH_PRIV="$KEYS_DIR/$KEYS_NAME"
    export KEY_PATH_PUB="$KEY_PATH_PRIV.pub"

    //debug
//    echo $KEYS_DIR
//    echo $KEYS_NAME
//    echo $KEY_PATH_PRIV
//    echo $KEY_PATH_PUB

    //always create dir
    sudo mkdir -p $KEYS_DIR

    //check if file exists, if not, create it with keygen
    if [ -f "$KEY_PATH_PUB" ]; then
        echo "$KEY_PATH_PUB exists. Using existing public key."
    else
        //KNOWNISSUE ed25519 not support by azure
        //sudo ssh-keygen -o -a 100 -t ed25519 -f $KEY_PATH_PRIV -q -N ''
        sudo ssh-keygen -t rsa -b 4096 -f $KEY_PATH_PRIV -q -N ''
    fi
    sudo chmod 644 $KEY_PATH_PRIV
    sudo chmod 644 $KEY_PATH_PUB


    //always b64 encode
    public_key_contents_b64=$(sudo cat ${KEY_PATH_PUB} | base64)
    private_key_contents_b64=$(sudo cat ${KEY_PATH_PRIV} | base64)

    //debug
//    echo "DEBUG: public_key_contents ${public_key_contents_b64}" 1>&2
//    echo "DEBUG: private_key_contents ${private_key_contents_b64}" 1>&2

    //create json output using jq
    jq -n \
    --arg public_key_contents "$public_key_contents_b64" \
    --arg private_key_contents "$private_key_contents_b64" \
    '{"public_key_b64encoded":$public_key_contents,"private_key_b64encoded":$private_key_contents}'
}

generate_keypair $1 $2