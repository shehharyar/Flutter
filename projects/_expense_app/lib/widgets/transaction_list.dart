// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delete_tx;
  // ignore: use_key_in_widget_constructors
  TransactionList(
    this.transactions,
    this.delete_tx, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  // Textstyle: Theme.of(context).textTheme.headline6,

                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        "assets/images/waiting.png",
                        fit: BoxFit.cover,
                      ))
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return TransactionItem(
                    transaction: transactions[index], delete_tx: delete_tx);
              },
              itemCount: transactions.length,
            ),
    );
  }
}
