pragma solidity ^0.4.18;

contract Application {
    struct User {
        string username;
        string fName;
        string lName;
        uint balance;
        bool exists;
    }

    mapping(address => User) users;
    address[] userAdresses;

    event CurrentUser(
        address pk,
        string username,
        string fName,
        string lName,
        uint balance
    );

    function register(string username, string fName, string lName) public {
        if (!users[msg.sender].exists) {
            var newUser = users[msg.sender];
            newUser.username = username;
            newUser.fName = fName;
            newUser.lName = lName;
            newUser.exists = true;
            newUser.balance = 0;

            userAdresses.push(msg.sender);
        } else {
            return;
        }
    }

    function getUserAdresses() public constant returns (address[]) {
        return userAdresses;
    }

    function getMe() public constant returns (string, string, string, uint) {
        return (
            users[msg.sender].username,
            users[msg.sender].fName,
            users[msg.sender].lName,
            users[msg.sender].balance
            );
    }

    function getUserByAddress(address pk) public constant returns (string, string, string, uint) {
        if (users[pk].exists) {
           return (
            users[msg.sender].username,
            users[msg.sender].fName,
            users[msg.sender].lName,
            users[msg.sender].balance
            );
        }

    }
}