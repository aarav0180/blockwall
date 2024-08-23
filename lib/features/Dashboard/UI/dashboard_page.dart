import 'package:blockwall/features/Dashboard/bloc/dashboard_bloc.dart';
import 'package:blockwall/features/deposit/deposit.dart';
import 'package:blockwall/features/withdraw/withdraw.dart';
import 'package:blockwall/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      backgroundColor: AppColors.back,
      appBar: AppBar(
        backgroundColor: AppColors.back,
        title: const Center(child: Text("Blockchain Wallet", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold), )),
      ),
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state){

        },
        builder:(context, state) {
          switch(state.runtimeType){
            case DashboardLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case DashboardErrorState:
              return Text("Error hogaya");
            case DashboardSuccessState:
              final successState = state as DashboardSuccessState;
              return Container(


                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(color: AppColors.accent,
                          borderRadius: BorderRadius.circular(17)),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "Images/ethereum-logo-svg-vector.svg", height: 70,
                            width: 70,),
                          SizedBox(width: 15,),
                          Text(successState.balance.toString() + " Eth", style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold
                          ),),
                        ],
                      ),
                    ),
                    SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => Deposit(dashboardBloc: dashboardBloc,)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.green, borderRadius: BorderRadius
                                .circular(17)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "Images/deposit.svg", height: 30, width: 30,),
                                SizedBox(width: 10,),
                                const Text("Deposit", style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(width: 30,),

                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => Withdraw(dashboardBloc: dashboardBloc,)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.red, borderRadius: BorderRadius
                                .circular(17)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "Images/deposit.svg", height: 30, width: 30,),
                                SizedBox(width: 10,),
                                const Text("Withdraw", style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30,),

                    Text("Transactions",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),

                    Expanded(
                      child: ListView.builder(
                        itemCount: successState.transactions.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 6),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset("assets/eth-logo.svg",
                                        height: 24, width: 24),
                                    const SizedBox(width: 6),
                                    Text("12 ETH",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Text("0xF7E789734f5e6d0B1f45e75c8de629A9e4Df7b46",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text("PnS me pass krne k liye",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );

            default: return SizedBox();
          }
        }
      ),
    );
  }
}
