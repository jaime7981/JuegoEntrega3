import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals_vars.dart' as globals;

// Falta crear endpoints en el backend
Future<List<Lobby>> aceptedLobbyRequests() async {
  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/lobby/acepted/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (response.statusCode == 200) {
    return parseLobby(response.body);
  } else {
    throw Exception('Failed to get friend requests.');
  }
}

Future<List<Lobby>> recievedLobbyRequests() async {
  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/lobby/recieved/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (response.statusCode == 200) {
    return parseLobby(response.body);
  } else {
    throw Exception('Failed to get friend requests.');
  }
}

Future<http.Response> sendLobbyRequests(int gameId, String username) async {
  final response = await http.post(
    Uri.parse('${globals.baseApiUrl}/lobby/send_lobby_request/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
    body: jsonEncode(<String, String>{
      'game': gameId.toString(),
      'player': username,
      'player_state': 'W',
      'points': '0',
      'acepted_request': false.toString(),
    }),
  );

  if (response.statusCode == 200) {
    debugPrint(jsonDecode(response.body).toString());
    return response;
  } else {
    throw Exception('Failed to get friend requests.');
  }
}

Future<http.Response> acceptLobby(int lobyId) async {
  final response = await http.put(
    Uri.parse('${globals.baseApiUrl}/lobby/$lobyId/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
    body: jsonEncode(<String, String>{
      'acepted_request': true.toString(),
    }),
  );

  if (response.statusCode == 200) {
    debugPrint(jsonDecode(response.body).toString());
    return response;
  } else if (response.statusCode == 204) {
    debugPrint(response.statusCode.toString());
    return response;
  } else {
    throw Exception('Failed to get friend requests.');
  }
}

Future<void> deleteLobby(int lobyId) async {
  final response = await http.delete(
    Uri.parse('${globals.baseApiUrl}/lobby/$lobyId/'),
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

class Lobby {
  final int game;
  final int player;
  final String playerState;
  final int points;
  final bool aceptedRequest;

  const Lobby({
    required this.game,
    required this.player,
    required this.playerState,
    required this.points,
    required this.aceptedRequest,
  });

  factory Lobby.fromJson(Map<String, dynamic> json) {
    return Lobby(
      game: json['game'],
      player: json['player'],
      playerState: json['playerState'],
      points: json['points'],
      aceptedRequest: json['acepted_request'],
    );
  }
}

List<Lobby> parseLobby(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Lobby>((json) => Lobby.fromJson(json)).toList();
}