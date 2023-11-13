const chai = require("chai");
const path = require("path");
const wasm_tester = require("circom_tester").wasm;

const buildEddsa = require("circomlibjs").buildEddsa;
const buildBabyjub = require("circomlibjs").buildBabyjub;

const assert = chai.assert;

describe("keccak256 test", function () {
    let circuit;

    this.timeout(100000);

    before( async () => {
        circuit = await wasm_tester(path.join(__dirname, "circuit", "run_keccak.circom"));
    });

    it("use three number to generate a hash number", async () => {

        //you can adjust the number of input and output
        
        const num1 = Buffer.from("7426836752475809473289");
        const num2 = Buffer.from("475647362847598489");
        const num3 = Buffer.from("3178246876");

        const input = {
            in: [num1, num2, num3]
        };

        const w = await circuit.calculateWitness(input, true);

        console.log(w[1]);
    });
});