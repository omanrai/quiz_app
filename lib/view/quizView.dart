import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizView extends StatefulWidget {
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  int currentQuestionIndex = 0;
  int score = 0;
  int quizPoints = 100;
  bool isOptionSelected = false;
  bool revealAnswer = false;
  int selectedOptionIndex = -1;

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
    if (!isOptionSelected) {
      if (selectedAnswerIndex ==
          questions[currentQuestionIndex]['correctAnswerIndex']) {
        setState(() {
          score++;
          isOptionSelected = true;
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Incorrect Answer'),
              content: Text(
                  'Do you want to use 10 quiz points to reveal the correct answer?'),
              actions: [
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () {
                    setState(() {
                      revealAnswer = true;
                      quizPoints -= 10;
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
  }

  // void goToNextQuestion() {
  //   if (isOptionSelected) {
  //     setState(() {
  //       currentQuestionIndex++;
  //       isOptionSelected = false;
  //       revealAnswer = false;
  //     });
  //   }
  // }

  void goToNextQuestion() {
    if (isOptionSelected) {
      if (currentQuestionIndex < questions.length - 1) {
        // Check if more questions are available
        setState(() {
          currentQuestionIndex++;
          isOptionSelected = false;
          revealAnswer = false;
          selectedOptionIndex =
              -1; // Reset selected option for the next question
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
                      isOptionSelected = false;
                      revealAnswer = false;
                      selectedOptionIndex = -1;
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
            Row(
              children: [
                for (int i = 0; i < questions.length; i++)
                  Container(
                    height: 5.0,
                    width: MediaQuery.of(context).size.width * 0.08,
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color:
                          i == currentQuestionIndex ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10.0),
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
              return ListTile(
                title: Text(
                  questions[currentQuestionIndex]['options'][index],
                  style: TextStyle(
                    color: revealAnswer &&
                            index ==
                                questions[currentQuestionIndex]
                                    ['correctAnswerIndex']
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
                leading: Radio(
                  value: index,
                  groupValue: null,
                  onChanged: (value) {
                    handleAnswer(value!);
                  },
                ),
                trailing: revealAnswer &&
                        index ==
                            questions[currentQuestionIndex]
                                ['correctAnswerIndex']
                    ? Icon(Icons.check, color: Colors.green)
                    : null,
              );
            }),
            ElevatedButton(
              child: Text('Next'),
              onPressed: isOptionSelected ? goToNextQuestion : null,
            ),
            SizedBox(height: 10.0),
            Text('Quiz Points: $quizPoints'),
          ],
        ),
      ),
    );
  }
}
