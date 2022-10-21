import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals_vars.dart' as globals;

class Round {
  final int id;
  final int game;
  final int question;
  final String roundState;

  const Round({
    required this.id,
    required this.game,
    required this.question,
    required this.roundState,
  });

  factory Round.fromJson(Map<String, dynamic> json) {
    return Round(
      id: json['id'],
      game: json['game'],
      question: json['question'],
      roundState: json['round_state'],
    );
  }
}

List<Round> parseRound(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Round>((json) => Round.fromJson(json)).toList();
}

Future<List<Round>> roundByGameId(int gameId) async {
  final response = await http.post(
    Uri.parse('${globals.baseApiUrl}/round/round_by_game'),
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
    return parseRound(response.body);
  } else if (response.statusCode == 201) {
    return parseRound(response.body);
  } else {
    throw Exception('Failed to create game.');
  }
}

Future<void> deleteRound(int roundId) async {
  final response = await http.delete(
    Uri.parse('${globals.baseApiUrl}/round/$roundId/'),
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

Future<http.Response> findRoundById(int roundId) async {
  final game = await http.get(
    Uri.parse('${globals.baseApiUrl}/round/$roundId/'),
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
