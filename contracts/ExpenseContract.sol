// SPDX-License-Identifier: MIT

contract ExpenseContract{

    address public owner;

    struct Transaction {
        address user;
        uint amount;
        string reason;
        uint timestamp;
    }

    Transaction [] public transactions;

    constructor (){
        owner = msg.sender;
    }

    event Deposit(address indexed _from, uint _amount, string _reason, uint _timestamp);
    event Withdraw(address indexed _from, uint _amount, string _reason, uint _timestamp);

    function deposit(uint _amount, string memory _reason) public payable {
        require(_amount> 0, "Deposit amount can't be less than 0");
        transactions.push(Transaction(msg.sender, _amount, _reason, block.timestamp));
        emit Deposit(msg.sender, _amount, _reason, block.timestamp);

    }

    function withdraw (uint _amount, string memory _reason) public payable {}

    function getBalance(){}

    function getTransCount(){}

    function getTotalTrans(){}

    function getTrans(){}

    function changeOwner(){}
}