import 'package:flutter/material.dart';
import 'package:mobile_app/game/main_game.dart';
import 'start_menu/start.dart';

import 'package:mobile_app/login/register.dart';
import 'package:mobile_app/login/login.dart';

import 'package:mobile_app/home/home.dart';
import 'package:mobile_app/home/friends.dart';

import 'package:mobile_app/lobby/my_games.dart';
import 'package:mobile_app/lobby/create_game.dart';
import 'package:mobile_app/lobby/game_invitations.dart';
import 'package:mobile_app/lobby/game_lobby.dart';
import 'package:mobile_app/lobby/ongoing_games.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/game/create_ans.dart';
import 'package:mobile_app/game/choose_ans.dart';
import 'package:mobile_app/profile/profile.dart';

import 'package:mobile_app/globals_vars.dart';

void main() => runApp(const EntryApp());

class EntryApp extends StatelessWidget {
  const EntryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Entry App',
      home: const WelcomeScreen(),
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: kPrimaryColor,
            shape: const StadiumBorder(),
            maximumSize: const Size(double.infinity, 56),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: kPrimaryLightColor,
          iconColor: kPrimaryColor,
          prefixIconColor: kPrimaryColor,
          contentPadding: EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
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
        '/choose_ans': (context) => const ChooseAnsView(),
        '/main_game': (context) => const MainGameView(),
        '/profiles': (context) => const ProfileView(),
      },
    );
  }
}
