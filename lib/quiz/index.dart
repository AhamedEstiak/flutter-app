import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _questionIndex = 0;
  int _totalScore = 0;
  final _questions = const [
    {
      'questionText': 'What\'s your favorite color?',
      'answers': [
        {'text': 'Black', 'score': 10},
        {'text': 'Red', 'score': 5},
        {'text': 'Green', 'score': 3},
        {'text': 'White', 'score': 1},
      ],
    },
    {
      'questionText': 'What\'s your favorite animal?',
      'answers': [
        {'text': 'Rabbit', 'score': 3},
        {'text': 'Snake', 'score': 11},
        {'text': 'Elephant', 'score': 5},
        {'text': 'Lion', 'score': 9},
      ],
    },
    {
      'questionText': 'Who\'s your favorite instructor?',
      'answers': [
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
        {'text': 'Max', 'score': 1},
      ],
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

    // print('score--$score');

    if (_questionIndex < _questions.length) {
      print('You have more question');
    } else {
      print('You Did it');
    }

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('This is app bar'),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          color: Colors.amberAccent,
          alignment: Alignment.center,
          // transform: Matrix4.rotationZ(0.03),
          child: _questionIndex < _questions.length
              ? Quiz(
                  questions: _questions,
                  questionIndex: _questionIndex,
                  answerQuestion: _answerQuestion,
                )
              : Result(_totalScore, _resetQuiz),
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   return Container(
  //     decoration: const BoxDecoration(color: Colors.white),
  //     child: const Center(
  //       child: Text(
  //         'Hello World',
  //         textDirection: TextDirection.ltr,
  //         style: TextStyle(
  //           fontSize: 32,
  //           color: Colors.black87,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
