// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class Answer extends StatelessWidget {
  final VoidCallback SelectHandler;
  final String answerText;
  const Answer(this.SelectHandler, this.answerText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 36, 115, 252)),
          onPressed: SelectHandler,
          child: Text(answerText)),
    );
  }
}
