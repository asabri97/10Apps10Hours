import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/question.dart';
import 'package:quiz_app/quizmodel.dart';
import 'package:quiz_app/result_screen.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final List<Question> questions = [
    Question("What is Flutter?", ['SDK', 'Language', 'IDE', 'Browser'], 0),
    Question("What is Dart?", ['SDK', 'Language', 'IDE', 'Browser'], 0),
    Question("What is Isolate?", ['SDK', 'Language', 'IDE', 'Browser'], 0),
    Question(
        "What is Stateless Widget?", ['SDK', 'Language', 'IDE', 'Browser'], 0),
  ];
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.amber),
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<QuizModel>(builder: (context, quizModel, child) {
          if (quizModel.currentQuestionIndex >= questions.length) {
            Future.delayed(Duration.zero, () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const ResultScreen()),
              );
            });
            return Container();
          }
          final currentQuestion = questions[quizModel.currentQuestionIndex];
          return Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentQuestion.questionText,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 15),
                ...currentQuestion.answers.asMap().entries.map((e) {
                  return RadioListTile<int>(
                    title: Text(e.value),
                    value: e.key,
                    groupValue: quizModel.selectedAnswerIndex,
                    onChanged: (value) => quizModel.selectAnswer(value!),
                  );
                }).toList(),
                const Spacer(),
                LinearProgressIndicator(
                  value: quizModel.currentQuestionIndex / questions.length,
                  color: Colors.green,
                  backgroundColor: Colors.grey[200],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      quizModel.submitAnswer(
                        quizModel.selectedAnswerIndex ==
                            currentQuestion.correctAnswerIndex,
                      );
                    },
                    child: const Text('Submit'),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          );
        }),
      ),
    );
  }
}
