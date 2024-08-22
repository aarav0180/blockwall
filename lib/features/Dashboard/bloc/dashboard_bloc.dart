import 'dart:async';
import 'dart:convert';
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
  }

    List<TransactionModel> transactions = [];
    Web3Client? _web3Client;
    late ContractAbi _abiCode;
    late EthereumAddress _contractAddress;
    late EthPrivateKey _creds;

    //Functions
    late DeployedContract _deployedContract;
    late ContractFunction _deposit;
    late ContractFunction _withdraw;
    late ContractFunction _getAllTransaction;
    late ContractFunction _getBalance;

//    on<DashboardDepositEvent>(dashboardDepositEvent);
//    on<DashboardWithdrawEvent>(dashboardWithdrawEvent);


    FutureOr<void> dashboardInitialFechEvent(DashboardInitialFechEvent event,
        Emitter<DashboardState> emit) async {
      emit(DashboardLoadingState());

      final String rpcUrl = "http://127.0.0.1:7545";
      final String socketUrl = "ws://127.0.0.1:7545";

      final String privatekey = "0x2160f0d8adbe24f7c3f80f7e0298178cef2b6d91d792757eda91dbf7c43975ad";

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

      _contractAddress = EthereumAddress.fromHex(jsonDecoded["networks"]["5777"]["address"]);

      _creds = EthPrivateKey.fromHex(privatekey);

      //get deployed contract

      _deployedContract = DeployedContract(_abiCode, _contractAddress);
      _deposit = _deployedContract.function("deposit");
      _withdraw = _deployedContract.function("withdraw");
      _getBalance = _deployedContract.function("getBalance");
      _getAllTransaction = _deployedContract.function("getTotalTrans");


    }
}