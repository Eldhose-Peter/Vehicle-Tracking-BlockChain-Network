# Quick Start

## Prerequisites
- Nodejs 10 and 12 (10.19 and 12.16 tested)
- PostgreSQL 9.5 or greater
- jq
- Linux-based operating system, such as Ubuntu or MacOS

## 1. Start Hyperledger fabric network

## 2. Clone GIT Repository

Clone this repository to get the latest using the following command.

```shell
$ git clone https://github.com/hyperledger/blockchain-explorer.git
$ cd blockchain-explorer
```

## 3. Database Setup

```
$ cd blockchain-explorer/app
```

* Modify `app/explorerconfig.json` to update PostgreSQL database settings.

    ```json
    "postgreSQL": {
        "host": "127.0.0.1",
        "port": "5432",
        "database": "fabricexplorer",
        "username": "hppoc",
        "passwd": "password"
    }
    ```
**Important** repeat after every git pull (in some cases, you may need to apply permission to db/ directory, from blockchain-explorer/app/persistence/fabric/postgreSQL run: `chmod -R 775 db/`



## 4. Update configuration

* Modify `app/platform/fabric/config.json` to define your fabric network connection profile:

    ```json
    {
        "network-configs": {
            "test-network": {
                "name": "Test Network",
                "profile": "./connection-profile/test-network.json",
                "enableAuthentication": false
            }
        },
        "license": "Apache-2.0"
    }
    ```

  * `test-network` is the name of your connection profile and can be changed to any name
  * `name` is a name you want to give to your fabric network. You can change the only value of the key `name`
  * `profile` is the location of your connection profile. You can change the only value of the key `profile`

* Modify connection profile in the JSON file `app/platform/fabric/connection-profile/test-network.json`:
  * Change `fabric-path` to your fabric network disk path in the test-network.json file:
  * Provide the full disk path to the adminPrivateKey config option. It usually ends with `_sk`, for example:
    `/fabric-path/fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/keystore/priv_sk`
  * `adminUser` and `adminPassword` is the credential for the user of Explorer to log in to the dashboard
  * `enableAuthentication` is a flag to enable authentication using a login page. Setting to false will skip authentication.

## 5. Run `create` database script:

* **Ubuntu**

    ```
    $ cd blockchain-explorer/app/persistence/fabric/postgreSQL/db
    $ sudo -u postgres ./createdb.sh
    ```

* **MacOS**

    ```
    $ cd blockchain-explorer/app/persistence/fabric/postgreSQL/db
    $ ./createdb.sh
    ```

Connect to the PostgreSQL database and run DB status commands:

```shell
$ sudo -u postgres psql -c '\l'
                                List of databases
      Name      |  Owner   | Encoding | Collate |  Ctype  |   Access privileges
----------------+----------+----------+---------+---------+-----------------------
 fabricexplorer | hppoc    | UTF8     | C.UTF-8 | C.UTF-8 |
 postgres       | postgres | UTF8     | C.UTF-8 | C.UTF-8 |
 template0      | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                |          |          |         |         | postgres=CTc/postgres
 template1      | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                |          |          |         |         | postgres=CTc/postgres
(4 rows)

$ sudo -u postgres psql fabricexplorer -c '\d'
                   List of relations
 Schema |           Name            |   Type   | Owner
--------+---------------------------+----------+-------
 public | blocks                    | table    | hppoc
 public | blocks_id_seq             | sequence | hppoc
 public | chaincodes                | table    | hppoc
 public | chaincodes_id_seq         | sequence | hppoc
 public | channel                   | table    | hppoc
 public | channel_id_seq            | sequence | hppoc
 public | orderer                   | table    | hppoc
 public | orderer_id_seq            | sequence | hppoc
 public | peer                      | table    | hppoc
 public | peer_id_seq               | sequence | hppoc
 public | peer_ref_chaincode        | table    | hppoc
 public | peer_ref_chaincode_id_seq | sequence | hppoc
 public | peer_ref_channel          | table    | hppoc
 public | peer_ref_channel_id_seq   | sequence | hppoc
 public | transactions              | table    | hppoc
 public | transactions_id_seq       | sequence | hppoc
 public | write_lock                | table    | hppoc
 public | write_lock_write_lock_seq | sequence | hppoc
(18 rows)

```

## 6. Build Hyperledger Explorer

**Important:** repeat the below steps after every git pull

* `./main.sh install`
  * To install, run tests, and build project
- `./main.sh clean`
  * To clean the /node_modules, client/node_modules client/build, client/coverage, app/test/node_modules
   directories

Or

```
$ cd blockchain-explorer
$ npm install
$ cd client/
$ npm install
$ npm run build
```


## 7. Run Hyperledger Explorer

### Run Locally in the Same Location

* Modify `app/explorerconfig.json` to update sync settings.

    ```json
    "sync": {
      "type": "local"
    }
    ```

* `npm start`
  * It will have the backend and GUI service up

* `npm run app-stop`
  * It will stop the node server

Or

```
$ ./start.sh
```
