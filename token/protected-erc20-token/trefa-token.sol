pragma solidity ^0.4.18;

import './erc20.interface.sol';
import './safe-math.lib.sol';

contract TrefaToken is ERC20 {

    using SafeMath for uint256;

    uint public constant _totalSupply = 1000000;

    string public constant symbol = "TRF";
    string public constant name = "Trefa Token";
    uint8 public constant decimals = 3;

    mapping(address => uint256) balances;

    mapping(address => mapping(address => uint256)) allowedAddresses;

    function TrefaToken() public {
        balances[msg.sender] = _totalSupply;
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