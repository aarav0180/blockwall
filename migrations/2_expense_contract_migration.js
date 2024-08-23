const ExpenseContract = artifacts.require("ExpenseContract");


module.exports = function (deployer) {
    deployer.deploy(ExpenseContract);
};