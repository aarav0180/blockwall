import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:blockwall/model/transaction_model.dart';
import 'package:meta/meta.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardInitialFechEvent>(dashboardInitialFechEvent);
    on<DashboardDepositEvent>(dashboardDepositEvent);
    on<DashboardWithdrawEvent>(dashboardWithdrawEvent);
  }

    List<TransactionModel> transactions = [];
    Web3Client? _web3Client;
    late ContractAbi _abiCode;
    late EthereumAddress _contractAddress;
    late EthPrivateKey _key;
    int balance=0;

    //Functions
    late DeployedContract _deployedContract;
    late ContractFunction _deposit;
    late ContractFunction _withdraw;
    late ContractFunction _getAllTransaction;
    late ContractFunction _getBalance;




    FutureOr<void> dashboardInitialFechEvent(DashboardInitialFechEvent event,
        Emitter<DashboardState> emit) async {
      emit(DashboardLoadingState());
      try {
        String rpcUrl = "http://127.0.0.1:7545";
        String socketUrl = "ws://127.0.0.1:7545";
        String privatekey = "0x2160f0d8adbe24f7c3f80f7e0298178cef2b6d91d792757eda91dbf7c43975ad";

        _web3Client = Web3Client(rpcUrl, http.Client(),
          socketConnector: () {
            return IOWebSocketChannel.connect(socketUrl).cast<String>();
          },
        );

        //get ABI (Smart Contract JSON)

        String abiFile = await rootBundle
            .loadString('build/contract/ExpenseContract.json');

        var jsonDecoded = jsonDecode(abiFile);

        _abiCode = ContractAbi.fromJson(
            jsonEncode(jsonDecoded["abi"]), 'ExpenseManagerContract');

        _contractAddress = EthereumAddress.fromHex(
            "0x6EfB8862101138e70C8FB0F7981141332a8387c0");

        _key = EthPrivateKey.fromHex(privatekey);

        //get deployed contract

        _deployedContract = DeployedContract(_abiCode, _contractAddress);
        _deposit = _deployedContract.function("deposit");
        _withdraw = _deployedContract.function("withdraw");
        _getBalance = _deployedContract.function("getBalance");
        _getAllTransaction = _deployedContract.function("getTotalTrans");

        final transactionsData = await _web3Client!.call(
            contract: _deployedContract,
            function: _getAllTransaction,
            params: []);
        final balanceData = await _web3Client!
            .call(contract: _deployedContract, function: _getBalance, params: [
          EthereumAddress.fromHex("0xB37933E034abF1f1C30A769B5eFeF6CB031Ec50E")
        ]);


        List<TransactionModel> trans = [];
        for (int i = 0; i < transactionsData[0].length; i++) {
          TransactionModel transactionModel = TransactionModel(
              transactionsData[0][i].toString(),
              transactionsData[1][i].toInt(),
              transactionsData[2][i],
              DateTime.fromMicrosecondsSinceEpoch(
                  transactionsData[3][i].toInt()));
          trans.add(transactionModel);
        }
        transactions = trans;

        int bal = balanceData[0].toInt();
        balance = bal;

        emit(DashboardSuccessState(transactions: transactions, balance: balance));

      }catch(e){
        log(e.toString());
        emit(DashboardErrorState());
      }
    }

  FutureOr<void> dashboardDepositEvent(
      DashboardDepositEvent event, Emitter<DashboardState> emit) async {
      try{
        final transaction = Transaction.callContract(
          from: EthereumAddress.fromHex("0xB37933E034abF1f1C30A769B5eFeF6CB031Ec50E"),
        contract: _deployedContract, function: _deposit,
        parameters: [BigInt.from(event.transactionModel.amount), event.transactionModel.reason],
        value: EtherAmount.inWei(BigInt.from(event.transactionModel.amount)));

        final result = await _web3Client!.sendTransaction(_key, transaction,
            chainId: 1337, fetchChainIdFromNetworkId: false);
        log(result.toString());
        add(DashboardInitialFechEvent());
    }catch(e){
        log(e.toString());
      }
  }

  FutureOr<void> dashboardWithdrawEvent(
      DashboardWithdrawEvent event, Emitter<DashboardState> emit) async {
    final data = await _web3Client!.call(
        contract: _deployedContract, function: _withdraw,
        params: [BigInt.from(event.transactionModel.amount), event.transactionModel.reason]);

  }
}