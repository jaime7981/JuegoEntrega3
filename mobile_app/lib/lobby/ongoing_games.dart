import 'package:flutter/material.dart';

import 'package:mobile_app/api/game_api.dart';
import 'package:mobile_app/api/lobby_api.dart';

class OngoingGamesView extends StatelessWidget {
  const OngoingGamesView({super.key});

  static const String _title = 'Ongoing Games';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const OngoingGamesWidget(),
      ),
    );
  }
}

class OngoingGamesWidget extends StatefulWidget {
  const OngoingGamesWidget({super.key});

  @override
  State<OngoingGamesWidget> createState() => _OngoingGamesState();
}

class _OngoingGamesState extends State<OngoingGamesWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text('My lobbies'),
          FutureBuilder<List<Lobby>>(
            future: aceptedLobbyRequests(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return LobbyList(lobbies: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class LobbyList extends StatelessWidget {
  const LobbyList({super.key, required this.lobbies});

  final List<Lobby> lobbies;

  @override
  Widget build(BuildContext context) {
    var widgetList = [];
    for (var item in lobbies) {
      widgetList.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed("/game_lobby", arguments: {
                'game': Game(
                    id: item.game,
                    gameState: item.playerState,
                    name: item.aceptedRequest.toString(),
                    host: item.player)
              });
            },
            child: Text('game id: ${item.game}'),
          ),
          Text('player id: ${item.player} '),
          Text('state: ${item.playerState}'),
          ElevatedButton(
            onPressed: () {
              deleteLobby(item.game).then((value) => {
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed("/ongoing_games")
                  });
            },
            child: const Text('Leave Lobby'),
          ),
        ],
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[for (var item in widgetList) item],
    );
  }
}
