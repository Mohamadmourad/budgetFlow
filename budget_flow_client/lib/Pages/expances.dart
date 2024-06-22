import 'package:budget_flow_client/Components/balanceCard.dart';
import 'package:budget_flow_client/Components/button.dart';
import 'package:budget_flow_client/Components/inputField.dart';
import 'package:flutter/material.dart';

class Expances extends StatefulWidget {
  final int userId;
  final double incomeLbn;
  final double incomeUsd;
  
  const Expances(
      {super.key,
      required this.userId,
      required this.incomeLbn,
      required this.incomeUsd});

  @override
  State<Expances> createState() => _ExpancesState();
}

class _ExpancesState extends State<Expances> {
  final TextEditingController lbn = TextEditingController();
  final TextEditingController dollar = TextEditingController();
  final TextEditingController itemName = TextEditingController();

  @override
  Widget build(BuildContext context) {

  double lbnValue = widget.incomeLbn;
  double dollarValue = widget.incomeUsd;


    return Scaffold(
    backgroundColor: Colors.grey[800],
    appBar: AppBar(
      backgroundColor: Colors.grey[800],
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    body: ListView(
      padding:const EdgeInsets.all(10), 
      children: [
        const Text('Your current budget is:', style: TextStyle(color: Colors.white, fontSize: 20)),
        const SizedBox(height: 20),
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
             BalanceCard(
              balance: lbnValue,
              country: 'lbn',
            ),
            const SizedBox(width: 20),
             BalanceCard(
              balance: dollarValue,
              country: 'usa',
            ),
          ],
        ),
        InputField(controller: itemName, lable: 'Item name', isItPassword: false),
        const SizedBox(height: 30),
        InputField(controller: lbn, lable: 'LBN value', isItPassword: false),
        const SizedBox(height: 30),
        InputField(controller: dollar, lable: 'Dollar value', isItPassword: false),
       const SizedBox(height: 90),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button(label: 'Spend', color: Colors.redAccent, onPressed: (){}),
            Button(label: 'Save Changes', color: Colors.green, onPressed: (){}),
          ],
        ),
      ],
    ),
  );
  }
}