pragma solidity ^0.4.18;

contract OwnerProtected {
    address owner;

    function OwnerProtected() public {
        owner = msg.sender;
    }

    modifier ownerOnly {
        require(msg.sender == owner);
        _;
    }
}

contract Users is OwnerProtected {
    struct User {
        string fName;
        string lName;
        uint age;
    }

    mapping(address => User) users;
    address[] userAddresses;

    function registerUser(string _fName, string _lName, uint _age) public {
        var newUser = users[msg.sender];

        newUser.fName = _fName;
        newUser.lName = _lName;
        newUser.age = _age;

        userAddresses.push(msg.sender);
    }

    function getUsers() public constant returns (address[]) {
        return userAddresses;
    }

    function getUsersCount() public constant returns (uint) {
        return userAddresses.length;
    }

    function getUser() public constant returns (string, uint) {
        return (users[msg.sender].fName, users[msg.sender].age);
    }
}