// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import './transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(title: "Flutter App", home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final List<Transaction> transactions = [
    Transaction(
        id: "t1", title: "New Shoes", amount: 60.99, date: DateTime.now()),
    Transaction(
        id: "t2", title: "Macbook", amount: 90.99, date: DateTime.now()),
    Transaction(id: "t3", title: "Iphone", amount: 99.99, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter App"),
        ),
        // ignore: prefer_const_constructors
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blueAccent,
                child: Text("CHART"),
              ),
            ),
            Column(
              children: transactions
                  .map((tx) => Card(
                        child: Row(children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.purple, width: 2),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Text(tx.amount.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.purple)),
                          ),
                          Column(
                            children: [
                              Text(tx.title),
                              Text(tx.date.toString()),
                            ],
                          )
                        ]),
                      ))
                  .toList(),
            )
          ],
        ));
  }
}
