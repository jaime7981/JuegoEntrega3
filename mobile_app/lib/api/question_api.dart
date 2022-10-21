import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals_vars.dart' as globals;

class Question {
  final int id;
  final String question;
  final String correctAnswer;
  final String ans_1;
  final String ans_2;
  final String ans_3;
  final String ans_4;

  const Question({
    required this.id,
    required this.question,
    required this.correctAnswer,
    required this.ans_1,
    required this.ans_2,
    required this.ans_3,
    required this.ans_4,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      correctAnswer: json['correct_answer'],
      ans_1: json['ans_1'],
      ans_2: json['ans_2'],
      ans_3: json['ans_3'],
      ans_4: json['ans_4'],
    );
  }
}

List<Question> parseQuestion(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Question>((json) => Question.fromJson(json)).toList();
}

Future<List<Question>> findQuestionById(int questionId) async {
  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/question/$questionId/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (response.statusCode == 200) {
    debugPrint('[${response.body}]');
    return parseQuestion('[${response.body}]');
  } else {
    throw Exception('Failed to get question.');
  }
}
