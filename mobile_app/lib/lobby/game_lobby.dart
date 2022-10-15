import 'package:flutter/material.dart';
import '../globals_vars.dart' as globals;
import 'package:mobile_app/api/game_api.dart';
import 'package:mobile_app/api/friends_api.dart';

class GameLobbyView extends StatelessWidget {
  const GameLobbyView({super.key, required this.game});
  static const String _title = 'Lobby';
  final Game game;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: GameLobbyWidget(game: game),
      ),
    );
  }
}

class GameLobbyWidget extends StatefulWidget {
  const GameLobbyWidget({super.key, required this.game});
  final Game game;

  @override
  State<GameLobbyWidget> createState() => _GameLobbyWidgetState();
}

class _GameLobbyWidgetState extends State<GameLobbyWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Text(widget.game.name),
          Text('Debug: Game Id ${widget.game.id}'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('Invite Friends'),
              FutureBuilder<List<FriendRequest>>(
                future: userAceptedFriendRequests(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error has occurred!'),
                    );
                  } else if (snapshot.hasData) {
                    return FriendRequestsList(friendRequests: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              debugPrint('TODO: Start rounds');
            },
            child: const Text('Start Game'),
          ),
        ]));
  }
}

class FriendRequestsList extends StatelessWidget {
  const FriendRequestsList({super.key, required this.friendRequests});

  final List<FriendRequest> friendRequests;

  @override
  Widget build(BuildContext context) {
    var widgetList = [];
    for (var item in friendRequests) {
      if (item.aceptedRequest == true &&
          globals.username == item.senderUsername) {
        widgetList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Username: ${item.recieverUsername}'),
            ElevatedButton(
              onPressed: () {
                debugPrint('TODO: Invite Friend');
              },
              child: const Text('Invite'),
            ),
          ],
        ));
      } else if (item.aceptedRequest == true &&
          globals.username == item.recieverUsername) {
        widgetList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Username: ${item.senderUsername}'),
            ElevatedButton(
              onPressed: () {
                debugPrint('TODO: Invite Friend');
              },
              child: const Text('Invite'),
            ),
          ],
        ));
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[for (var item in widgetList) item],
    );
  }
}
