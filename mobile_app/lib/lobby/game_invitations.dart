import 'package:flutter/material.dart';
import '../globals_vars.dart' as globals;
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
          const Text('TODO: SOLVED'),
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
      widgetList.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //If you haven't accepted the game, you shouldn't be able to enter the lobby (at least at this stage of development).

          //Print the name of the game
          //const Text((game.name)),

          //Print the host of the game
          //const Text(game.host)

          ElevatedButton(
            onPressed: () {
              acceptLobby(item.game).then((value) => {
                    //TODO: Should actually take you to the game probably
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed("/ongoing_games")
                  });
            },
            child: const Text('Accept'),
          ),
          ElevatedButton(
            onPressed: () {
              deleteLobby(item.game).then((value) => {
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed("/ongoing_games")
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
