import 'package:flutter/material.dart';
import './register.dart';
import './login.dart';
import './home.dart';

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
        '/home': (context) => const HomeView(),
      },
    );
  }
}
