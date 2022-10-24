import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals_vars.dart' as globals;

class Game {
  final int id;
  final int host;
  final String gameState;
  final String name;

  const Game({
    required this.id,
    required this.gameState,
    required this.name,
    required this.host,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      gameState: json['game_state'],
      name: json['name'],
      host: json['host'],
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
      'game_state': 'S',
      'name': gameName,
      'host': globals.userId.toString(),
    }),
  );

  debugPrint(response.body.toString());
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

Future<Game> findGameById(int gameId) async {
  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/game/$gameId/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (response.statusCode == 200) {
    var parsedResponse = jsonDecode(response.body);
    Game game = Game(
        id: parsedResponse['id'],
        gameState: parsedResponse['game_state'],
        name: parsedResponse['name'],
        host: parsedResponse['host']);
    return game;
  } else {
    throw Exception('Failed to get game.');
  }
}

Future<http.Response> resetGame(int gameId) async {
  final response = await http.post(
    Uri.parse('${globals.baseApiUrl}/lobby/reset/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
    body: jsonEncode(<String, String>{
      'game_id': gameId.toString(),
    }),
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    debugPrint(response.statusCode.toString());
    throw Exception('Failed to get game.');
  }
}
