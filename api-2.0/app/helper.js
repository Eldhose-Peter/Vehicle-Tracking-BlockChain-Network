'use strict';

var { Gateway, Wallets } = require('fabric-network');
const path = require('path');
const FabricCAServices = require('fabric-ca-client');
const fs = require('fs');

const util = require('util');

const getCCP = async (org) => {
    let ccpPath = null;
    org == 'Trans' ? ccpPath = path.resolve(__dirname, '..', 'config', 'connection-trans.json') : null
    org == 'Manuf' ? ccpPath = path.resolve(__dirname, '..', 'config', 'connection-manuf.json') : null
    org == 'Insur' ? ccpPath = path.resolve(__dirname, '..', 'config', 'connection-insur.json') : null
    org == 'Owner' ? ccpPath = path.resolve(__dirname, '..', 'config', 'connection-owner.json') : null
    org == 'Scrap' ? ccpPath = path.resolve(__dirname, '..', 'config', 'connection-scrap.json') : null

    const ccpJSON = fs.readFileSync(ccpPath, 'utf8')
    const ccp = JSON.parse(ccpJSON);
    return ccp
}

const getCaUrl = async (org, ccp) => {
    let caURL = null
    org == 'Trans' ? caURL = ccp.certificateAuthorities['ca.trans.example.com'].url : null
    org == 'Manuf' ? caURL = ccp.certificateAuthorities['ca.manuf.example.com'].url : null
    org == 'Insur' ? caURL = ccp.certificateAuthorities['ca.insur.example.com'].url : null
    org == 'Owner' ? caURL = ccp.certificateAuthorities['ca.owner.example.com'].url : null
    org == 'Scrap' ? caURL = ccp.certificateAuthorities['ca.scrap.example.com'].url : null

    return caURL

}

const getWalletPath = async (org) => {
    let walletPath = null
    org == 'Trans' ? walletPath = path.join(process.cwd(), 'trans-wallet') : null
    org == 'Manuf' ? walletPath = path.join(process.cwd(), 'manuf-wallet') : null
    org == 'Insur' ? walletPath = path.join(process.cwd(), 'insur-wallet') : null
    org == 'Owner' ? walletPath = path.join(process.cwd(), 'owner-wallet') : null
    org == 'Scrap' ? walletPath = path.join(process.cwd(), 'scrap-wallet') : null

    return walletPath
}

// Affiliations are not being used currently
const getAffiliation = async (org) => {
    // Default in ca config file we have only two affiliations, if you want ti use org3 ca, you have to update config file with third affiliation
    //  Here already two Affiliation are there, using i am using "org2.department1" even for org3
    // return org == "Org1" ? 'org1.department1' : 'org2.department1'

    let aff = null
    org == 'Trans' ? aff = 'trans.department1' : null
    org == 'Manuf' ? aff = 'manuf.department1' : null
    org == 'Insur' ? aff = 'insur.department1' : null
    org == 'Owner' ? aff = 'owner.department1' : null
    org == 'Scrap' ? aff = 'scrap.department1' : null

    return aff

}

const getRegisteredUser = async (username, userOrg, isJson) => {
    let ccp = await getCCP(userOrg)

    const caURL = await getCaUrl(userOrg, ccp)
    console.log("ca url is ", caURL)
    const ca = new FabricCAServices(caURL);

    const walletPath = await getWalletPath(userOrg)
    const wallet = await Wallets.newFileSystemWallet(walletPath);
    console.log(`Wallet path: ${walletPath}`);

    const userIdentity = await wallet.get(username);
    if (userIdentity) {
        console.log(`An identity for the user ${username} already exists in the wallet`);
        var response = {
            success: true,
            message: username + ' enrolled Successfully',
        };
        return response
    }

    // Check to see if we've already enrolled the admin user.
    let adminIdentity = await wallet.get('admin');
    if (!adminIdentity) {
        console.log('An identity for the admin user "admin" does not exist in the wallet');
        await enrollAdmin(userOrg, ccp);
        adminIdentity = await wallet.get('admin');
        console.log("Admin Enrolled Successfully")
    }

    // build a user object for authenticating with the CA
    const provider = wallet.getProviderRegistry().getProvider(adminIdentity.type);
    const adminUser = await provider.getUserContext(adminIdentity, 'admin');
    let secret;
    try {
        // Register the user, enroll the user, and import the new identity into the wallet.
        //secret = await ca.register({ affiliation: await getAffiliation(userOrg), enrollmentID: username, role: 'client' }, adminUser);
        secret = await ca.register({ enrollmentID: username, role: 'client' }, adminUser);

        // const secret = await ca.register({ affiliation: 'org1.department1', enrollmentID: username, role: 'client', attrs: [{ name: 'role', value: 'approver', ecert: true }] }, adminUser);

    } catch (error) {
        return error.message
    }

    const enrollment = await ca.enroll({ enrollmentID: username, enrollmentSecret: secret });
    // const enrollment = await ca.enroll({ enrollmentID: username, enrollmentSecret: secret, attr_reqs: [{ name: 'role', optional: false }] });

    let x509Identity = {
        credentials: {
            certificate: enrollment.certificate,
            privateKey: enrollment.key.toBytes(),
        },
        mspId: `${userOrg}MSP`,
        type: 'X.509',
    };
    await wallet.put(username, x509Identity);
    console.log(`Successfully registered and enrolled admin user ${username} and imported it into the wallet`);

    var response = {
        success: true,
        message: username + ' enrolled Successfully',
    };
    return response
}

const isUserRegistered = async (username, userOrg) => {
    const walletPath = await getWalletPath(userOrg)
    const wallet = await Wallets.newFileSystemWallet(walletPath);
    console.log(`Wallet path: ${walletPath}`);

    const userIdentity = await wallet.get(username);
    if (userIdentity) {
        console.log(`An identity for the user ${username} exists in the wallet`);
        return true
    }
    return false
}


const getCaInfo = async (org, ccp) => {
    let caInfo = null
    org == 'Trans' ? caInfo = ccp.certificateAuthorities['ca.trans.example.com'] : null
    org == 'Manuf' ? caInfo = ccp.certificateAuthorities['ca.manuf.example.com'] : null
    org == 'Insur' ? caInfo = ccp.certificateAuthorities['ca.insur.example.com'] : null
    org == 'Owner' ? caInfo = ccp.certificateAuthorities['ca.owner.example.com'] : null
    org == 'Scrap' ? caInfo = ccp.certificateAuthorities['ca.scrap.example.com'] : null
    return caInfo
}

const getOrgMSP = (org) => {
    let orgMSP = null
    org == 'Trans' ? orgMSP = 'TransMSP' : null
    org == 'Manuf' ? orgMSP = 'ManufMSP' : null
    org == 'Insur' ? orgMSP = 'InsurMSP' : null
    org == 'Owner' ? orgMSP = 'OwnerMSP' : null
    org == 'Scrap' ? orgMSP = 'ScrapMSP' : null

    return orgMSP

}

const enrollAdmin = async (org, ccp) => {
    console.log('calling enroll Admin method')
    try {
        const caInfo = await getCaInfo(org, ccp) //ccp.certificateAuthorities['ca.org1.example.com'];
        const caTLSCACerts = caInfo.tlsCACerts.pem;
        const ca = new FabricCAServices(caInfo.url, { trustedRoots: caTLSCACerts, verify: false }, caInfo.caName);

        // Create a new file system based wallet for managing identities.
        const walletPath = await getWalletPath(org) //path.join(process.cwd(), 'wallet');
        const wallet = await Wallets.newFileSystemWallet(walletPath);
        console.log(`Wallet path: ${walletPath}`);

        // Check to see if we've already enrolled the admin user.
        const identity = await wallet.get('admin');
        if (identity) {
            console.log('An identity for the admin user "admin" already exists in the wallet');
            return;
        }

        // Enroll the admin user, and import the new identity into the wallet.
        const enrollment = await ca.enroll({ enrollmentID: 'admin', enrollmentSecret: 'adminpw' });
        console.log("Enrollment object is : ", enrollment)
        let x509Identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: `${org}MSP`,
            type: 'X.509',
        };

        await wallet.put('admin', x509Identity);
        console.log('Successfully enrolled admin user "admin" and imported it into the wallet');
        return
    } catch (error) {
        console.error(`Failed to enroll admin user "admin": ${error}`);
    }
}

const registerAndGerSecret = async (username, userOrg) => {
    let ccp = await getCCP(userOrg)

    const caURL = await getCaUrl(userOrg, ccp)
    const ca = new FabricCAServices(caURL);

    const walletPath = await getWalletPath(userOrg)
    const wallet = await Wallets.newFileSystemWallet(walletPath);
    console.log(`Wallet path: ${walletPath}`);

    const userIdentity = await wallet.get(username);
    if (userIdentity) {
        console.log(`An identity for the user ${username} already exists in the wallet`);
        var response = {
            success: true,
            message: username + ' enrolled Successfully',
        };
        return response
    }

    // Check to see if we've already enrolled the admin user.
    let adminIdentity = await wallet.get('admin');
    if (!adminIdentity) {
        console.log('An identity for the admin user "admin" does not exist in the wallet');
        await enrollAdmin(userOrg, ccp);
        adminIdentity = await wallet.get('admin');
        console.log("Admin Enrolled Successfully")
    }

    // build a user object for authenticating with the CA
    const provider = wallet.getProviderRegistry().getProvider(adminIdentity.type);
    const adminUser = await provider.getUserContext(adminIdentity, 'admin');
    let secret;
    try {
        // Register the user, enroll the user, and import the new identity into the wallet.
        //secret = await ca.register({ affiliation: await getAffiliation(userOrg), enrollmentID: username, role: 'client' }, adminUser);
        secret = await ca.register({enrollmentID: username, role: 'client' }, adminUser);
        // const secret = await ca.register({ affiliation: 'org1.department1', enrollmentID: username, role: 'client', attrs: [{ name: 'role', value: 'approver', ecert: true }] }, adminUser);
        const enrollment = await ca.enroll({
            enrollmentID: username,
            enrollmentSecret: secret
        });
        let orgMSPId = getOrgMSP(userOrg)
        const x509Identity = {
            credentials: {
                certificate: enrollment.certificate,
                privateKey: enrollment.key.toBytes(),
            },
            mspId: orgMSPId,
            type: 'X.509',
        };
        await wallet.put(username, x509Identity);
    } catch (error) {
        return error.message
    }

    var response = {
        success: true,
        message: username + ' enrolled Successfully',
        secret: secret
    };
    return response

}

exports.getRegisteredUser = getRegisteredUser

module.exports = {
    getCCP: getCCP,
    getWalletPath: getWalletPath,
    getRegisteredUser: getRegisteredUser,
    isUserRegistered: isUserRegistered,
    registerAndGerSecret: registerAndGerSecret

}
