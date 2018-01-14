if (typeof web3 !== 'undefined') {
    web3 = new Web3(web3.currentProvider);
} else {
    // set the provider you want from Web3.providers
    web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));
}

web3.eth.defaultAccount = web3.eth.accounts[1];

var ABI =
    [
        {
            "constant": true,
            "inputs": [],
            "name": "getUsersCount",
            "outputs": [
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
            "constant": true,
            "inputs": [],
            "name": "getUsers",
            "outputs": [
                {
                    "name": "",
                    "type": "address[]"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": true,
            "inputs": [
                {
                    "name": "pk",
                    "type": "address"
                }
            ],
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
            "constant": true,
            "inputs": [],
            "name": "getMe",
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
            "name": "UserInfo",
            "type": "event"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "fName",
                    "type": "string"
                },
                {
                    "name": "age",
                    "type": "uint256"
                }
            ],
            "name": "setUser",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        }
    ];

var myContract = web3.eth.contract(ABI);

var myContractAdress = '0x36a265f8dd2b7f7a3aa51df98b39882f89de26a3';
var deployedContract = myContract.at(myContractAdress);

var userEvent = deployedContract.UserInfo();
userEvent.watch(function (err, result) {
    if (err) {
        console.error(err.message);
    } else {
        document.getElementById('instructor').innerHTML = result.args.name + ' (' + result.args.age + ' years old )';
    }
});

var nameInput = document.querySelector('#name');
var ageInput = document.querySelector('#age');
var button = document.querySelector('#button');

button.addEventListener('click', function () {
    deployedContract.setUser(nameInput.value, ageInput.value, function (err, result) {
        if (err) {
            throw new Error(err);
        } else {
            console.log('sucess user has been set');
        }
    });
});