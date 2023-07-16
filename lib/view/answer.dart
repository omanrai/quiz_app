import 'package:flutter/material.dart';

class QuestionsWithAnswersPage extends StatelessWidget {
  final List<Map<String, dynamic>> questions;

  const QuestionsWithAnswersPage({required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questions with Answers'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final question = questions[index];
          final questionText = question['question'];
          final options = question['options'];
          final correctAnswerIndex = question['correctAnswerIndex'];

          return ListTile(
            title: Text(
              questionText,
              style: TextStyle(fontSize: 18.0),
            ),
            subtitle: Text(
              'Correct Answer: ${options[correctAnswerIndex]}',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
