createcertificatesForTrans() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/trans.example.com/
  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/trans.example.com/

   
  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca.trans.example.com --tls.certfiles ${PWD}/fabric-ca/trans/tls-cert.pem
   

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-trans-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-trans-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-trans-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-ca-trans-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/trans.example.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo
  fabric-ca-client register --caname ca.trans.example.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/trans/tls-cert.pem

  echo
  echo "Register user"
  echo
  fabric-ca-client register --caname ca.trans.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/trans/tls-cert.pem

  echo
  echo "Register the org admin"
  echo
  fabric-ca-client register --caname ca.trans.example.com --id.name transadmin --id.secret transadminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/trans/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/trans.example.com/peers

  # -----------------------------------------------------------------------------------
  #  Peer 0
  mkdir -p ../crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com

  echo
  echo "## Generate the peer0 msp"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.trans.example.com -M ${PWD}/../crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/msp --csr.hosts peer0.trans.example.com --tls.certfiles ${PWD}/fabric-ca/trans/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/trans.example.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca.trans.example.com -M ${PWD}/../crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/tls --enrollment.profile tls --csr.hosts peer0.trans.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/trans/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/trans.example.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/trans.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/trans.example.com/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/trans.example.com/tlsca/tlsca.trans.example.com-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/trans.example.com/ca
  cp ${PWD}/../crypto-config/peerOrganizations/trans.example.com/peers/peer0.trans.example.com/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/trans.example.com/ca/ca.trans.example.com-cert.pem

  # --------------------------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/trans.example.com/users
  mkdir -p ../crypto-config/peerOrganizations/trans.example.com/users/User1@trans.example.com

  echo
  echo "## Generate the user msp"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca.trans.example.com -M ${PWD}/../crypto-config/peerOrganizations/trans.example.com/users/User1@trans.example.com/msp --tls.certfiles ${PWD}/fabric-ca/trans/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/trans.example.com/users/Admin@trans.example.com

  echo
  echo "## Generate the org admin msp"
  echo
  fabric-ca-client enroll -u https://transadmin:transadminpw@localhost:7054 --caname ca.trans.example.com -M ${PWD}/../crypto-config/peerOrganizations/trans.example.com/users/Admin@trans.example.com/msp --tls.certfiles ${PWD}/fabric-ca/trans/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/trans.example.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/trans.example.com/users/Admin@trans.example.com/msp/config.yaml

}

# createcertificatesFortrans

createCertificatesForManuf() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p /../crypto-config/peerOrganizations/manuf.example.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/manuf.example.com/

   
  fabric-ca-client enroll -u https://admin:adminpw@localhost:8054 --caname ca.manuf.example.com --tls.certfiles ${PWD}/fabric-ca/manuf/tls-cert.pem
   

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-manuf-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-manuf-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-manuf-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-8054-ca-manuf-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/manuf.example.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo
   
  fabric-ca-client register --caname ca.manuf.example.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/manuf/tls-cert.pem
   

  echo
  echo "Register user"
  echo
   
  fabric-ca-client register --caname ca.manuf.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/manuf/tls-cert.pem
   

  echo
  echo "Register the org admin"
  echo
   
  fabric-ca-client register --caname ca.manuf.example.com --id.name manufadmin --id.secret manufadminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/manuf/tls-cert.pem
   

  mkdir -p ../crypto-config/peerOrganizations/manuf.example.com/peers
  mkdir -p ../crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo
   
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.manuf.example.com -M ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/msp --csr.hosts peer0.manuf.example.com --tls.certfiles ${PWD}/fabric-ca/manuf/tls-cert.pem
   

  cp ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:8054 --caname ca.manuf.example.com -M ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/tls --enrollment.profile tls --csr.hosts peer0.manuf.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/manuf/tls-cert.pem
   

  cp ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/tlsca/tlsca.manuf.example.com-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/ca
  cp ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/peers/peer0.manuf.example.com/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/ca/ca.manuf.example.com-cert.pem

  # --------------------------------------------------------------------------------
 
  mkdir -p ../crypto-config/peerOrganizations/manuf.example.com/users
  mkdir -p ../crypto-config/peerOrganizations/manuf.example.com/users/User1@manuf.example.com

  echo
  echo "## Generate the user msp"
  echo
   
  fabric-ca-client enroll -u https://user1:user1pw@localhost:8054 --caname ca.manuf.example.com -M ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/users/User1@manuf.example.com/msp --tls.certfiles ${PWD}/fabric-ca/manuf/tls-cert.pem
   

  mkdir -p ../crypto-config/peerOrganizations/manuf.example.com/users/Admin@manuf.example.com

  echo
  echo "## Generate the org admin msp"
  echo
   
  fabric-ca-client enroll -u https://manufadmin:manufadminpw@localhost:8054 --caname ca.manuf.example.com -M ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/users/Admin@manuf.example.com/msp --tls.certfiles ${PWD}/fabric-ca/manuf/tls-cert.pem
   

  cp ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/manuf.example.com/users/Admin@manuf.example.com/msp/config.yaml

}

# createCertificateFormanuf

createCertificatesForInsur() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/insur.example.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/insur.example.com/

   
  fabric-ca-client enroll -u https://admin:adminpw@localhost:10054 --caname ca.insur.example.com --tls.certfiles ${PWD}/fabric-ca/insur/tls-cert.pem
   

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-insur-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-insur-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-insur-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-10054-ca-insur-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/insur.example.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo
   
  fabric-ca-client register --caname ca.insur.example.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/insur/tls-cert.pem
   

  echo
  echo "Register user"
  echo
   
  fabric-ca-client register --caname ca.insur.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/insur/tls-cert.pem
   

  echo
  echo "Register the org admin"
  echo
   
  fabric-ca-client register --caname ca.insur.example.com --id.name insuradmin --id.secret insuradminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/insur/tls-cert.pem
   

  mkdir -p ../crypto-config/peerOrganizations/insur.example.com/peers
  mkdir -p ../crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo
   
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca.insur.example.com -M ${PWD}/../crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/msp --csr.hosts peer0.insur.example.com --tls.certfiles ${PWD}/fabric-ca/insur/tls-cert.pem
   

  cp ${PWD}/../crypto-config/peerOrganizations/insur.example.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:10054 --caname ca.insur.example.com -M ${PWD}/../crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/tls --enrollment.profile tls --csr.hosts peer0.insur.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/insur/tls-cert.pem
   

  cp ${PWD}/../crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/insur.example.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/insur.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/insur.example.com/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/insur.example.com/tlsca/tlsca.insur.example.com-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/insur.example.com/ca
  cp ${PWD}/../crypto-config/peerOrganizations/insur.example.com/peers/peer0.insur.example.com/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/insur.example.com/ca/ca.insur.example.com-cert.pem

  # --------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/insur.example.com/users
  mkdir -p ../crypto-config/peerOrganizations/insur.example.com/users/User1@insur.example.com

  echo
  echo "## Generate the user msp"
  echo
   
  fabric-ca-client enroll -u https://user1:user1pw@localhost:10054 --caname ca.insur.example.com -M ${PWD}/../crypto-config/peerOrganizations/insur.example.com/users/User1@insur.example.com/msp --tls.certfiles ${PWD}/fabric-ca/insur/tls-cert.pem
   

  mkdir -p ../crypto-config/peerOrganizations/insur.example.com/users/Admin@insur.example.com

  echo
  echo "## Generate the org admin msp"
  echo
   
  fabric-ca-client enroll -u https://insuradmin:insuradminpw@localhost:10054 --caname ca.insur.example.com -M ${PWD}/../crypto-config/peerOrganizations/insur.example.com/users/Admin@insur.example.com/msp --tls.certfiles ${PWD}/fabric-ca/insur/tls-cert.pem
   

  cp ${PWD}/../crypto-config/peerOrganizations/insur.example.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/insur.example.com/users/Admin@insur.example.com/msp/config.yaml

}

createCertificatesForOwner() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/owner.example.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/owner.example.com/

   
  fabric-ca-client enroll -u https://admin:adminpw@localhost:11054 --caname ca.owner.example.com --tls.certfiles ${PWD}/fabric-ca/owner/tls-cert.pem
   

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-owner-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-owner-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-owner-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-11054-ca-owner-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/owner.example.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo
   
  fabric-ca-client register --caname ca.owner.example.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/owner/tls-cert.pem
   

  echo
  echo "Register user"
  echo
   
  fabric-ca-client register --caname ca.owner.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/owner/tls-cert.pem
   

  echo
  echo "Register the org admin"
  echo
   
  fabric-ca-client register --caname ca.owner.example.com --id.name owneradmin --id.secret owneradminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/owner/tls-cert.pem
   

  mkdir -p ../crypto-config/peerOrganizations/owner.example.com/peers
  mkdir -p ../crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo
   
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca.owner.example.com -M ${PWD}/../crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/msp --csr.hosts peer0.owner.example.com --tls.certfiles ${PWD}/fabric-ca/owner/tls-cert.pem
   

  cp ${PWD}/../crypto-config/peerOrganizations/owner.example.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:11054 --caname ca.owner.example.com -M ${PWD}/../crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/tls --enrollment.profile tls --csr.hosts peer0.owner.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/owner/tls-cert.pem
   

  cp ${PWD}/../crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/owner.example.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/owner.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/owner.example.com/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/owner.example.com/tlsca/tlsca.owner.example.com-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/owner.example.com/ca
  cp ${PWD}/../crypto-config/peerOrganizations/owner.example.com/peers/peer0.owner.example.com/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/owner.example.com/ca/ca.owner.example.com-cert.pem

  # --------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/owner.example.com/users
  mkdir -p ../crypto-config/peerOrganizations/owner.example.com/users/User1@owner.example.com

  echo
  echo "## Generate the user msp"
  echo
   
  fabric-ca-client enroll -u https://user1:user1pw@localhost:11054 --caname ca.owner.example.com -M ${PWD}/../crypto-config/peerOrganizations/owner.example.com/users/User1@owner.example.com/msp --tls.certfiles ${PWD}/fabric-ca/owner/tls-cert.pem
   

  mkdir -p ../crypto-config/peerOrganizations/owner.example.com/users/Admin@owner.example.com

  echo
  echo "## Generate the org admin msp"
  echo
   
  fabric-ca-client enroll -u https://owneradmin:owneradminpw@localhost:11054 --caname ca.owner.example.com -M ${PWD}/../crypto-config/peerOrganizations/owner.example.com/users/Admin@owner.example.com/msp --tls.certfiles ${PWD}/fabric-ca/owner/tls-cert.pem
   

  cp ${PWD}/../crypto-config/peerOrganizations/owner.example.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/owner.example.com/users/Admin@owner.example.com/msp/config.yaml

}

createCertificatesForScrap() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/scrap.example.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/scrap.example.com/

   
  fabric-ca-client enroll -u https://admin:adminpw@localhost:12054 --caname ca.scrap.example.com --tls.certfiles ${PWD}/fabric-ca/scrap/tls-cert.pem
   

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-scrap-example-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-scrap-example-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-scrap-example-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-12054-ca-scrap-example-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/scrap.example.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo
   
  fabric-ca-client register --caname ca.scrap.example.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/scrap/tls-cert.pem
   

  echo
  echo "Register user"
  echo
   
  fabric-ca-client register --caname ca.scrap.example.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/scrap/tls-cert.pem
   

  echo
  echo "Register the org admin"
  echo
   
  fabric-ca-client register --caname ca.scrap.example.com --id.name scrapadmin --id.secret scrapadminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/scrap/tls-cert.pem
   

  mkdir -p ../crypto-config/peerOrganizations/scrap.example.com/peers
  mkdir -p ../crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo
   
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:12054 --caname ca.scrap.example.com -M ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/msp --csr.hosts peer0.scrap.example.com --tls.certfiles ${PWD}/fabric-ca/scrap/tls-cert.pem
   

  cp ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:12054 --caname ca.scrap.example.com -M ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/tls --enrollment.profile tls --csr.hosts peer0.scrap.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/scrap/tls-cert.pem
   

  cp ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/tlsca/tlsca.scrap.example.com-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/ca
  cp ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/peers/peer0.scrap.example.com/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/ca/ca.scrap.example.com-cert.pem

  # --------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/scrap.example.com/users
  mkdir -p ../crypto-config/peerOrganizations/scrap.example.com/users/User1@scrap.example.com

  echo
  echo "## Generate the user msp"
  echo
   
  fabric-ca-client enroll -u https://user1:user1pw@localhost:12054 --caname ca.scrap.example.com -M ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/users/User1@scrap.example.com/msp --tls.certfiles ${PWD}/fabric-ca/scrap/tls-cert.pem
   

  mkdir -p ../crypto-config/peerOrganizations/scrap.example.com/users/Admin@scrap.example.com

  echo
  echo "## Generate the org admin msp"
  echo
   
  fabric-ca-client enroll -u https://scrapadmin:scrapadminpw@localhost:12054 --caname ca.scrap.example.com -M ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/users/Admin@scrap.example.com/msp --tls.certfiles ${PWD}/fabric-ca/scrap/tls-cert.pem
   

  cp ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/scrap.example.com/users/Admin@scrap.example.com/msp/config.yaml

}

createCretificatesForOrderer() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/ordererOrganizations/example.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/ordererOrganizations/example.com

   
  fabric-ca-client enroll -u https://admin:adminpw@localhost:9054 --caname ca-orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-9054-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/ordererOrganizations/example.com/msp/config.yaml

  echo
  echo "Register orderer"
  echo
   
  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  echo
  echo "Register orderer2"
  echo
   
  fabric-ca-client register --caname ca-orderer --id.name orderer2 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  echo
  echo "Register orderer3"
  echo
   
  fabric-ca-client register --caname ca-orderer --id.name orderer3 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  echo
  echo "Register the orderer admin"
  echo
   
  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  mkdir -p ../crypto-config/ordererOrganizations/example.com/orderers
  # mkdir -p ../crypto-config/ordererOrganizations/example.com/orderers/example.com

  # ---------------------------------------------------------------------------
  #  Orderer

  mkdir -p ../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com

  echo
  echo "## Generate the orderer msp"
  echo
   
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/config.yaml

  echo
  echo "## Generate the orderer-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls --enrollment.profile tls --csr.hosts orderer.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  mkdir ${PWD}/../crypto-config/ordererOrganizations/example.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  # -----------------------------------------------------------------------
  #  Orderer 2

  mkdir -p ../crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com

  echo
  echo "## Generate the orderer msp"
  echo
   
  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp --csr.hosts orderer2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/config.yaml

  echo
  echo "## Generate the orderer-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls --enrollment.profile tls --csr.hosts orderer2.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  # mkdir ${PWD}/../crypto-config/ordererOrganizations/example.com/msp/tlscacerts
  # cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  # ---------------------------------------------------------------------------
  #  Orderer 3
  mkdir -p ../crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com

  echo
  echo "## Generate the orderer msp"
  echo
   
  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp --csr.hosts orderer3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/config.yaml

  echo
  echo "## Generate the orderer-tls certificates"
  echo
   
  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:9054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls --enrollment.profile tls --csr.hosts orderer3.example.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  # mkdir ${PWD}/../crypto-config/ordererOrganizations/example.com/msp/tlscacerts
  # cp ${PWD}/../crypto-config/ordererOrganizations/example.com/orderers/orderer3.example.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/example.com/msp/tlscacerts/tlsca.example.com-cert.pem

  # ---------------------------------------------------------------------------

  mkdir -p ../crypto-config/ordererOrganizations/example.com/users
  mkdir -p ../crypto-config/ordererOrganizations/example.com/users/Admin@example.com

  echo
  echo "## Generate the admin msp"
  echo
   
  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:9054 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem
   

  cp ${PWD}/../crypto-config/ordererOrganizations/example.com/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/example.com/users/Admin@example.com/msp/config.yaml

}

# createCretificateForOrderer

sudo rm -rf ../crypto-config/*
# sudo rm -rf fabric-ca/*
createcertificatesForTrans
createCertificatesForManuf
createCertificatesForInsur
createCertificatesForOwner
createCertificatesForScrap

createCretificatesForOrderer

