// ignore_for_file: use_build_context_synchronously

import 'package:budget_flow_client/Functions/localStorage.dart';
import 'package:budget_flow_client/Pages/Homepage.dart';
import 'package:budget_flow_client/Pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String usernameH = "";
  double incomeLbnH = 0;
  double incomeUsdH = 0;
  int id = 0;


  @override
   void initState() {
    super.initState();
    checkLocalStorage();
  }

  Future<void> checkLocalStorage() async {
    int? userId = await getFromLocal();
    if (userId != null) {
      var data = await getUser(userId);
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => 
       HomePage(username: data['username'], incomeLbn: data['incomeLbn'], incomeUsd: data['incomeUsd'], userId: data['userId'])));
    } else {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignUp()));
    }
  }

   Future<dynamic> getUser(int id) async {
  final url = Uri.parse('http://192.168.1.9:5021/api/User/id/$id');
  final headers = {'Content-Type': 'application/json'};

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } 
  } catch (e) {
    return null;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: LoadingAnimationWidget.threeArchedCircle(
        color: Colors.white,
        size: 150,
      ),
      ),
    );
  }
}