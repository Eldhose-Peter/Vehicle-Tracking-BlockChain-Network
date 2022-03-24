cd artifacts
docker-compose down -v

cd artifacts/channel/create-certificate-with-ca
docker-compose down -v
docker-compose up -d
./create-certificate-with-ca.sh

cd ..
./create-artifacts.sh

cd ..
docker-compose up -d

cd ..
./createChannel.sh
./deployChaincode.sh