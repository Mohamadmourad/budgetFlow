import 'package:intl/intl.dart';

class User {
  String name;
  String email;
  String password;
  String id;
  double incomeLbn;
  double incomeUsd;
  List<List<dynamic>> expenses;
  String date;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.id,
    required this.incomeLbn,
    required this.incomeUsd,
    required this.expenses,
  }) 
  : date = DateFormat('d/M/y').format(DateTime.now());
}
