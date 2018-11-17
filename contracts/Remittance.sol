pragma solidity ^0.4.23;

contract Remittance {
    
    struct Payment{

        address alice;
        address carol;
        uint amount;
        bytes32 secureHash;
    }

    Payment[] payments;

    function deposit(address _carol,bytes32 _hash) public payable returns(uint){

        require(msg.value > 0);

        payments.push(Payment(msg.sender,_carol,msg.value,_hash));
        return payments.length-1;
    }

    function withdraw(uint payment_id,string password1,string password2) public {

        require(payment_id < payments.length);
        Payment memory pay = payments[payment_id];
        require(pay.carol == msg.sender);
        require(pay.secureHash == keccak256(abi.encodePacked(pay.alice,pay.carol,password1,password2)));
        uint amount = pay.amount;
        require(amount > 0);
        pay.amount = 0;
        msg.sender.transfer(amount);
    }
}