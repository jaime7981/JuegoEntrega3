import 'package:flutter/material.dart';

import 'package:mobile_app/login/register.dart';
import 'package:mobile_app/login/login.dart';

import 'package:mobile_app/home/home.dart';
import 'package:mobile_app/home/friends.dart';

import 'package:mobile_app/lobby/my_games.dart';
import 'package:mobile_app/lobby/create_game.dart';
import 'package:mobile_app/lobby/game_invitations.dart';
import 'package:mobile_app/lobby/game_lobby.dart';
import 'package:mobile_app/lobby/ongoing_games.dart';

import 'package:mobile_app/game/create_ans.dart';

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
        '/my_games': (context) => const MyGamesView(),
        '/ongoing_games': (context) => const OngoingGamesView(),
        '/create_game': (context) => const CreateGameView(),
        '/game_invitations': (context) => const GameInvitationsView(),
        '/game_lobby': (context) => const GameLobbyView(),
        '/create_ans': (context) => const CreateAnsView(),
      },
    );
  }
}
