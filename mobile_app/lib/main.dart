import 'package:flutter/material.dart';
import 'login/register.dart';
import 'login/login.dart';
import 'home/home.dart';
import 'home/friends.dart';

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
        '/friends': (context) => const FriendsView(),
      },
    );
  }
}
