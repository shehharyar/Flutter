import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                   child: const Card(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("payment Detals"),
                            Text("Payments"),
                            ],
                        ),
                        Row(),
                      ],
                    ),
                   ) ,
                )
              ],
            ),
            Container(child: ListView()),
          ],
        ),
      ),
    );
  }
}