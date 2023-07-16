import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;

  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Paris', 'London', 'Berlin', 'Rome'],
      'correctAnswerIndex': 0,
    },
    {
      'question': 'Who painted the Mona Lisa?',
      'options': ['Van Gogh', 'Leonardo da Vinci', 'Picasso', 'Monet'],
      'correctAnswerIndex': 1,
    },
    {
      'question': 'What is the largest planet in our solar system?',
      'options': ['Venus', 'Saturn', 'Jupiter', 'Mars'],
      'correctAnswerIndex': 2,
    },
  ];

  void handleAnswer(int selectedAnswerIndex) {
    if (selectedAnswerIndex ==
        questions[currentQuestionIndex]['correctAnswerIndex']) {
      setState(() {
        score++;
      });
    }

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Quiz completed
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quiz Completed'),
            content: Text('Your score: $score out of ${questions.length}'),
            actions: [
              TextButton(
                child: Text('Restart Quiz'),
                onPressed: () {
                  setState(() {
                    currentQuestionIndex = 0;
                    score = 0;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz App')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}:',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              questions[currentQuestionIndex]['question'],
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            ...List<Widget>.generate(
                questions[currentQuestionIndex]['options'].length, (index) {
              return RadioListTile(
                title: Text(questions[currentQuestionIndex]['options'][index]),
                value: index,
                groupValue: null,
                onChanged: (value) {
                  handleAnswer(value!);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
