pragma solidity ^0.4.18;

contract RegistryWithModifier {

    string name = '';
    uint age = 0;
    address owner;

    function RegistryWithModifier () public {
        owner = msg.sender;
    }

    event User(
        string name,
        uint age
    );

    modifier onlyUser() {
        require(msg.sender == owner);
        _;
    }

    function setUser(string _userName, uint _userAge) onlyUser public {
        name = _userName;
        age = _userAge;

        User(_userName, _userAge);
    }

    function getUser() public constant returns (string, uint) {
        return (name, age);
    }
}