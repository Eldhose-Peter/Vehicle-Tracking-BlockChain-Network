# FabricNetwork-2.x

Network Topology



Five Orgs(Peer Orgs)

    - Transport authority (Trans)
    - Manufacturer (Manuf)
    - Insurance company (Insur)
    - Owner (Owner)
    - Scraping Company (Scrap)


    - Each Org have one peer(Each Endorsing Peer)
    - Each Org have separate Certificate Authority
    - Each Peer has Current State database as couch db


One Orderer Org

    - Three Orderers
    - One Certificate Authority



Steps:

1) Clone the repo
2) Run Certificates Authority Services for all Orgs
    -  cd artifacts/channel/create-certificate-with-ca
    -  docker-compose up -d
3) Create Cryptomaterials for all organizations
    -  cd artifacts/channel/create-certificate-with-ca
    -  ./create-certificate-with-ca.sh
4) Create Channel Artifacts using Org MSP
    -   cd artifacts/channel
    -   ./create-artifacts
5) Create couchDB instances for each Org
    -   cd artifacts
    -   docker-compose up -d
6) Create Channel and join peers
    - cd ..
    - ./createChannel.sh
    - ./deployChaincode
7) Deploy Chaincode
   1) Install All dependency
   2) Package Chaincode
   3) Install Chaincode on all Endorsing Peer
   4) Approve Chaincode as per Lifecycle Endorsment Policy
   5) Commit Chaincode Defination
8) Create Connection Profiles
    - cd api2.0/config
    - ./generate-ccp.sh
9) Start API Server
    - cd api2.0/
    - npm install
    - node app.js
10) Register User using API
11) Invoke Chaincode Transaction
12) Query Chaincode Transaction
