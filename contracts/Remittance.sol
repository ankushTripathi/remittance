pragma solidity ^0.4.23;

contract Remittance {
    
    struct PaymentStruct{

        uint amount;
        bool exists;
    }

    mapping(bytes32 => PaymentStruct) paymentStructs;

    event LogFundsDeposited(bytes32 indexed _hash, address indexed alice, uint amount);
    event LogFundsWithdrawn(bytes32 indexed _hash,address indexed carol, uint amount);


    function hashing(address a,string b) public pure returns(bytes32){
        
        return keccak256(abi.encodePacked(a,b));
    }

    function deposit(bytes32 _hash) public payable{

        require(msg.value > 0);
        require(!paymentStructs[_hash].exists);

        emit LogFundsDeposited(_hash, msg.sender, msg.value);

        paymentStructs[_hash] = PaymentStruct({
            amount : msg.value,
            exists : true
        });
    }

    function withdraw(string password) public {

        bytes32 payment_hash  = keccak256(abi.encodePacked(msg.sender,password));

        PaymentStruct storage pay = paymentStructs[payment_hash];
        require(pay.exists == true);

        uint amount = pay.amount;
        require(amount > 0);
        
        pay.amount = 0;
        emit LogFundsWithdrawn(payment_hash,msg.sender,amount);
        msg.sender.transfer(amount);
    }
}