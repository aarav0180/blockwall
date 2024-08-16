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

    mapping( address => uint) public balances;

    event Deposit(address indexed _from, uint _amount, string _reason, uint _timestamp);
    event Withdraw(address indexed _from, uint _amount, string _reason, uint _timestamp);

    function deposit(uint _amount, string memory _reason) public payable {
        require(_amount> 0, "Deposit amount can't be less than 0");
        balances[msg.sender] += _amount;
        transactions.push(Transaction(msg.sender, _amount, _reason, block.timestamp));
        emit Deposit(msg.sender, _amount, _reason, block.timestamp);

    }

    function withdraw (uint _amount, string memory _reason) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        transactions.push(Transaction(msg.sender, _amount, _reason, block.timestamp));
        payable(msg.sender).transfer(_amount);
        emit(msg.sender, _amount, _reason, block.timestamp);
    }

    function getBalance(address _account)public view returns(uint){
        return balances[_account];
}

    function getTransCount()public view returns(uint){
        return transactions.length;
    }

    function getTotalTrans()public view returns(address[] memory, uint[] memory, string[] memory, uint[] memory){

    }

    function getTrans(uint _index)public view returns(address, uint, string memory, uint){
        require(_index < transactions.length, "Index out of bounds");
        Transaction memory transaction = transactions[_index];
        return (transaction.user, transaction.amount, transaction.reason, transaction.timestamp);
    }

    function changeOwner(){}
}