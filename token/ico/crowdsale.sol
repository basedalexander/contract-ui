pragma solidity ^0.4.18;

import './safe-math.lib.sol';
import './ownable.sol';

interface Token {
    function balanceOf(address _owner) public constant returns (uint256 balance);
    function transfer(address _to, uint256 _value) public returns (bool success);
}

contract Crowdsale is Ownable {
    using SafeMath for uint256;

    Token token;
    uint256 public constant RATE = 300;
    uint256 public constant CAP = 10;
    uint256 public constant START = 1516035600;
    uint256 public constant DAYS = 1;
    bool public initialized = false;
    uint256 public raisedAmount = 0;

    function CrowdSale (address _tokenAddress) public {
        assert(_tokenAddress != 0);
        token = Token(_tokenAddress);
    }

    function initialize(uint256 numTokens) onlyOwner {
        require(initialized == false);
        require(tokensAvailable() == numTokens);
        initialized = true;
    }

    modifier whenSaleIsActive() {
        assert(isActive()); // what's the diff between require(); ?

        _;
    }

    function isActive() internal pure returns (bool) {
        return (
            initialized == true &&
            now >= START &&
            now <= START.add(DAYS * 1 days) &&
            goalReached() == false
        );
    }

    function goalReached() constant returns (bool) {
        return (raisedAmount >= CAP * 1 ether); // TODO why do we multiply by a unit?
    }

    function tokensAvailable() constant returns (uint256) {
        return token.balanceOf(this); // <-- "this" refers to Crowdsale contract address once it's been deployed;
    }

    event BoughtTokens(address indexed to, uint256 value);
}