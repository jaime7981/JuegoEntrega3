import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './register.dart';
import './login.dart';

void main() => runApp(const EntryApp());

class EntryApp extends StatelessWidget {
  const EntryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Entry App',
      home: const LoginView(),
      routes: <String, WidgetBuilder>{
        '/register': (context) => const RegisterView(),
      },
    );
  }
}
