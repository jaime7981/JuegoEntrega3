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
Future<http.Response> createPlayer(
    String username, String password, String confirmation) async {
  final response = await http.post(
    Uri.parse('${globals.baseApiUrl}/players/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password1': password,
      'password2': confirmation,
    }),
  );

  if (response.statusCode == 200) {
    debugPrint(jsonDecode(response.body).toString());
    return response;
  } else {
    throw Exception('Failed to create Player.');
  }
}

Future<http.Response> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('${globals.baseApiUrl}/api-token-auth/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    globals.userToken = jsonDecode(response.body)['token'].toString();
    userInfo();
    return response;
  } else {
    throw Exception('Failed to login.');
  }
}

Future<http.Response> userInfo() async {
  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/players/get_user_info/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (response.statusCode == 200) {
    debugPrint(jsonDecode(response.body)['user'].toString());
    globals.userId = jsonDecode(response.body)['user']['id'];
    globals.username = jsonDecode(response.body)['user']['username'].toString();
    return response;
  } else {
    throw Exception(
        'Failed to get user info. maybe token ${response.body.toString()}');
  }
}
