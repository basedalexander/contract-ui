pragma solidity ^0.4.18;

contract Users {
    struct User {
        string name;
        uint age;
    }

    mapping(address => User) users;
    address[] userAddresses;

    event UserInfo(string name, uint age);

    function setUser(string fName, uint age) public {
        var newUser = users[msg.sender];

        if (newUser.age != 0) {
            UserInfo(newUser.name, newUser.age);
            return;
        }

        newUser.name = fName;
        newUser.age = age;

        userAddresses.push(msg.sender);

        UserInfo(newUser.name, newUser.age);
    }

    function getUsers() public constant returns (address[]) {
        return userAddresses;
    }

    function getUsersCount() public constant returns (uint) {
        return userAddresses.length;
    }

    function getMe() public constant returns (string, uint) {
        return (users[msg.sender].name, users[msg.sender].age);
    }

    function getUser(address pk) public constant returns (string, uint) {
        return (users[pk].name, users[pk].age);
    }
}