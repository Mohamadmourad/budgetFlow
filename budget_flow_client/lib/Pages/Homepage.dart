// ignore_for_file: file_names
import 'package:budget_flow_client/Components/balanceCard.dart';
import 'package:budget_flow_client/Components/button.dart';
import 'package:budget_flow_client/Components/pieChartWidget.dart';
import 'package:budget_flow_client/Pages/expances.dart';
import 'package:budget_flow_client/Pages/settings.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String username;
  final double incomeLbn;
  final double incomeUsd;
  final int userId;

  const HomePage({super.key, 
    required this.username,
    required this.incomeLbn,
    required this.incomeUsd,
    required this.userId,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double convertedValue = widget.incomeLbn / 89000;
    double lbnPercentage = convertedValue / (convertedValue + widget.incomeUsd) * 100;
    double usdPercentage = widget.incomeUsd / (convertedValue + widget.incomeUsd) * 100;

     DateTime now = DateTime.now();
     int currentDay = now.day;
    int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    double dailyBudget = (convertedValue + widget.incomeUsd) / (daysInMonth - currentDay);

    double dailyBudgetLbn = dailyBudget*89000;


    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(label: "expences", color: Colors.redAccent, 
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => new Expances(username: widget.username,userId: widget.userId, incomeLbn: widget.incomeLbn, incomeUsd: widget.incomeUsd)));
                  }),
                  IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Settings( userId: widget.userId, incomeLbn: widget.incomeLbn, incomeUsd: widget.incomeUsd)));
                    },
                   icon:const  Icon(Icons.settings, color: Colors.white, size: 30,),
                   ),
                ],
              ),
              const SizedBox(height: 20,),
              Center(child: Text(widget.username,style: const TextStyle(color: Colors.white,fontSize: 30),)),
              const SizedBox(height: 50,),
              const Text('Your Balance :',style: TextStyle(color: Colors.white,fontSize: 22),),
              const SizedBox(height: 60,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BalanceCard(balance: widget.incomeLbn, country: "lbn"),
                  BalanceCard(balance: widget.incomeUsd, country: "usd"),
                ],
              ),
              const SizedBox(height: 50,),
              const Center(child: Text("Your total balance in USD :", style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),),),
              const SizedBox(height: 30,),
               Center(
                child: BalanceCard(balance: widget.incomeUsd + convertedValue, country: "usd"),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                height: 200,
                child: PieChartWidget(
                  value1: lbnPercentage,
                  value2: usdPercentage,
                ),
              ),
              const SizedBox(height: 70),
               Center(
                child: Column(
                  children: [
                    const Text('You can spend this much every day ', style: TextStyle(color: Colors.white, fontSize: 20),),
                    const Text('until the end of the month : ', style: TextStyle(color: Colors.white, fontSize: 20),),
                    const SizedBox(height: 20,),
                    Text('${dailyBudget.toStringAsFixed(2)} USD', style:const TextStyle(color: Colors.white, fontSize: 20),),
                    const SizedBox(height: 20,),
                   const Text('Or', style: TextStyle(color: Colors.white, fontSize: 20),),
                   const SizedBox(height: 20,),
                    Text('${dailyBudgetLbn.toStringAsFixed(2)} L.L', style:const TextStyle(color: Colors.white, fontSize: 20),),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
