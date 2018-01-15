pragma solidity ^0.4.18;

import './erc20.interface.sol';
import './safe-math.lib.sol';

contract TrefaToken is ERC20 {

    using SafeMath for uint256;

    uint256 public _totalSupply = 0;

    string public constant symbol = "TRF";
    string public constant name = "Trefa Token";
    uint8 public constant decimals = 18;
    uint256 public constant RATE = 300;

    address public owner;

    mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowedAddresses;

    function TrefaToken() public {
        owner = msg.sender;
    }

    function createTokens() public payable {
        require(msg.value > 0);

        uint256 tokens = msg.value.mul(RATE);

        balances[msg.sender] = balances[msg.sender].add(tokens);

        owner.transfer(msg.value);

        _totalSupply = _totalSupply.add(tokens);
    }

    // When ether is sent directly to contract address
    function () public payable {
        createTokens();
    }

    function totalSupply() public constant returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public constant returns (uint256) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(
            balances[msg.sender] > _value
            && _value > 0
        );

        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);

        Transfer(msg.sender, _to, _value);

        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(
            allowedAddresses[_from][msg.sender] >= 0
            && balances[_from] >= _value
            && _value > 0
        );

        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowedAddresses[_from][msg.sender] = allowedAddresses[_from][msg.sender].sub(_value);

        Transfer(_from, _to, _value);

        return true;
    }


    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowedAddresses[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);

        return true;
    }

    function allowance(address _owner, address _spender) public constant returns (uint256 remaining) {
        return allowedAddresses[_owner][_spender];
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}