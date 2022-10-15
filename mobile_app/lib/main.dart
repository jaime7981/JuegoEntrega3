import 'package:flutter/material.dart';
import 'package:mobile_app/api/game_api.dart';
import 'package:mobile_app/lobby/ongoing_games.dart';

import 'login/register.dart';
import 'login/login.dart';

import 'home/home.dart';
import 'home/friends.dart';

import 'lobby/gameRoom.dart';
import 'lobby/listRoom.dart';
import 'lobby/my_games.dart';
import 'lobby/create_game.dart';
import 'lobby/game_invitations.dart';
import 'lobby/game_lobby.dart';

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
        '/gameRoom': (context) => const GameRoomView(),
        '/listRoom': (context) => const ListRoomView(),
        '/my_games': (context) => const MyGamesView(),
        '/ongoing_games': (context) => const OngoingGamesView(),
        '/create_game': (context) => const CreateGameView(),
        '/game_invitations': (context) => const GameInvitationsView(),
        '/game_lobby': (context) => const GameLobbyView(
            game: Game(id: 0, gameState: 'W', name: 'No name', host: 0)),
      },
    );
  }
}
