import 'package:blockwall/features/Dashboard/bloc/dashboard_bloc.dart';
import 'package:blockwall/model/transaction_model.dart';
import 'package:blockwall/utils/Colors.dart';
import 'package:flutter/material.dart';

class Withdraw extends StatefulWidget {
  final DashboardBloc dashboardBloc;
  const Withdraw({super.key, required this.dashboardBloc});

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {

  final TextEditingController addressController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController reasonsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  AppColors.red,
      appBar: AppBar(backgroundColor: AppColors.red,),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              "Deposit Details",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // TextField(
            //   controller: addressController,
            //   decoration: InputDecoration(hintText: "Enter the Address"),
            // ),
            TextField(
              controller: amountController,
              decoration: InputDecoration(hintText: "Enter the Amount"),
            ),
            TextField(
              controller: reasonsController,
              decoration: InputDecoration(hintText: "Enter the Reason"),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                widget.dashboardBloc.add(DashboardWithdrawEvent(
                    transactionModel: TransactionModel(
                        addressController.text,
                        int.parse(amountController.text),
                        reasonsController.text,
                        DateTime.now())));
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red),
                child: const Center(
                  child: Text(
                    "- Withdraw",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


