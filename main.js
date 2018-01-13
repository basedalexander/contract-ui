if (typeof web3 !== 'undefined') {
    web3 = new Web3(web3.currentProvider);
} else {
    // set the provider you want from Web3.providers
    web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
}

web3.eth.defaultAccount = web3.eth.accounts[0];

var ABI = [
    {
        "constant": true,
        "inputs": [],
        "name": "getUser",
        "outputs": [
            {
                "name": "",
                "type": "string"
            },
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "name": "name",
                "type": "string"
            },
            {
                "indexed": false,
                "name": "age",
                "type": "uint256"
            }
        ],
        "name": "User",
        "type": "event"
    },
    {
        "constant": false,
        "inputs": [
            {
                "name": "_userName",
                "type": "string"
            },
            {
                "name": "_userAge",
                "type": "uint256"
            }
        ],
        "name": "setUser",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "constructor"
    }
];

var myContract = web3.eth.contract(ABI);

var myContractAdress = '0x626b81a1f433b70d7a09a2762a1fe136710135c6';
var deployedContract = myContract.at(myContractAdress);

console.log(deployedContract);

var userEvent = deployedContract.User();
userEvent.watch(function (err, result) {
    if (err) {
        console.error(err.message);
    } else {
        document.getElementById('instructor').innerHTML = result.args.name + ' ' + result.args.age;
    }
});
// deployedContract.getUser(function(err, result) {
//     if (err) {
//         console.error(err.message);
//     } else {
//         document.getElementById('instructor').innerHTML = result[0] + ' ' + result[1];
//     }
// });

var nameInput = document.querySelector('#name');
var ageInput = document.querySelector('#age');
var button = document.querySelector('#button');

button.addEventListener('click', function () {
    deployedContract.setUser(nameInput.value, ageInput.value);
});