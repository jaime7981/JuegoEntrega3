import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../globals_vars.dart' as globals;

class Player {
  final int userId;

  final int matchesWon;
  final int matchesLost;
  final int totalMatches;
  final int matchPercentage;

  final DateTime creationDate;
  final DateTime currentDate;

  final int bestScore;

  final String bestAnswer;

  final int playedRound;
  final int roundsWon;
  final int roundPercentage;
  
  final int friendsAmount;
  final String manyFriends;

  final int invitesMade;
  final String groupPlaying;
  

  const Player({
    required this.userId,

    required this.matchesWon,
    required this.matchesLost,
    required this.totalMatches,
    required this.matchPercentage,

    required this.creationDate,
    required this.currentDate,

    required this.bestScore,

    required this.bestAnswer,

    required this.playedRound,
    required this.roundsWon,
    required this.roundPercentage,
    
    required this.friendsAmount,
    required this.manyFriends,

    required this.invitesMade,
    required this.groupPlaying,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      userId: json['user'],

      matchesWon: json['matches_won'],
      matchesLost: json['matches_lost'],
      totalMatches: json['total_matches'],
      matchPercentage: json['match_percentage'],

      creationDate: json['creation_date'],
      currentDate: json['current_date'],

      bestScore: json['best_score'],

      bestAnswer: json['best_answer'],

      playedRound: json['played_round'],
      roundsWon: json['rounds_won'],
      roundPercentage: json['round_percentage'],
      
      friendsAmount: json['friends_amount'],
      manyFriends: json['many_friends'],

      invitesMade: json['invites_made'],
      groupPlaying: json['group_playing'],
    );
  }
}

List<Player> parsePlayer(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return parsed.map<Player>((json) => Player.fromJson(json)).toList();
}


Future<Player> findPlayerById(int userId) async {  final response = await http.get(
    Uri.parse('${globals.baseApiUrl}/profiles/$userId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Token ${globals.userToken}',
    },
  );

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    Player player = Player(
        userId: json['user'],

          matchesWon: json['matches_won'],
          matchesLost: json['matches_lost'],
          totalMatches: json['total_matches'],
          matchPercentage: json['match_percentage'],

          creationDate: json['creation_date'],
          currentDate: json['current_date'],

          bestScore: json['best_score'],

          bestAnswer: json['best_answer'],

          playedRound: json['played_round'],
          roundsWon: json['rounds_won'],
          roundPercentage: json['round_percentage'],
          
          friendsAmount: json['friends_amount'],
          manyFriends: json['many_friends'],

          invitesMade: json['invites_made'],
          groupPlaying: json['group_playing'],
    );
    return player;
  } else {
    throw Exception('Failed to get game.');
  }
}