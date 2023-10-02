import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/quizApp.dart';
import 'package:quiz_app/quizmodel.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => QuizModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const QuizApp());
  }
}
