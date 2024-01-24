import 'package:flutter/material.dart';

class CoinHistoryScreen extends StatelessWidget {
  const CoinHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('data'),
          ),
        ),
      ),
    );
  }
}