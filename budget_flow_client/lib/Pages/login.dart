import 'package:budget_flow_client/Components/button.dart';
import 'package:budget_flow_client/Components/inputField.dart';
import 'package:budget_flow_client/Functions/localStorage.dart';
import 'package:budget_flow_client/Pages/Homepage.dart';
import 'package:budget_flow_client/Pages/signup.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();

  String usernameH = "";
  double incomeLbnH = 0;
  double incomeUsdH = 0;
  int id = 0;


  String emailError = "";
  String passwordError = "";

   Future<bool> checkUser() async {
  final url = Uri.parse('http://192.168.1.9:5021/api/User/${email.text}/password/${password.text}');
  final headers = {'Content-Type': 'application/json'};
  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      usernameH = data['username'];
      incomeLbnH = data['incomeLbn'];
      incomeUsdH = data['incomeUsd'];
      id = data['userId'];
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

  void signup() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUp()));
  }

  void login() async{
    var result = await checkUser();
    if(result){
      saveToLocal(id);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => 
       HomePage(username: usernameH, incomeLbn: incomeLbnH, incomeUsd: incomeUsdH,userId: id)));
    }
    else{
      setState(() {
        emailError = "Invalid email or password";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.grey[800],
    body: ListView(
      padding:const EdgeInsets.all(16.0), // Adjust padding as needed
      children: [
        const SizedBox(height: 80),
        const Icon(Icons.account_circle_outlined, size: 100, color: Colors.white),
        const Center(child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold))),
        const SizedBox(height: 60),
        InputField(lable: 'Email', controller: email, isItPassword: false),
        Center(child: Text(emailError, style: const TextStyle(color: Colors.redAccent))),
        InputField(lable: 'Password', controller: password, isItPassword: true),
        Text(passwordError, style: const TextStyle(color: Colors.redAccent)),
       const SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Button(label: "Signup", onPressed: signup, color: Colors.grey.shade900),
           const SizedBox(width: 20),
            Button(label: "Login", onPressed: login, color: Colors.blue),
          ],
        ),
      ],
    ),
  );
  }
}