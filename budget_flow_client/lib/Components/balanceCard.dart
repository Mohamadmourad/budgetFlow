import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final String country;

  const BalanceCard({
    super.key,
    required this.balance,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    String image = '';
    String countryCurrency = "";
    if (country == 'lbn') {
      image = 'lib/Images/lebanon.jpg';
      countryCurrency = "L.L";
    } else {
      image = 'lib/Images/usa.jpg';
      countryCurrency = "USD";
    }
    int total = balance.toInt();
    
    return Container(
      width: 140,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade700,
                width: 3.0, 
              ),
              borderRadius: BorderRadius.circular(10), 
            ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Image.asset(image, width: 70, height: 20),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '$total $countryCurrency',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}