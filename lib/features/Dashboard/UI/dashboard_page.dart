import 'package:blockwall/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.back,
      appBar: AppBar(
        backgroundColor: AppColors.back,
        title: const Center(child: Text("Blockchain Wallet", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold), )),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
                decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(17)),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("Images/ethereum-logo-svg-vector.svg", height: 70,width: 70,),
                  SizedBox(width: 15,),
                  const Text("100 Eth", style: TextStyle(
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
                Container(
                  decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(17)),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("Images/deposit.svg", height: 30,width: 30,),
                      SizedBox(width: 10,),
                      const Text("Deposit", style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),

                SizedBox(width: 30,),

                Container(
                  decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(17)),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("Images/deposit.svg", height: 30,width: 30,),
                      SizedBox(width: 10,),
                      const Text("Withdraw", style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
