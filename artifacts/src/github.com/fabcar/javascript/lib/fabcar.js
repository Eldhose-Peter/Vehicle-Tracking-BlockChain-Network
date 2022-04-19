/*
 * Copyright IBM Corp. All Rights Reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

'use strict';

const { Contract } = require('fabric-contract-api');

class FabCar extends Contract {

    async initLedger(ctx) {
        console.info('============= START : Initialize Ledger ===========');
        const cars = [
            {
                color: 'blue',
                make: 'Toyota',
                model: 'Prius',
                owner: 'Tomoko',
                mileage: 15,
                lastPrice: 1000000,
                ownerID: 1,
                ownerLevel: 1,
                insuranceID: 1,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
            },
            {
                color: 'red',
                make: 'Ford',
                model: 'Mustang',
                owner: 'Brad',
                mileage: 15,
                lastPrice: 1000000,
                ownerID: 1,
                ownerLevel: 1,
                insuranceID: 1,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
            },
            {
                color: 'green',
                make: 'Hyundai',
                model: 'Tucson',
                owner: 'Jin Soo',
                mileage: 15,
                lastPrice: 1000000,
                ownerID: 1,
                ownerLevel: 1,
                insuranceID: 1,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
            },
            {
                color: 'yellow',
                make: 'Volkswagen',
                model: 'Passat',
                owner: 'Max',
                mileage: 15,
                lastPrice: 1000000,
                ownerID: 1,
                ownerLevel: 1,
                insuranceID: 1,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
            },
            {
                color: 'black',
                make: 'Tesla',
                model: 'S',
                owner: 'Adriana',
                mileage: 15,
                lastPrice: 1000000,
                ownerID: 1,
                ownerLevel: 1,
                insuranceID: 1,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
            },
            {
                color: 'purple',
                make: 'Peugeot',
                model: '205',
                owner: 'Michel',
                mileage: 15,
                lastPrice: 1000000,
                ownerID: 1,
                ownerLevel: 1,
                insuranceID: 1,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
            },
            {
                color: 'white',
                make: 'Chery',
                model: 'S22L',
                owner: 'Aarav',
                mileage: 15,
                lastPrice: 1000000,
                ownerID: 1,
                ownerLevel: 1,
                insuranceID: 1,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
            },
            {
                color: 'violet',
                make: 'Fiat',
                model: 'Punto',
                owner: 'Pari',
                mileage: 15,
                lastPrice: 1000000,
                ownerID: 1,
                ownerLevel: 1,
                insuranceID: 1,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
            },
            {
                color: 'indigo',
                make: 'Tata',
                model: 'Nano',
                owner: 'Valeria',
                mileage: 15,
                lastPrice: 1000000,
                ownerID: 1,
                ownerLevel: 1,
                insuranceID: 1,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
            },
            {
                color: 'brown',
                make: 'Holden',
                model: 'Barina',
                owner: 'Shotaro',
                mileage: 15,
                lastPrice: 1000000,
                ownerID: 1,
                ownerLevel: 1,
                insuranceID: 1,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
            },
        ];

        for (let i = 0; i < cars.length; i++) {
            cars[i].docType = 'car';
            await ctx.stub.putState('CAR' + i, Buffer.from(JSON.stringify(cars[i])));
            console.info('Added <--> ', cars[i]);
        }
        console.info('============= END : Initialize Ledger ===========');
    }

    async queryCar(ctx, carNumber) {
        const carAsBytes = await ctx.stub.getState(carNumber); // get the car from chaincode state
        if (!carAsBytes || carAsBytes.length === 0) {
            throw new Error(`${carNumber} does not exist`);
        }
        console.log(carAsBytes.toString());
        return carAsBytes.toString();
    }

    async createCar(ctx, carNumber, make, model, color, owner,mileage,lastPrice,ownerId,ownerLevel,insuranceID,year,kmDriven,fuelType,transmissionType,seats,maxPower) {
        console.info('============= START : Create Car ===========');

        const car = {
            color,
            docType: 'car',
            make,
            model,
            owner,
            mileage,
            lastPrice,
            ownerId,
            ownerLevel,
            insuranceID,
            year,
            kmDriven,
            fuelType,
            transmissionType,
            seats,
            maxPower,
        };

        await ctx.stub.putState(carNumber, Buffer.from(JSON.stringify(car)));
        console.info('============= END : Create Car ===========');
    }

    async queryAllCars(ctx) {
        const startKey = '';
        const endKey = '';
        const allResults = [];
        for await (const {key, value} of ctx.stub.getStateByRange(startKey, endKey)) {
            const strValue = Buffer.from(value).toString('utf8');
            let record;
            try {
                record = JSON.parse(strValue);
            } catch (err) {
                console.log(err);
                record = strValue;
            }
            allResults.push({ Key: key, Record: record });
        }
        console.info(allResults);
        return JSON.stringify(allResults);
    }

    async changeCarOwner(ctx, carNumber, newOwner) {
        console.info('============= START : changeCarOwner ===========');

        const carAsBytes = await ctx.stub.getState(carNumber); // get the car from chaincode state
        if (!carAsBytes || carAsBytes.length === 0) {
            throw new Error(`${carNumber} does not exist`);
        }
        const car = JSON.parse(carAsBytes.toString());
        car.owner = newOwner;
        
        //increament owner level whenever there is a change of owners
        car.ownerLevel = car.ownerLevel+1;

        await ctx.stub.putState(carNumber, Buffer.from(JSON.stringify(car)));
        console.info('============= END : changeCarOwner ===========');
    }

    //Dynamic query car by - make
    async queryCarByMake(ctx,make){

        let queryString = {};
        queryString.selector = {"make":make}
        let iterator = await ctx.stub.getQueryResult(JSON.stringify(queryString))
        let result = await this.getIteratorData(iterator);
        return JSON.stringify(result);
    }

    async getIteratorData (iterator){
        let resultArray =[];

        while(true){
            let res = await iterator.next();

            //res.value -- contains other metadata
            //res.value.value -- contains the actual value
            //res.value.key -- contains the key

            let resJson ={}
            if(res.value&&res.value.value.toString()){
                resJson.key = res.value.key;
                resJson.value = JSON.parse(res.value.value.toString());
                resultArray.push(resJson);
            }

            if(res.done){
                iterator.close();
                return resultArray;
            }
        }
    }
    async getAssetHistory(ctx,carNumber){
        let resultsIterator = await ctx.stub.getHistoryForKey(carNumber);
        let results = await this.getAllResults(resultsIterator,true);

        return JSON.stringify(results);
    }

    async getAllResults(iterator, isHistory) {
        let allResults = [];
        while (true) {
          let res = await iterator.next();
    
          if (res.value && res.value.value.toString()) {
            let jsonRes = {};
            console.log(res.value.value.toString('utf8'));
    
            if (isHistory && isHistory === true) {
                jsonRes.TxId = res.value.tx_id;
                jsonRes.Timestamp = res.value.timestamp;
                //jsonRes.IsDelete = res.value.is_delete.toString();
                try {
                    jsonRes.Value = JSON.parse(res.value.value.toString('utf8'));
                } catch (err) {
                    console.log(err);
                    jsonRes.Value = res.value.value.toString('utf8');
                }
            } else {
                jsonRes.Key = res.value.key;
                try {
                    jsonRes.Record = JSON.parse(res.value.value.toString('utf8'));
                } catch (err) {
                    console.log(err);
                    jsonRes.Record = res.value.value.toString('utf8');
                }
            }
            allResults.push(jsonRes);
          }
          if (res.done) {
            console.log('end of data');
            await iterator.close();
            console.info(allResults);
            return allResults;
          }
        }
    }


}


module.exports = FabCar;
