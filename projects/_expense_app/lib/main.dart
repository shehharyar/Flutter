// ignore_for_file: prefer_const_constructors

import './widgets/new_transactions.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

import 'package:flutter/material.dart';

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

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late String titleInput;
  final List<Transaction> _userTransaction = [
    Transaction(
        id: "t1", title: "New Shoes", amount: 60.99, date: DateTime.now()),
    Transaction(
        id: "t2", title: "Macbook", amount: 90.99, date: DateTime.now()),
    Transaction(id: "t3", title: "Iphone", amount: 99.99, date: DateTime.now()),
  ];
  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter App"),
          actions: [
            IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(Icons.add))
          ],
        ),
        // ignore: prefer_const_constructors
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.blueAccent,
                  child: Text("CHART"),
                ),
              ),
              TransactionList(_userTransaction),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ));
  }
}
