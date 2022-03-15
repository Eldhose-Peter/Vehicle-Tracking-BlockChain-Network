export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export PEER0_TRANS_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/tls/ca.crt
export PEER0_MANUF_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/tls/ca.crt
export PEER0_INSUR_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/tls/ca.crt
export PEER0_OWNER_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/tls/ca.crt
export PEER0_SCRAP_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/artifacts/channel/config/

export CHANNEL_NAME=mychannel

setGlobalsForPeer0Trans(){
    export CORE_PEER_LOCALMSPID="TransMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_TRANS_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/trans.example.com/users/Admin@trans.example.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setGlobalsForPeer0Manuf(){
    export CORE_PEER_LOCALMSPID="ManufMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_MANUF_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/manuf.example.com/users/Admin@manuf.example.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
    
}

setGlobalsForPeer0Insur(){
    export CORE_PEER_LOCALMSPID="InsurMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_INSUR_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/insur.example.com/users/Admin@insur.example.com/msp
    export CORE_PEER_ADDRESS=localhost:11051
    
}

setGlobalsForPeer0Owner(){
    export CORE_PEER_LOCALMSPID="OwnerMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_OWNER_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/owner.example.com/users/Admin@owner.example.com/msp
    export CORE_PEER_ADDRESS=localhost:13051
    
}

setGlobalsForPeer0Scrap(){
    export CORE_PEER_LOCALMSPID="ScrapMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_SCRAP_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/scrap.example.com/users/Admin@scrap.example.com/msp
    export CORE_PEER_ADDRESS=localhost:15051
    
}

createChannel(){
    rm -rf ./channel-artifacts/*
    setGlobalsForPeer0Trans
    
    peer channel create -o localhost:7050 -c $CHANNEL_NAME \
    --ordererTLSHostnameOverride orderer.example.com \
    -f ./artifacts/channel/${CHANNEL_NAME}.tx --outputBlock ./channel-artifacts/${CHANNEL_NAME}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
}

removeOldCrypto(){
    rm -rf ./api-2.0/org1-wallet/*
    rm -rf ./api-2.0/org2-wallet/*
}


joinChannel(){
    setGlobalsForPeer0Trans
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
    
    setGlobalsForPeer0Manuf
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer0Insur
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block

    setGlobalsForPeer0Owner
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block

    setGlobalsForPeer0Scrap
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
}

updateAnchorPeers(){
    setGlobalsForPeer0Trans
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_NAME -f ./artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    
    setGlobalsForPeer0Manuf
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_NAME -f ./artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

    setGlobalsForPeer0Insur
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_NAME -f ./artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    
    setGlobalsForPeer0Owner
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_NAME -f ./artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

    setGlobalsForPeer0Scrap
    peer channel update -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_NAME -f ./artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
}

removeOldCrypto

createChannel
joinChannel
updateAnchorPeers