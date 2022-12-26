// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  const Result(this.resultScore, this.resetHandler, {super.key});
  String get resultPhrase {
    String resultText;
    if (resultScore <= 20) {
      resultText = "You are awesome and innocent";
    } else if (resultScore <= 25) {
      resultText = "You are innocent";
    } else if (resultScore <= 30) {
      resultText = "You are ... Strange";
    } else {
      resultText = "You are so bad!";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Center(
        child: Column(
      children: [
        Text(
          resultPhrase,
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        ElevatedButton(onPressed: resetHandler, child: Text("Restart Quiz"))
      ],
    ));
  }
}
