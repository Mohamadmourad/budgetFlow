import 'package:budget_flow_client/Components/button.dart';
import 'package:budget_flow_client/Components/inputField.dart';
import 'package:budget_flow_client/Pages/Homepage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';


class EditBudget extends StatefulWidget {
  final String username;
  final String email;
  final String password;

  const EditBudget({super.key, 
    required this.username,
    required this.email,
    required this.password,
  });


  @override
  State<EditBudget> createState() => _EditBudgetState();
}

class _EditBudgetState extends State<EditBudget> {
  final TextEditingController lbn = TextEditingController();
  final TextEditingController dollar = TextEditingController();
  int id  = 0;
  Future<void> createUser() async {
   id = generateId();
  final url = Uri.parse('http://192.168.1.9:5021/api/User');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({
    'userId': id,
    'email': widget.email,
    'username': widget.username,
    'password': widget.password,
    'incomeLbn': double.parse(lbn.text),
    'incomeUsd': double.parse(dollar.text),
  });

  await http.post(url, headers: headers, body: body);
}

void proceed() async{
  await createUser();
   // ignore: use_build_context_synchronously
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => 
   HomePage(username: widget.username, incomeLbn: double.parse(lbn.text), incomeUsd: double.parse(dollar.text), userId:  id
   )));
}

int generateId(){
  int res = 0;
  for(int i = 0;i<10;i++){
    int randomInt = Random().nextInt(10); 
    res = 10* res + randomInt; 
  }
  return res;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.grey[800],
    body: ListView(
      padding:const EdgeInsets.all(10), 
      children: [
       const SizedBox(height: 50),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            'Edit Budget', 
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
        const SizedBox(height: 90),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Image.asset('lib/Images/lebanon.jpg', width: 70, height: 20),
        ),
        InputField(controller: lbn, lable: 'LBN value', isItPassword: false),
        const SizedBox(height: 70),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Image.asset('lib/Images/usa.jpg', width: 70, height: 20),
        ),
        InputField(controller: dollar, lable: 'Dollar value', isItPassword: false),
       const SizedBox(height: 160),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Button(label: 'Proceed', color: Colors.green, onPressed: proceed),
          ],
        ),
      ],
    ),
  );
  }
}