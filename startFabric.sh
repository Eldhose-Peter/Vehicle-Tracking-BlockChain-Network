cd artifacts/channel/create-certificate-with-ca
docker-compose up -d
./create-certificate-with-ca.sh

cd ..
./create-artifacts

cd ..
docker-compose up -d

cd ..
./createChannel.sh
./deployChaincode.sh