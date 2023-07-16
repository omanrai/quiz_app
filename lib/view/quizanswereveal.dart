import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'answer.dart';

class QuizwithAnswer extends StatefulWidget {
  @override
  _QuizwithAnswerState createState() => _QuizwithAnswerState();
}

class _QuizwithAnswerState extends State<QuizwithAnswer> {
  int currentQuestionIndex = 0;
  int score = 0;
  int quizPoints = 100;
  bool isOptionSelected = false;
  bool revealAnswer = false;
  int selectedOptionIndex = -1; // Assigning an initial value
  bool canChangeAnswer = true; // Track if the user can change the answer
  bool canSubmitAnswer = false; // Track if the user can submit the answer

  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the capital of italy?',
      'options': ['Paris', 'London', 'Berlin', 'Rome'],
      'correctAnswerIndex': 3,
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
    {
      'question': 'What is the capital of italy?',
      'options': ['Paris', 'London', 'Berlin', 'Rome'],
      'correctAnswerIndex': 3,
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
    {
      'question': 'What is the capital of italy?',
      'options': ['Paris', 'London', 'Berlin', 'Rome'],
      'correctAnswerIndex': 3,
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
          canChangeAnswer = false; // Disable changing answer after reveal
          canSubmitAnswer = true; // Enable submitting answer after reveal
          revealAnswer = true;
        });
      } else {
        if (quizPoints <= 0) {
          // User has less than 0 quiz points
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Insufficient Quiz Points'),
                content: Text(
                    'You have less than 10 quiz points. Watch a video to earn 100 quiz points?'),
                actions: [
                  TextButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Watch Video'),
                    onPressed: () {
                      // Implement the logic to watch the video and earn 100 quiz points
                      setState(() {
                        quizPoints += 100;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
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
                        canChangeAnswer =
                            false; // Disable changing answer after reveal
                        canSubmitAnswer =
                            true; // Enable submitting answer after reveal
                        selectedOptionIndex = questions[currentQuestionIndex]
                            ['correctAnswerIndex'];
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
  }

  void handleOptionSelected(int? optionIndex) {
    if (canChangeAnswer) {
      // Allow changing answer if canChangeAnswer is true
      setState(() {
        selectedOptionIndex = optionIndex!;
      });
    }
  }

  void goToNextQuestion() {
    if (isOptionSelected || canSubmitAnswer) {
      if (currentQuestionIndex < questions.length - 1) {
        setState(() {
          currentQuestionIndex++;
          isOptionSelected = false;
          revealAnswer = false;
          selectedOptionIndex = -1;
          canChangeAnswer = true;
          canSubmitAnswer = false;
        });
      } else {
        // Quiz completed
        showResultsDialog();
      }
    }
  }

  void showResultsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Completed'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Your score: $score out of ${questions.length}'),
              SizedBox(height: 10.0),
              ElevatedButton(
                child: Text('Restart Quiz'),
                onPressed: () {
                  setState(() {
                    currentQuestionIndex = 0;
                    score = 0;
                    isOptionSelected = false;
                    revealAnswer = false;
                    selectedOptionIndex = -1;
                    canChangeAnswer = true;
                    canSubmitAnswer = false;
                  });
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                child: Text('View Questions with Answers'),
                onPressed: () {
                  Navigator.of(context).pop();
                  navigateToQuestionsWithAnswers();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void navigateToQuestionsWithAnswers() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuestionsWithAnswersPage(questions: questions),
      ),
    );
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
              final optionText =
                  questions[currentQuestionIndex]['options'][index];
              final isCorrectAnswer = index ==
                  questions[currentQuestionIndex]['correctAnswerIndex'];
              final isChosenAnswer = selectedOptionIndex == index;
              return ListTile(
                title: Text(
                  optionText,
                  style: TextStyle(
                    color: (revealAnswer && isCorrectAnswer)
                        ? Colors.green
                        : Colors.black,
                  ),
                ),
                leading: Radio<int>(
                  value: index,
                  groupValue: selectedOptionIndex, // Reflect selected option
                  onChanged: canChangeAnswer
                      ? (int? value) {
                          handleOptionSelected(value); // Update selected option
                          handleAnswer(value!); // Handle answer logic
                        }
                      : null,
                ),
                trailing: revealAnswer
                    ? Icon(
                        isCorrectAnswer
                            ? Icons.check
                            : (isChosenAnswer ? Icons.close : null),
                        color: (isCorrectAnswer || isChosenAnswer)
                            ? Colors.green
                            : null,
                      )
                    : null,
              );
            }),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: goToNextQuestion,
            ),
            SizedBox(height: 10.0),
            Text('Quiz Points: $quizPoints'),
          ],
        ),
      ),
    );
  }
}
