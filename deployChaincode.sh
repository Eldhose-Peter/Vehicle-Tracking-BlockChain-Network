export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export PEER0_TRANS_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/tls/ca.crt
export PEER0_MANUF_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/tls/ca.crt
export PEER0_INSUR_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/tls/ca.crt
export PEER0_OWNER_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/tls/ca.crt
export PEER0_SCRAP_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/artifacts/channel/config/

export CHANNEL_NAME=mychannel

setGlobalsForOrderer() {
    export CORE_PEER_LOCALMSPID="OrdererMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp

}

setGlobalsForPeer0Trans() {
    
    export CORE_PEER_LOCALMSPID="TransMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_TRANS_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/trans.example.com/users/Admin@trans.example.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setGlobalsForTrans() {
    export CORE_PEER_LOCALMSPID="TransMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_TRANS_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/trans.example.com/users/User1@trans.example.com/msp
    export CORE_PEER_ADDRESS=localhost:7051
}

setGlobalsForPeer0Manuf() {
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
# is there presetup for javascript ???
presetup() {
    echo Vendoring Go dependencies ...
    pushd ./artifacts/src/github.com/fabcar/go
    GO111MODULE=on go mod vendor
    popd
    echo Finished vendoring Go dependencies
}

#presetup

CHANNEL_NAME="mychannel"
#CC_RUNTIME_LANGUAGE="golang"
CC_RUNTIME_LANGUAGE="node"
VERSION="1"
SEQUENCE="1"
CC_SRC_PATH="./artifacts/src/github.com/fabcar/javascript"
CC_NAME="fabcar"

packageChaincode() {
    rm -rf ${CC_NAME}.tar.gz
    setGlobalsForPeer0Trans
    peer lifecycle chaincode package ${CC_NAME}.tar.gz \
        --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} \
        --label ${CC_NAME}_${VERSION}
    echo "===================== Chaincode is packaged ===================== "
}
 #packageChaincode

installChaincode() {
    setGlobalsForPeer0Trans
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.trans ===================== "

    setGlobalsForPeer0Manuf
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.manuf ===================== "

    setGlobalsForPeer0Insur
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.insur ===================== "

    setGlobalsForPeer0Owner
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.owner ===================== "

    setGlobalsForPeer0Scrap
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.scrap ===================== "

}

 #installChaincode

queryInstalled() {
    setGlobalsForPeer0Trans
    peer lifecycle chaincode queryinstalled >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CC_NAME}_${VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo PackageID is ${PACKAGE_ID}
    echo "===================== Query installed successful on peer0.trans on channel ===================== "
}

#queryInstalled

# --collections-config ./artifacts/private-data/collections_config.json \
#         --signature-policy "OR('Org1MSP.member','Org2MSP.member')" \

approveForMyTrans() {
    setGlobalsForPeer0Trans
    # set -x
    peer lifecycle chaincode approveformyorg -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com --tls \
        --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${VERSION} \
        --init-required --package-id ${PACKAGE_ID} \
        --sequence ${SEQUENCE}
    # set +x

    echo "===================== chaincode approved from trans ===================== "

}
# queryInstalled
# approveForMyOrg1

# --signature-policy "OR ('Org1MSP.member')"
# --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_ORG1_CA --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_ORG2_CA
# --peerAddresses peer0.org1.example.com:7051 --tlsRootCertFiles $PEER0_ORG1_CA --peerAddresses peer0.org2.example.com:9051 --tlsRootCertFiles $PEER0_ORG2_CA
#--channel-config-policy Channel/Application/Admins
# --signature-policy "OR ('Org1MSP.peer','Org2MSP.peer')"

checkCommitReadyness() {
    setGlobalsForPeer0Trans
    peer lifecycle chaincode checkcommitreadiness \
        --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${VERSION} \
        --sequence ${VERSION} --output json --init-required
    echo "===================== checking commit readyness from trans ===================== "
}

# checkCommitReadyness

approveForMyManuf() {
    setGlobalsForPeer0Manuf

    peer lifecycle chaincode approveformyorg -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com --tls $CORE_PEER_TLS_ENABLED \
        --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} \
        --version ${VERSION} --init-required --package-id ${PACKAGE_ID} \
        --sequence ${SEQUENCE}

    echo "===================== chaincode approved from manuf ===================== "
}

# queryInstalled
# approveForMyOrg2

checkCommitReadyness() {

    setGlobalsForPeer0Manuf
    peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME \
        --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_MANUF_CA \
        --name ${CC_NAME} --version ${VERSION} --sequence ${VERSION} --output json --init-required
    echo "===================== checking commit readyness from manuf ===================== "
}

# checkCommitReadyness

approveForMyInsur() {
    setGlobalsForPeer0Insur

    peer lifecycle chaincode approveformyorg -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com --tls $CORE_PEER_TLS_ENABLED \
        --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} \
        --version ${VERSION} --init-required --package-id ${PACKAGE_ID} \
        --sequence ${SEQUENCE}

    echo "===================== chaincode approved from insur ===================== "
}

# queryInstalled
# approveForMyOrg3

checkCommitReadyness() {

    setGlobalsForPeer0Insur
    peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME \
        --peerAddresses localhost:11051 --tlsRootCertFiles $PEER0_INSUR_CA \
        --name ${CC_NAME} --version ${VERSION} --sequence ${VERSION} --output json --init-required
    echo "===================== checking commit readyness from insur ===================== "
}

approveForMyOwner() {
    setGlobalsForPeer0Owner

    peer lifecycle chaincode approveformyorg -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com --tls $CORE_PEER_TLS_ENABLED \
        --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} \
        --version ${VERSION} --init-required --package-id ${PACKAGE_ID} \
        --sequence ${SEQUENCE}

    echo "===================== chaincode approved from owner ===================== "
}

# queryInstalled
# approveForMyOrg3

checkCommitReadyness() {

    setGlobalsForPeer0Owner
    peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME \
        --peerAddresses localhost:13051 --tlsRootCertFiles $PEER0_OWNER_CA \
        --name ${CC_NAME} --version ${VERSION} --sequence ${VERSION} --output json --init-required
    echo "===================== checking commit readyness from owner ===================== "
}

approveForMyScrap() {
    setGlobalsForPeer0Scrap

    peer lifecycle chaincode approveformyorg -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com --tls $CORE_PEER_TLS_ENABLED \
        --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} \
        --version ${VERSION} --init-required --package-id ${PACKAGE_ID} \
        --sequence ${SEQUENCE}

    echo "===================== chaincode approved from scrap ===================== "
}

# queryInstalled
# approveForMyOrg3

checkCommitReadyness() {

    setGlobalsForPeer0Scrap
    peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME \
        --peerAddresses localhost:15051 --tlsRootCertFiles $PEER0_SCRAP_CA \
        --name ${CC_NAME} --version ${VERSION} --sequence ${VERSION} --output json --init-required
    echo "===================== checking commit readyness from scrap ===================== "
}

# checkCommitReadyness

commitChaincodeDefination() {
    setGlobalsForPeer0Trans
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA \
        --channelID $CHANNEL_NAME --name ${CC_NAME} \
        --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_TRANS_CA \
        --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_MANUF_CA \
        --peerAddresses localhost:11051 --tlsRootCertFiles $PEER0_INSUR_CA \
        --peerAddresses localhost:13051 --tlsRootCertFiles $PEER0_OWNER_CA \
        --peerAddresses localhost:15051 --tlsRootCertFiles $PEER0_SCRAP_CA \
        --version ${VERSION} --sequence ${SEQUENCE} --init-required

}

# commitChaincodeDefination

queryCommitted() {
    setGlobalsForPeer0Trans
    peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME --name ${CC_NAME}

}

# queryCommitted

chaincodeInvokeInit() {
    setGlobalsForPeer0Trans
    peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA \
        -C $CHANNEL_NAME -n ${CC_NAME} \
        --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_TRANS_CA \
        --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_MANUF_CA \
        --peerAddresses localhost:11051 --tlsRootCertFiles $PEER0_INSUR_CA \
        --peerAddresses localhost:13051 --tlsRootCertFiles $PEER0_OWNER_CA \
        --peerAddresses localhost:15051 --tlsRootCertFiles $PEER0_SCRAP_CA \
        --isInit -c '{"function":"initLedger","Args":[]}'


}

# chaincodeInvokeInit

chaincodeInvoke() {
    setGlobalsForPeer0Trans

    # Create Car
    peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com \
        --tls $CORE_PEER_TLS_ENABLED \
        --cafile $ORDERER_CA \
        -C $CHANNEL_NAME -n ${CC_NAME}  \
        --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_TRANS_CA \
        --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_MANUF_CA \
        --peerAddresses localhost:11051 --tlsRootCertFiles $PEER0_INSUR_CA \
        --peerAddresses localhost:13051 --tlsRootCertFiles $PEER0_OWNER_CA \
        --peerAddresses localhost:15051 --tlsRootCertFiles $PEER0_SCRAP_CA \
        -c '{"function": "createCar","Args":["{\"carNumber\":\"1\",\"make\":\"Audi\",\"addedAt\":1600138309939,\"model\":\"R8\", \"color\":\"red\",\"owner\":\"pavan\"}"]}'

}

# chaincodeInvoke

chaincodeInvokeDeleteAsset() {
    setGlobalsForPeer0Trans

    # Create Car
    peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com \
        --tls $CORE_PEER_TLS_ENABLED \
        --cafile $ORDERER_CA \
        -C $CHANNEL_NAME -n ${CC_NAME}  \
        --peerAddresses localhost:7051 --tlsRootCertFiles $PEER0_ORG1_CA \
        --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_ORG2_CA   \
        -c '{"function": "DeleteCarById","Args":["2"]}'

}

# chaincodeInvokeDeleteAsset

chaincodeQuery() {
    setGlobalsForPeer0Trans
    # setGlobalsForOrg1
    peer chaincode query -C $CHANNEL_NAME -n ${CC_NAME} -c '{"Args":["queryAllCars"]}'
}

# chaincodeQuery

# Run this function if you add any new dependency in chaincode
# presetup  -- not executing for js

packageChaincode
installChaincode
queryInstalled
approveForMyTrans
checkCommitReadyness
approveForMyManuf
checkCommitReadyness
approveForMyInsur
checkCommitReadyness
approveForMyOwner
checkCommitReadyness
approveForMyScrap
checkCommitReadyness
commitChaincodeDefination
queryCommitted
chaincodeInvokeInit
 sleep 5
#chaincodeInvoke
#sleep 3
chaincodeQuery
