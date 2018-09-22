'use strict';

import Base from "@bitclave/base-client-js";
import {SearchRequest} from "@bitclave/base-client-js";
import { Offer } from "@bitclave/base-client-js";

import { expect } from 'chai';

async function createUser(base, passphrase) {
    let account;
    try {
        console.log("\nChecking if account already exists for:", passphrase);
        account = await base.accountManager.checkAccount(passphrase, "somemessage");
        console.log("Account already exists: " + JSON.stringify(account));
    } catch(e) {
        console.log("\nAccount doesn't exist, Creating a new one for:", passphrase);
        try {
            account = await base.accountManager.registration(passphrase, "somemessage");
            console.log("Account created:" + JSON.stringify(account));
        } catch(e) {
            console.log("Account created failed:", e);
            throw new Error(e);
        }
    }
    return account;
}

const createBase = () => new Base('http://localhost:8080', 'localhost', 'POSTGRES', '');
const waitFor = delay => new Promise(resolve => setTimeout(resolve, delay));

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
        this.timeout(7000);

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

            console.log("\n Checking if matched.....waiting for atmost 6 seconds");
            await waitFor(6000);
            let matchedOffer = await baseBussiness.searchManager.getSearchResult(savedSearchRequest.id);
            console.log("Matched Offer.....", JSON.stringify(matchedOffer));

            expect(matchedOffer).to.have.length(1);
            expect(matchedOffer[0].offerSearch.searchRequestId).to.equal(savedSearchRequest.id);
            expect(matchedOffer[0].offerSearch.offerId).to.equal(savedOffer.id);
        } catch(e) {
            console.log("Something wrong in before", e);
        }
    });
});