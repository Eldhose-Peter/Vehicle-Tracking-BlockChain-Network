#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $5)
    local CP=$(one_line_pem $6)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${org}/$2/" \
        -e "s/\${P0PORT}/$3/" \
        -e "s/\${CAPORT}/$4/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        ./ccp-template.json
}

ORG=Trans
org=trans
P0PORT=7051
CAPORT=7054
PEERPEM=../../artifacts/channel/crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/tls/tlscacerts/tls-localhost-7054-ca-trans-example-com.pem
CAPEM=../../artifacts/channel/crypto-config/peerOrganizations/trans.example.com/msp/tlscacerts/ca.crt

echo "$(json_ccp $ORG $org $P0PORT $CAPORT $PEERPEM $CAPEM )" > connection-trans.json

ORG=Manuf
org=manuf
P0PORT=9051
CAPORT=8054
PEERPEM=../../artifacts/channel/crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/tls/tlscacerts/tls-localhost-8054-ca-manuf-example-com.pem
CAPEM=../../artifacts/channel/crypto-config/peerOrganizations/manuf.example.com/msp/tlscacerts/ca.crt

echo "$(json_ccp $ORG $org $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-manuf.json

ORG=Insur
org=insur
P0PORT=11051
CAPORT=10054
PEERPEM=../../artifacts/channel/crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/tls/tlscacerts/tls-localhost-10054-ca-insur-example-com.pem
CAPEM=../../artifacts/channel/crypto-config/peerOrganizations/insur.example.com/msp/tlscacerts/ca.crt


echo "$(json_ccp $ORG $org $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-insur.json


ORG=Owner
org=owner
P0PORT=13051
CAPORT=11054
PEERPEM=../../artifacts/channel/crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/tls/tlscacerts/tls-localhost-11054-ca-owner-example-com.pem
CAPEM=../../artifacts/channel/crypto-config/peerOrganizations/owner.example.com/msp/tlscacerts/ca.crt


echo "$(json_ccp $ORG $org $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-owner.json


ORG=Scrap
org=scrap
P0PORT=15051
CAPORT=12054
PEERPEM=../../artifacts/channel/crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/tls/tlscacerts/tls-localhost-12054-ca-scrap-example-com.pem
CAPEM=../../artifacts/channel/crypto-config/peerOrganizations/scrap.example.com/msp/tlscacerts/ca.crt


echo "$(json_ccp $ORG $org $P0PORT $CAPORT $PEERPEM $CAPEM)" > connection-scrap.json
