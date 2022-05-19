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
                insuranceExpiry : '2022/05/22',
                isInsuranceVerified : true,
                raiseClaim : false,
                requestForInspection : false,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
                isRegistrationVerified : true,
                healthStatus : 'Good',
                status: 'Vehicle-Registered',
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
                insuranceExpiry : '2022/05/22',
                isInsuranceVerified : true,
                raiseClaim : false,
                requestForInspection : false,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
                isRegistrationVerified : true,
                healthStatus : 'Good',
                status: 'Vehicle-Registered',
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
                insuranceExpiry : '2022/05/22',
                isInsuranceVerified : true,
                raiseClaim : false,
                requestForInspection : false,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
                isRegistrationVerified : true,
                healthStatus : 'Good',
                status: 'Vehicle-Registered',
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
                insuranceExpiry : '2022/05/22',
                isInsuranceVerified : true,
                raiseClaim : false,
                requestForInspection : false,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
                isRegistrationVerified : true,
                healthStatus : 'Good',
                status: 'Vehicle-Registered',
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
                insuranceExpiry : '2022/05/22',
                isInsuranceVerified : true,
                raiseClaim : false,
                requestForInspection : false,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
                isRegistrationVerified : true,
                healthStatus : 'Good',
                status: 'Vehicle-Registered',
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
                insuranceExpiry : '2022/05/22',
                isInsuranceVerified : true,
                raiseClaim : false,
                requestForInspection : false,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
                isRegistrationVerified : true,
                healthStatus : 'Good',
                status: 'Vehicle-Registered',
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
                insuranceExpiry : '2022/05/22',
                isInsuranceVerified : true,
                raiseClaim : false,
                requestForInspection : false,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
                isRegistrationVerified : true,
                healthStatus : 'Good',
                status: 'Vehicle-Registered',
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
                insuranceExpiry : '2022/05/22',
                isInsuranceVerified : true,
                raiseClaim : false,
                requestForInspection : false,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
                isRegistrationVerified : true,
                healthStatus : 'Good',
                status: 'Vehicle-Registered',
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
                insuranceExpiry : '2022/05/22',
                isInsuranceVerified : true,
                raiseClaim : false,
                requestForInspection : false,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
                isRegistrationVerified : true,
                healthStatus : 'Good',
                status: 'Vehicle-Registered',
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
                insuranceExpiry : '2022/05/22',
                isInsuranceVerified : true,
                raiseClaim : false,
                requestForInspection : false,
                year: 2015,
                kmDriven: 50000,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
                isRegistrationVerified : true,
                healthStatus : 'Good',
                status: 'Vehicle-Registered',
            },
            {
                color: 'black',
                make: 'Volkswagen',
                model: 'Polo',
                owner: 'Volkswagen',
                mileage: 15,
                lastPrice: 1000000,
                ownerID: 0,
                ownerLevel: 0,
                insuranceID: 0,
                insuranceExpiry : null,
                isInsuranceVerified : false,
                raiseClaim : false,
                requestForInspection : false,
                year: 2020,
                kmDriven: 0,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
                isRegistrationVerified : true,
                healthStatus : 'Good',
                status: 'Vehicle-OnSale',
            },
            {
                color: 'white',
                make: 'Toyota',
                model: 'Yaris',
                owner: 'Toyota',
                mileage: 15,
                lastPrice: 1000000,
                ownerID: 0,
                ownerLevel: 0,
                insuranceID: 0,  
                insuranceExpiry : null,
                isInsuranceVerified : false,
                raiseClaim : false,
                requestForInspection : false,
                year: 2020,
                kmDriven: 0,
                fuelType: 'Diesel',
                transmissionType : 'Automatic', 
                seats: 5,
                maxPower: 150,
                isRegistrationVerified : true,
                healthStatus : 'Good',
                status: 'Vehicle-OnSale',
            },
        ];

        for (let i = 0; i < cars.length; i++) {
            cars[i].docType = 'car';
            await ctx.stub.putState('CAR' + i, Buffer.from(JSON.stringify(cars[i])));
            console.info('Added <--> ', cars[i]);
        }

        const insuranceSchemes = [
            {
                name: 'policy2256',
                cost: 10000,
                coverage: 'fullbody',
                agency: 'MIC',
                validity: 1,
            },
            {
                name: 'policy1776',
                cost: 8000,
                coverage: 'fullbody',
                agency: 'MIC',
                validity: 2,
            },

        ];

        

        for (let i = 0; i < insuranceSchemes.length; i++) {
            insuranceSchemes[i].docType = 'insuranceScheme';
            await ctx.stub.putState('SCHEME' + i, Buffer.from(JSON.stringify(insuranceSchemes[i])));
            console.info('Added <--> ', insuranceSchemes[i]);
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

    async createCar(ctx, carNumber, make, model, color, owner,mileage,lastPrice,ownerId,ownerLevel,insuranceID,year,kmDriven,fuelType,transmissionType,seats,maxPower,status) {
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
            insuranceExpiry : '2022/05/22',
            isInsuranceVerified : true,
            raiseClaim : false,
            requestForInspection : false,
            year,
            kmDriven,
            fuelType,
            transmissionType,
            seats,
            maxPower,
            engine,
            status,
        };

        await ctx.stub.putState(carNumber, Buffer.from(JSON.stringify(car)));
        console.info('============= END : Create Car ===========');
    }

    async queryAllDocuments(ctx) {
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

    async queryAllInsuranceSchemes(ctx){

        let queryString = {};
        queryString.selector = {"docType" :'insuranceScheme'}
        let iterator = await ctx.stub.getQueryResult(JSON.stringify(queryString))
        let result = await this.getIteratorData(iterator);
        return JSON.stringify(result);
    }

    async queryAllInspectionRequests(ctx){

        let queryString = {};
        queryString.selector = {"requestForInspection" : true}
        let iterator = await ctx.stub.getQueryResult(JSON.stringify(queryString))
        let result = await this.getIteratorData(iterator);
        return JSON.stringify(result);
    }

    async queryAllInsuranceClaimRequests(ctx){

        let queryString = {};
        queryString.selector = {"raiseClaim" : true}
        let iterator = await ctx.stub.getQueryResult(JSON.stringify(queryString))
        let result = await this.getIteratorData(iterator);
        return JSON.stringify(result);
    }

    async queryRegistrationsNotVerified(ctx){
            
            let queryString = {};
            queryString.selector = {"isRegistrationVerified" : false}
            let iterator = await ctx.stub.getQueryResult(JSON.stringify(queryString))
            let result = await this.getIteratorData(iterator);
            return JSON.stringify(result);
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
        car.status = "Owner-Transfered"
        car.isRegistrationVerified = false;

        await ctx.stub.putState(carNumber, Buffer.from(JSON.stringify(car)));
        console.info('============= END : changeCarOwner ===========');
    }

    async putUpForResale(ctx, carNumber) {
        console.info('============= START : putUpForResale ===========');

        const carAsBytes = await ctx.stub.getState(carNumber); // get the car from chaincode state
        if (!carAsBytes || carAsBytes.length === 0) {
            throw new Error(`${carNumber} does not exist`);
        }
        const car = JSON.parse(carAsBytes.toString());
        
        car.status = "For-Sale"

        await ctx.stub.putState(carNumber, Buffer.from(JSON.stringify(car)));
        console.info('============= END : putUpForResale ===========');
    }

    async purchaseInsurance(ctx,carNumber,insuranceID){
        console.info('============= START : purchaseInsurance ===========');

        const carAsBytes = await ctx.stub.getState(carNumber); // get the car from chaincode state
        if (!carAsBytes || carAsBytes.length === 0) {
            throw new Error(`${carNumber} does not exist`);
        }
        const car = JSON.parse(carAsBytes.toString());
        
        const insuranceAsBytes = await ctx.stub.getState(insuranceID); // get the car from chaincode state
        if (!insuranceAsBytes || insuranceAsBytes.length === 0) {
            throw new Error(`${insuranceID} does not exist`);
        }
        const insurance = JSON.parse(insuranceAsBytes.toString());

        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear() +insurance.validity; //increament year with validity to get expiry year
        today =  yyyy+ '/' + mm + '/' +dd ;

        car.insuranceID = insuranceID;
        car.insuranceExpiry = String(today);
        car.isInsuranceVerified = false;
        car.raiseClaim = false;
        car.status = "Insurance-Purchased"

        await ctx.stub.putState(carNumber, Buffer.from(JSON.stringify(car)));
        console.info('============= END : purchaseInsurance ===========');
    }

    async raiseClaimInsurance(ctx,carNumber){
        console.info('============= START : raiseClaimInsurance ===========');

        const carAsBytes = await ctx.stub.getState(carNumber); // get the car from chaincode state
        if (!carAsBytes || carAsBytes.length === 0) {
            throw new Error(`${carNumber} does not exist`);
        }
        const car = JSON.parse(carAsBytes.toString());

        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
        var yyyy = today.getFullYear(); 
        today =  yyyy+ '/' + mm + '/' +dd ;

        if(car.insuranceExpiry!=null&&car.insuranceExpiry>=String(today)){
            car.raiseClaim = true;
            car.status = "Insurance-Claim-Raised"
            await ctx.stub.putState(carNumber, Buffer.from(JSON.stringify(car)));
       
        }
        else{
            throw new Error ('Insurance has expired or does not exist')
        }

        console.info('============= END : raiseClaimInsurance ===========');
    }

    async requestInspection(ctx,carNumber){
        console.info('============= START : requestInspection ===========');

        const carAsBytes = await ctx.stub.getState(carNumber); // get the car from chaincode state
        if (!carAsBytes || carAsBytes.length === 0) {
            throw new Error(`${carNumber} does not exist`);
        }
        const car = JSON.parse(carAsBytes.toString());

        car.requestForInspection = true;
        car.status = "Request-For-Inspection";
        await ctx.stub.putState(carNumber, Buffer.from(JSON.stringify(car)));

        console.info('============= END : requestInspection ===========');
    }

    async requestForScrap(ctx,carNumber){
        console.info('============= START : requestForScrap ===========');

        const carAsBytes = await ctx.stub.getState(carNumber); // get the car from chaincode state
        if (!carAsBytes || carAsBytes.length === 0) {
            throw new Error(`${carNumber} does not exist`);
        }
        const car = JSON.parse(carAsBytes.toString());

        car.healthStatus = "Poor";
        car.status = "Request-For-Scrap";
        await ctx.stub.putState(carNumber, Buffer.from(JSON.stringify(car)));

        console.info('============= END : requestForScrap ===========');
    }
   
    //Dynamic query car by - make
    async queryCarByMake(ctx,make){

        let queryString = {};
        queryString.selector = {"make":make}
        let iterator = await ctx.stub.getQueryResult(JSON.stringify(queryString))
        let result = await this.getIteratorData(iterator);
        return JSON.stringify(result);
    }

     //Dynamic query car by - owner
     async queryCarByOwner(ctx,owner){

        let queryString = {};
        queryString.selector = {"owner":owner}
        let iterator = await ctx.stub.getQueryResult(JSON.stringify(queryString))
        let result = await this.getIteratorData(iterator);
        return JSON.stringify(result);
    }

    //Dynamic query car by - ownerLevel equal to 1
    async queryCarForSale(ctx){

        let queryString = {};
        queryString.selector = {};
        queryString.selector.docType = 'car';
        queryString.selector.ownerLevel = 0;
        queryString.selector.status = 'Vehicle-Manufactured';
        queryString.selector.isRegistrationVerified = true;
        let iterator = await ctx.stub.getQueryResult(JSON.stringify(queryString))
        let result = await this.getIteratorData(iterator);
        return JSON.stringify(result);
    }

    //Dynamic query car by - ownerLevel greater than 0
    async queryCarForResale(ctx){

        let queryString = {};
        queryString.selector ={};
        queryString.selector.docType = 'car';
        queryString.selector.ownerLevel = {"$gt": 0};
        queryString.selector.status = 'For-Sale';
        queryString.selector.isRegistrationVerified = true;
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
