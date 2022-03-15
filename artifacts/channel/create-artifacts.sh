
# Delete existing artifacts
rm genesis.block mychannel.tx
rm -rf ../../channel-artifacts/*

#Generate Crypto artifactes for organizations
# cryptogen generate --config=./crypto-config.yaml --output=./crypto-config/



# System channel
SYS_CHANNEL="sys-channel"

# channel name defaults to "mychannel"
CHANNEL_NAME="mychannel"

echo $CHANNEL_NAME

# Generate System Genesis block
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL  -outputBlock ./genesis.block


# Generate channel configuration block
configtxgen -profile BasicChannel -configPath . -outputCreateChannelTx ./mychannel.tx -channelID $CHANNEL_NAME

echo "#######    Generating anchor peer update for TransMSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./TransMSPanchors.tx -channelID $CHANNEL_NAME -asOrg TransMSP

echo "#######    Generating anchor peer update for ManufMSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./ManufMSPanchors.tx -channelID $CHANNEL_NAME -asOrg ManufMSP

echo "#######    Generating anchor peer update for InsurMSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./InsurMSPanchors.tx -channelID $CHANNEL_NAME -asOrg InsurMSP

echo "#######    Generating anchor peer update for OwnerMSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./OwnerMSPanchors.tx -channelID $CHANNEL_NAME -asOrg OwnerMSP

echo "#######    Generating anchor peer update for ScrapMSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./ScrapMSPanchors.tx -channelID $CHANNEL_NAME -asOrg ScrapMSP