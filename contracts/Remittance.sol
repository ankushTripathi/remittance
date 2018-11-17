pragma solidity ^0.4.23;

contract Remittance {
    
    struct Payment{

        uint amount;
        bool exists;
    }

    mapping(bytes32 => Payment) payments;

    event LogNewDeposit(bytes32 indexed _hash, address indexed alice, uint amount);
    event LogWithdrawAmount(bytes32 indexed _hash,address indexed carol, uint amount);

    function deposit(bytes32 _hash) public payable{

        require(msg.value > 0);
        require(payments[_hash].exists == false);

        emit LogNewDeposit(_hash, msg.sender, msg.value);

        payments[_hash] = Payment({
            amount : msg.value,
            exists : true
        });
    }

    function withdraw(string password) public {

        bytes32 payment_hash  = keccak256(abi.encodePacked(msg.sender,password));

        Payment storage pay = payments[payment_hash];
        require(pay.exists == true);

        uint amount = pay.amount;
        require(amount > 0);
        
        pay.amount = 0;
        emit LogWithdrawAmount(payment_hash,msg.sender,amount);
        msg.sender.transfer(amount);
    }
}