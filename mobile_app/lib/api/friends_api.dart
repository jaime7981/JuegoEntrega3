import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals_vars.dart' as globals;

/* 
// Class Format Example
class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}
*/

/*
var response = await post(Uri.parse(url),
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: {
      'username': username,
      'password': password,
    },
    encoding: Encoding.getByName("utf-8"));
*/

// API requests
Future<http.Response> userFriendRequests() async {
  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/friend_requests/${globals.userId}/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (response.statusCode == 200) {
    debugPrint(jsonDecode(response.body).toString());
    return response;
  } else {
    throw Exception('Failed to get friend requests.');
  }
}

Future<List<FriendRequest>> userAceptedFriendRequests() async {
  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/friend_requests/acepted/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (response.statusCode == 200) {
    return parseFriendRequest(response.body);
  } else {
    throw Exception('Failed to get friend requests.');
  }
}

Future<List<FriendRequest>> userSentFriendRequests() async {
  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/friend_requests/sent/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (response.statusCode == 200) {
    return parseFriendRequest(response.body);
  } else {
    throw Exception('Failed to get friend requests.');
  }
}

Future<List<FriendRequest>> userRecievedFriendRequests() async {
  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/friend_requests/recieved/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (response.statusCode == 200) {
    return parseFriendRequest(response.body);
  } else {
    throw Exception('Failed to get friend requests.');
  }
}

Future<http.Response> sendFriendRequests(String username) async {
  final response = await http.post(
    Uri.parse(
        '${globals.baseApiUrl}/friend_requests/send_friend_request_by_username/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
    body: jsonEncode(<String, String>{
      'sender_player': globals.username,
      'reciever_player': username,
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

Future<http.Response> acceptFriendRequests(int friendRequestId) async {
  final response = await http.put(
    Uri.parse('${globals.baseApiUrl}/friend_requests/$friendRequestId/'),
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

Future<Null> deleteFriendRequests(int friendRequestId) async {
  final response = await http.delete(
    Uri.parse('${globals.baseApiUrl}/friend_requests/$friendRequestId/'),
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

Future<http.Response> userDataById(int userId) async {
  final user = await http.get(
    Uri.parse('${globals.baseApiUrl}/players/$userId/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (user.statusCode == 200) {
    return user;
  } else {
    throw Exception('Failed to get user.');
  }
}

class FriendRequest {
  final int id;
  final int senderPlayer;
  final int recieverPlayer;
  final String senderUsername;
  final String recieverUsername;
  final bool aceptedRequest;

  const FriendRequest(
      {required this.id,
      required this.senderPlayer,
      required this.recieverPlayer,
      required this.senderUsername,
      required this.recieverUsername,
      required this.aceptedRequest});

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      id: json['id'],
      senderPlayer: json['sender_player'],
      recieverPlayer: json['reciever_player'],
      senderUsername: json['sender_username'],
      recieverUsername: json['reciever_username'],
      aceptedRequest: json['acepted_request'],
    );
  }
}

List<FriendRequest> parseFriendRequest(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<FriendRequest>((json) => FriendRequest.fromJson(json))
      .toList();
}
