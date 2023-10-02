import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/question_screen.dart';
import 'package:quiz_app/quizmodel.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int score = context.read<QuizModel>().totalCorrect;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your Score: $score',
                style: Theme.of(context).textTheme.displayMedium),
            ElevatedButton(
              onPressed: () {
                context.read<QuizModel>().resetQuiz();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (context) => const QuestionScreen()),
                );
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
