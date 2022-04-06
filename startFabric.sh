cd artifacts
docker-compose down -v

cd channel/create-certificate-with-ca
docker-compose down -v
docker-compose up -d
./create-certificate-with-ca.sh

cd ..
./create-artifacts.sh

cd ..
docker-compose up -d

sleep 5
cd ..
./createChannel.sh
./deployChaincode.sh

sleep 5
kill -9 $(lsof -t -i:4000)


cd api-2.0/config
./generate-ccp.sh

cd ..
node app.js



