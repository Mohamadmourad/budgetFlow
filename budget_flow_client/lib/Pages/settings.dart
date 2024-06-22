import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:budget_flow_client/Components/button.dart';
import 'package:budget_flow_client/Components/inputField.dart';
import 'package:budget_flow_client/Functions/localStorage.dart';
import 'package:budget_flow_client/Pages/loading.dart';
import 'package:budget_flow_client/Pages/signup.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final int userId;
  final double incomeLbn;
  final double incomeUsd;
  const Settings(
      {super.key,
      required this.userId,
      required this.incomeLbn,
      required this.incomeUsd});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController lbn = TextEditingController();
  final TextEditingController dollar = TextEditingController();

  
  Future<void> updateUser(int userId) async {
  final url = Uri.parse('http://192.168.1.9:5021/api/User/$userId');
  final headers = {'Content-Type': 'application/json'};
  
  final body = jsonEncode({
    'incomeLbn': double.parse(lbn.text),
    'incomeUsd': double.parse(dollar.text),
  });

   await http.put(url, headers: headers, body: body);
  
}

  void logout(){
    removeFromLocal();
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUp()));
  }

  void saveChanges()async{
    await updateUser(widget.userId);
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Loading()));
  }

  @override
  Widget build(BuildContext context) {
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
       const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child:const Center(
            child: Text(
              'Settings', 
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),
        const SizedBox(height: 50),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('lib/Images/lebanon.jpg', width: 70, height: 20),
            ],
          ),
        ),
        InputField(controller: lbn, lable: 'LBN value', isItPassword: false),
        const SizedBox(height: 70),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('lib/Images/usa.jpg', width: 70, height: 20),
            ],
          ),
        ),
        InputField(controller: dollar, lable: 'Dollar value', isItPassword: false),
       const SizedBox(height: 160),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Button(label: 'Logout', color: Colors.redAccent, onPressed:logout),
            Button(label: 'Save Changes', color: Colors.green, onPressed: saveChanges),
          ],
        ),
      ],
    ),
  );
  }
}