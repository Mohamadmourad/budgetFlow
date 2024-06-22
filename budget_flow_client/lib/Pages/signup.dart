import 'package:budget_flow_client/Pages/edit_budget.dart';
import 'package:budget_flow_client/Pages/login.dart';
import 'package:flutter/material.dart';
import 'package:budget_flow_client/Components/button.dart';
import 'package:budget_flow_client/Components/inputField.dart'; 
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();

  String usernameError = "";
  String emailError = "";
  String passwordError = "";

  Future<bool> checkUser() async {
  final url = Uri.parse('http://192.168.1.9:5021/api/User/${email.text}');
  final headers = {'Content-Type': 'application/json'};

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

  void signup() async{
    String username = this.username.text;
    String email = this.email.text;
    String password = this.password.text;

    setState(() {
      usernameError = "";
      emailError = "";
      passwordError = "";
    });
    if(username.isEmpty){
      setState(() {
        usernameError = "Username is required";
      });
      return;
    }
    if(email.isEmpty){
      setState(() {
        emailError = "Email is required";
      });
      return;
    }
    if(password.isEmpty){
      setState(() {
        passwordError = "Password is required";
      });
      return;
    }

    if(password.length < 6){
      setState(() {
        passwordError = "Password is too short";
      });
      return;
    }

    bool userExists = await checkUser();
  if (userExists) {
    setState(() {
      emailError = "Email already exists";
    });
    return;
  }

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => 
     EditBudget(username:username, email: email, password: password)));
  }

  void login() {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.grey[800],
    body: ListView(
      padding: const EdgeInsets.all(16.0), // Adjust padding as needed
      children: [
        const SizedBox(height: 80),
        const Icon(Icons.account_circle, size: 100, color: Colors.white),
        const Center(child: Text('SignUp', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold))),
       const SizedBox(height: 60),
        InputField(lable: 'Username', controller: username, isItPassword: false),
        Text(usernameError, style: const TextStyle(color: Colors.redAccent)),
        InputField(lable: 'Email', controller: email, isItPassword: false),
        Text(emailError, style: const TextStyle(color: Colors.redAccent)),
        InputField(lable: 'Password', controller: password, isItPassword: true),
        Text(passwordError, style: const TextStyle(color: Colors.redAccent)),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Button(label: "Login", onPressed: login, color: Colors.grey.shade900),
           const SizedBox(width: 20),
            Button(label: "SignUp", onPressed: signup, color: Colors.blue),
          ],
        ),
      ],
    ),
  );
  }
}
