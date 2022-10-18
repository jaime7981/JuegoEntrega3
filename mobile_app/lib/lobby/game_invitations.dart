import 'package:flutter/material.dart';
import 'package:mobile_app/api/game_api.dart';
import 'package:mobile_app/api/lobby_api.dart';

class GameInvitationsView extends StatelessWidget {
  const GameInvitationsView({super.key});

  static const String _title = 'Game Invitations';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const GameInvitationsWidget(),
      ),
    );
  }
}

class GameInvitationsWidget extends StatefulWidget {
  const GameInvitationsWidget({super.key});

  @override
  State<GameInvitationsWidget> createState() => _GameInvitationsState();
}

class _GameInvitationsState extends State<GameInvitationsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text('Invitations'),
          FutureBuilder<List<Lobby>>(
            future: recievedLobbyRequests(),
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
      debugPrint(item.game.toString());
      widgetList.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //If you haven't accepted the game, you shouldn't be able to enter the lobby (at least at this stage of development).

          //Print the name of the game
          //const Text((game.name)),

          //Print the host of the game
          Text('Game id:${item.game}'),
          ElevatedButton(
            onPressed: () {
              acceptLobby(item.id, item.game, item.player).then((value) => {
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed("/game_lobby", arguments: {
                      'game': Game(
                          id: item.game,
                          gameState: item.playerState,
                          name: item.aceptedRequest.toString(),
                          host: item.player)
                    })
                  });
            },
            child: const Text('Accept'),
          ),
          ElevatedButton(
            onPressed: () {
              deleteLobby(item.id).then((value) => {
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed("/game_invitations")
                  });
            },
            child: const Text('Refuse'),
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
