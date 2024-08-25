import 'package:blockwall/features/Dashboard/bloc/dashboard_bloc.dart';
import 'package:blockwall/features/deposit/deposit.dart';
import 'package:blockwall/features/withdraw/withdraw.dart';
import 'package:blockwall/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final DashboardBloc dashboardBloc = DashboardBloc();

  @override
  void initState() {
    dashboardBloc.add(DashboardInitialFechEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accent,
      appBar:
      AppBar(title: Center(child: Text("Ethereum Wallet", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25))), backgroundColor: AppColors.accent),
      body: BlocConsumer<DashboardBloc, DashboardState>(
        bloc: dashboardBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case DashboardLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case DashboardErrorState:
              return Center(
                child: Text("Error"),
              );

            case DashboardSuccessState:
              final successState = state as DashboardSuccessState;
              return Container(
                margin:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 30),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "Images/ethereum-logo-svg-vector.svg",
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                successState.balance.toString() + ' ETH',
                                style: TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WithdrawPage(
                                        dashboardBloc: dashboardBloc,
                                      ))),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17),
                                    color: AppColors.red),
                                child: const Center(
                                  child: Text(
                                    "- DEBIT",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(width: 8),
                        Expanded(
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DepositPage(
                                        dashboardBloc: dashboardBloc,
                                      ))),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17),
                                    color: AppColors.green),
                                child: const Center(
                                  child: Text(
                                    "+ CREDIT",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                    const SizedBox(height: 30),

                    Text(
                      "Transactions",
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                        child: ListView.builder(
                          itemCount: successState.transactions.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 12),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset("Images/ethereum-logo-svg-vector.svg",
                                          height: 24, width: 24),
                                      const SizedBox(width: 10),
                                      Text(
                                        successState.transactions[index].amount
                                            .toString() +
                                            ' ETH',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Text(
                                    successState.transactions[index].address,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  Text(
                                    successState.transactions[index].reason,
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            );
                          },
                        ))
                  ],
                ),
              );

            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
