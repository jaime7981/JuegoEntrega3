import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals_vars.dart' as globals;

class Answer {
  final int id;
  final int round;
  final int player;
  final String answerState;
  final String playerSnswer;

  const Answer({
    required this.id,
    required this.round,
    required this.player,
    required this.answerState,
    required this.playerSnswer,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      round: json['round'],
      player: json['player'],
      answerState: json['answer_state'],
      playerSnswer: json['player_answer'],
    );
  }
}

List<Answer> parseAnswer(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Answer>((json) => Answer.fromJson(json)).toList();
}

Future<List<Answer>> roundByGameId(int gameId) async {
  final response = await http.post(
    Uri.parse('${globals.baseApiUrl}/answer/round_answers_by_game'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
    body: jsonEncode(<String, String>{
      'game_id': gameId.toString(),
    }),
  );

  debugPrint(response.body.toString());
  if (response.statusCode == 200) {
    return parseAnswer(response.body);
  } else if (response.statusCode == 201) {
    return parseAnswer(response.body);
  } else {
    throw Exception('Failed to create game.');
  }
}

Future<List<Answer>> roundByRoundId(int roundId) async {
  final response = await http.post(
    Uri.parse('${globals.baseApiUrl}/answer/round_answers_by_round'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
    body: jsonEncode(<String, String>{
      'round_id': roundId.toString(),
    }),
  );

  debugPrint(response.body.toString());
  if (response.statusCode == 200) {
    return parseAnswer(response.body);
  } else if (response.statusCode == 201) {
    return parseAnswer(response.body);
  } else {
    throw Exception('Failed to create game.');
  }
}

Future<void> deleteAnswer(int answerId) async {
  final response = await http.delete(
    Uri.parse('${globals.baseApiUrl}/answer/$answerId/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (response.statusCode == 200) {
    debugPrint(jsonDecode(response.body).toString());
  } else if (response.statusCode == 204) {
    debugPrint(response.statusCode.toString());
  } else {
    debugPrint(response.statusCode.toString());
    throw Exception('Failed to get friend requests.');
  }
}

Future<http.Response> findAnswerById(int answerId) async {
  final game = await http.get(
    Uri.parse('${globals.baseApiUrl}/answer/$answerId/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (game.statusCode == 200) {
    return game;
  } else {
    throw Exception('Failed to get round.');
  }
}
