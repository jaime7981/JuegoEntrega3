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
    Uri.parse(
        '${globals.baseApiUrl}/usercontrol/friend_requests/${globals.userId}'),
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

Future<http.Response> userAceptedFriendRequests() async {
  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/usercontrol/friend_requests/acepted'),
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

Future<http.Response> userSentFriendRequests() async {
  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/usercontrol/friend_requests/sent'),
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

Future<http.Response> userRecievedFriendRequests() async {
  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/usercontrol/friend_requests/recieved'),
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
