import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/view/quizAds.dart';
import 'package:quiz/view/quizOption.dart';
import 'package:quiz/view/quizanswereveal.dart';

import 'view/quiz.dart';
import 'view/quizPoint.dart';
import 'view/quizView.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: QuizPage(),
      // home: QuizView(), //reduce quiz point
      // home: QuizAds(), //with ads
      home: QuizwithAnswer(),
      // home: QuizPoint(),
      // home: QuizOption(), //reveal answer ....disable other option and enable submit button
    );
  }
}
