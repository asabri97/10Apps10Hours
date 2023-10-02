import 'package:flutter/material.dart';

class QuizModel extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  int _selectedAnswerIndex = -1;
  int _totalCorrect = 0;

  int get currentQuestionIndex => _currentQuestionIndex;
  int get selectedAnswerIndex => _selectedAnswerIndex;
  int get totalCorrect => _totalCorrect;

  void selectAnswer(int index) {
    _selectedAnswerIndex = index;
    notifyListeners();
  }

  void submitAnswer(bool isCorrect) {
    if (isCorrect) {
      _totalCorrect++;
    }
    _currentQuestionIndex++;
    _selectedAnswerIndex = -1;
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _totalCorrect = 0;
    _selectedAnswerIndex = -1;
    notifyListeners();
  }
}
