import 'package:budget_flow_client/Components/button.dart';
import 'package:budget_flow_client/Components/inputField.dart';
import 'package:budget_flow_client/Pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Expances extends StatefulWidget {
  final int userId;
  final double incomeLbn;
  final double incomeUsd;
  final String username;

  
  const Expances(
      {super.key,
      required this.username,
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

  late double lbnValue = widget.incomeLbn;
  late double dollarValue = widget.incomeUsd;

   @override
  void initState() {
    super.initState();
    lbnValue = widget.incomeLbn;
    dollarValue = widget.incomeUsd;
  }

  void spend() {
    setState(() {
      if(lbn.text == ''){
        lbn.text = '0';
      }
      if(dollar.text == ''){
        dollar.text = '0';
      }
      double lbnSpend = double.parse(lbn.text);
      double dollarSpend = double.parse(dollar.text);
      lbnValue -= lbnSpend;
      dollarValue -= dollarSpend;
      lbn.clear();
      dollar.clear();
    });
  }

  @override
  Widget build(BuildContext context) {

     Future<void> updateUser() async {
     final url = Uri.parse('http://192.168.1.9:5021/api/User/$widget.userId');
     final headers = {'Content-Type': 'application/json'};
  
    final body = jsonEncode({
      'incomeLbn': double.parse(lbn.text),
      'incomeUsd': double.parse(dollar.text),
    });

    await http.put(url, headers: headers, body: body);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(username: widget.username, incomeLbn: double.parse(lbn.text), incomeUsd: double.parse(dollar.text), userId: widget.userId)));
   }

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
        Text('LBN: $lbnValue L.L', style: const TextStyle(color: Colors.white, fontSize: 20)),

        const SizedBox(height: 20),
        Text('USD: $dollarValue \$', style: const TextStyle(color: Colors.white, fontSize: 20)),

        InputField(controller: itemName, lable: 'Item name', isItPassword: false),
        const SizedBox(height: 30),
        InputField(controller: lbn, lable: 'LBN value', isItPassword: false),
        const SizedBox(height: 30),
        InputField(controller: dollar, lable: 'Dollar value', isItPassword: false),
       const SizedBox(height: 90),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button(label: 'Spend', color: Colors.redAccent, onPressed: spend),
            Button(label: 'Save Changes', color: Colors.green, onPressed: updateUser),
          ],
        ),
      ],
    ),
  );
  }
}