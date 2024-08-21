import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Text("Blockchain Wallet", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold), )),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("100 Eth", style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }
}
