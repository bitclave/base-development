'use strict';

import Base from "@bitclave/base-client-js";
import {SearchRequest} from "@bitclave/base-client-js";
import { Offer } from "@bitclave/base-client-js";

var waitUntil = require('wait-until');

async function createUser(base, passphrase) {
    let account;
    try {
        console.log("\nChecking if account already exists for:", passphrase);
        account = await base.accountManager.checkAccount(passphrase, "somemessage");
        console.log("Account already exists: " + JSON.stringify(account));
    } catch(e) {
        console.log("\nAccount doesn't exist, Creating a new one for:", passphrase);
        account = await base.accountManager.registration(passphrase, "somemessage");
        console.log("Account created:" + JSON.stringify(account));
    }
    return account;
}

describe('Matching', async () => {
    const passPhraseAlice = 'Alice';
    const passPhraseBussiness = 'ABC Inc';
    const passPhraseMatcher = 'matcher';

    const baseAlice = createBase();
    const baseBussiness = createBase();
    const baseMatcher = createBase();

    var accAlice;
    var accBussiness;
    var accMatcher;

    function createBase() {
        return new Base('http://localhost:8080', 'localhost', 'POSTGRES', '');
    }

    beforeEach(async () => {
    });

    before(async () => {
        accAlice = await createUser(baseAlice, passPhraseAlice);
        accBussiness = await createUser(baseBussiness, passPhraseBussiness);
        accMatcher = await createUser(baseMatcher, passPhraseMatcher);
    });

    after(async () => {
    });

    it('request and offer', async function() {
        this.timeout(25000);

        let searchRequestTags = new Map();
        searchRequestTags.set("type", "car");

        let compareMap = new Map();
        compareMap.set("age", "25");

        let rulesMap = new Map();
        rulesMap.set("age", "EQUALLY");
        
        let offer = new Offer('some description', 'some title', 'some imageUrl', '1',
                searchRequestTags, compareMap, rulesMap);
        try {
            console.log("\n Alice saving search request.....");
            let savedSearchRequest = await baseAlice.searchManager.createRequest(new SearchRequest(searchRequestTags));
            console.log("\n Alice Search Request:" + JSON.stringify(savedSearchRequest));

            console.log("\n ABC Inc saving offer.....", JSON.stringify(offer));
            let savedOffer = await baseBussiness.offerManager.saveOffer(offer);
            console.log("\n ABC Inc saved offer:" + JSON.stringify(savedOffer));

            console.log("\n Checking if matched.....waiting for atmost 20 seconds")
            waitUntil()
                .interval(20000)
                .times(1)
                .condition(async function() {
                    let matchedOffer = await baseBussiness.searchManager.getSearchResult(savedSearchRequest.id);
                    return (matchedOffer.length > 0);
                })
                .done(async function(result) {
                    if(result) {
                        return baseBussiness.searchManager.getSearchResult(savedSearchRequest.id);
                    }
                });
        } catch(e) {
            console.log("Something wrong in before", e);
        }
    });
});