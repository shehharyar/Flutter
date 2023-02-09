// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/services.dart';

import './widgets/new_transactions.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    // final curScaleFactor = MediaQuery.of(context).textScaleFactor;

    return MaterialApp(
        title: "Personal Expenses",
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            fontFamily: "QuickSand",
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: "OpenSans",
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  button: TextStyle(color: Colors.white),
                ),
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // late String titleInput;
  final List<Transaction> _userTransaction = [];

  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: chosenDate);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
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
    final appBar = AppBar(
      title: Text("Personal Expenses"),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final txListWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransaction, _deleteTransaction));
    return Scaffold(
        appBar: appBar,
        // ignore: prefer_const_constructors
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              if (isLandScape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Show Chart"),
                    Switch(
                        value: _showChart,
                        onChanged: (val) {
                          setState(() {
                            _showChart = val;
                          });
                        }),
                  ],
                ),
              if (!isLandScape)
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  width: double.infinity,
                  child: Chart(_recentTransactions),
                ),
              if (!isLandScape) txListWidget,
              if (isLandScape)
                _showChart
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.7,
                        width: double.infinity,
                        child: Chart(_recentTransactions),
                      )
                    : txListWidget,
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          elevation: 4,
          child: Icon(Icons.add),
        ));
  }
}
