import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals_vars.dart' as globals;

class Game {
  final int host;
  final String gameState;
  final bool name;

  const Game({
    required this.host,
    required this.gameState,
    required this.name,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      host: json['host'],
      gameState: json['gameState'],
      name: json['name'],
    );
  }
}

List<Game> parseGame(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Game>((json) => Game.fromJson(json)).toList();
}

Future<http.Response> createGame(String gameName) async {
  final response = await http.post(
    Uri.parse('${globals.baseApiUrl}/game/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
    body: jsonEncode(<String, String>{
      'game_state': 'W',
      'name': gameName,
      'host': globals.userId.toString(),
    }),
  );

  if (response.statusCode == 200) {
    return response;
  } else if (response.statusCode == 201) {
    return response;
  } else {
    throw Exception('Failed to create game.');
  }
}

Future<void> deleteGame(int gameId) async {
  final response = await http.delete(
    Uri.parse('${globals.baseApiUrl}/game/$gameId/'),
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

// Falta crear endpoints en el backend
Future<List<Game>> myGames() async {
  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/game/user_games/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (response.statusCode == 200) {
    return parseGame(response.body);
  } else {
    throw Exception('Failed to get user games.');
  }
}

Future<List<Game>> userCreatedGames() async {
  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/game/user_created_games/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (response.statusCode == 200) {
    return parseGame(response.body);
  } else {
    throw Exception('Failed to get user games.');
  }
}
