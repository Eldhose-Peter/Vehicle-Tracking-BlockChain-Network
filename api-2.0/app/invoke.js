const { Gateway, Wallets, TxEventHandler, GatewayOptions, DefaultEventHandlerStrategies, TxEventHandlerFactory } = require('fabric-network');
const fs = require('fs');
const EventStrategies = require('fabric-network/lib/impl/event/defaulteventhandlerstrategies');
const path = require("path")
const log4js = require('log4js');
const logger = log4js.getLogger('BasicNetwork');
const util = require('util')

const helper = require('./helper');
const { blockListener, contractListener } = require('./Listeners');

const invokeTransaction = async (channelName, chaincodeName, fcn, args, username, org_name, transientData) => {
    try {
        const ccp = await helper.getCCP(org_name);

        const walletPath = await helper.getWalletPath(org_name);
        const wallet = await Wallets.newFileSystemWallet(walletPath);
        console.log(`Wallet path: ${walletPath}`);

        let identity = await wallet.get(username);
        if (!identity) {
            console.log(`An identity for the user ${username} does not exist in the wallet, so registering user`);
            await helper.getRegisteredUser(username, org_name, true)
            identity = await wallet.get(username);
            console.log('Run the registerUser.js application before retrying');
            return;
        }


        const connectOptions = {
            wallet, identity: username, discovery: { enabled: true, asLocalhost: true }
            // eventHandlerOptions: EventStrategies.NONE
        }

        const gateway = new Gateway();
        await gateway.connect(ccp, connectOptions);

        const network = await gateway.getNetwork(channelName);
        const contract = network.getContract(chaincodeName);

        // await contract.addContractListener(contractListener);
        // await network.addBlockListener(blockListener);


        // Multiple smartcontract in one chaincode
        let result;
        let message;

        
        switch (fcn) {
            case "createCar":
                const myObj = JSON.parse(args[0]);
                console.log(myObj)
                result = await contract.submitTransaction('createCar',myObj.carNumber,myObj.model,myObj.make,myObj.color,myObj.seats,
                myObj.fuelType,myObj.transmissionType,myObj.engine,myObj.maxPower,myObj.mileage,myObj.kmDriven,myObj.year,
                myObj.avg_cost_price,myObj.owner,myObj.ownerLevel,myObj.registrationDate,myObj.insuranceID,myObj.insuranceExpiry,myObj.healthStatus,myObj.status);
                //result = await contract.submitTransaction('createCar', 'CAR12', 'Honda', 'Accord', 'Black', 'Tom');
                result = {txid: result.toString()}
                break;
            case "changeCarOwner":
                console.log("=============")
                //result = await contract.submitTransaction('changeCarOwner', 'CAR1', 'Eldho' );
                result = await contract.submitTransaction('changeCarOwner',args[0],args[1]);
                result = {txid: result.toString()}
                break;

            case "putUpForResale":
                console.log("=============")
                //result = await contract.submitTransaction('putUpForReSale', 'CAR1' );
                result = await contract.submitTransaction('putUpForResale',args[0]);
                result = {txid: result.toString()}
                break;
                
            case "purchaseInsurance":
                console.log("=============")
                //result = await contract.submitTransaction('purchaseInsurance', 'CAR1','SCHEME0' );
                result = await contract.submitTransaction('purchaseInsurance',args[0],args[1]);
                result = {txid: result.toString()}
                break;

            case "raiseClaimInsurance":
                    console.log("=============")
                    //result = await contract.submitTransaction('raiseClaimInsurance', 'CAR1' );
                    result = await contract.submitTransaction('raiseClaimInsurance',args[0]);
                    result = {txid: result.toString()}
                    break;

            case "requestInspection":
                    console.log("=============")
                    //result = await contract.submitTransaction('requestInspection', 'CAR1' );
                    result = await contract.submitTransaction('requestInspection',args[0]);
                    result = {txid: result.toString()}
                    break;
            
            case "requestForScrap":
                    console.log("=============")
                    //result = await contract.submitTransaction('requestForScrap', 'CAR1' );
                    result = await contract.submitTransaction('requestForScrap',args[0]);
                    result = {txid: result.toString()}
                    break;
            case "CreateDocument":
                result = await contract.submitTransaction('DocumentContract:'+fcn, args[0]);
                console.log(result.toString())
                result = {txid: result.toString()}
                break;
            default:
                break;
        }

        await gateway.disconnect();

        // result = JSON.parse(result.toString());

        let response = {
            message: message,
            result
        }

        return response;


    } catch (error) {

        console.log(`Getting error: ${error}`)
        return error.message

    }
}

exports.invokeTransaction = invokeTransaction;