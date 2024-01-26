import 'package:flutter/material.dart';
import 'package:organics_salary/theme.dart';

class CoinHistoryScreen extends StatelessWidget {
  const CoinHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: double.infinity,
            child: Column(
              children: List.generate(
                10,
                (index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('สแกนแลกสินค้าที่ตู้กดขนม'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '$index',
                              style: TextStyle(
                                color: AppTheme.ognGreen,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Image(
                              image: AssetImage('assets/img/coin/ogn_coin.png'),
                              width: 25,
                              height: 25,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
