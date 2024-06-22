import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String lable;
  final bool isItPassword;
  const InputField({super.key, required this.controller,required this.lable,required this.isItPassword});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30,20,30,0),
      child: TextField(
        controller: widget.controller,
        cursorColor: Colors.white,
        obscureText: widget.isItPassword,
        enableSuggestions: false,
        autocorrect: false,
                decoration: InputDecoration(
                  labelText: widget.lable,
                  labelStyle:const TextStyle(color: Colors.white),
                  enabledBorder:const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder:const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
                style:const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
      
      ),
    );
  }
}