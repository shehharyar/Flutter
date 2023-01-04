// ignore_for_file: avoid_print, prefer_const_constructors
import 'package:flutter/material.dart';

import "./quiz.dart";
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;
  final _questions = [
    {
      "questionText": "What's your favourite color?",
      "answers": [
        {"text": "Black", "score": 7},
        {"text": "Green", "score": 10},
        {"text": "White", "score": 9},
        {"text": "Red", "score": 10}
      ]
    },
    {
      "questionText": "What's ypur favourite animal?",
      "answers": [
        {"text": "Rabbit", "score": 7},
        {"text": "Snake", "score": 10},
        {"text": "Elephant", "score": 9},
        {"text": "Lion", "score": 10}
      ]
    },
    {
      "questionText": "Who's your favourite instructor?",
      "answers": [
        {"text": "David", "score": 10},
        {"text": "Brian", "score": 10},
        {"text": "Manuel", "score": 11},
        {"text": "Max", "score": 12}
      ]
    },
  ];

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print("We have more questiions Though.");
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text("Quiz App")),
          body: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questions: _questions,
                  questionIndex: _questionIndex)
              : Result(_totalScore, _resetQuiz)),
    );
  }
}
