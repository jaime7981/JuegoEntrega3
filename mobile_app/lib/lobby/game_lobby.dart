import 'package:flutter/material.dart';
import 'package:mobile_app/api/lobby_api.dart';
import 'package:mobile_app/api/round_api.dart';
import '../globals_vars.dart' as globals;
import 'package:mobile_app/api/game_api.dart';
import 'package:mobile_app/api/friends_api.dart';

class GameLobbyView extends StatelessWidget {
  const GameLobbyView({super.key});
  static const String _title = 'Lobby';

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: GameLobbyWidget(arguments: arguments),
      ),
    );
  }
}

class GameLobbyWidget extends StatefulWidget {
  const GameLobbyWidget({super.key, required this.arguments});
  final Map<dynamic, dynamic> arguments;

  @override
  State<GameLobbyWidget> createState() => _GameLobbyWidgetState();
}

class _GameLobbyWidgetState extends State<GameLobbyWidget> {
  var _playerList = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Text(widget.arguments["game"].name),
          Text('Game Id ${widget.arguments["game"].id}'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('Joined Players'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FutureBuilder<List<Lobby>>(
                    future: usersInLobby(widget.arguments["game"].id),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        debugPrint(snapshot.error.toString());
                        return const Center(
                          child: Text('An error has occurred!'),
                        );
                      } else if (snapshot.hasData) {
                        _playerList = snapshot.data!;
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
            ],
          ),
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
                    return FriendRequestsList(
                        friendRequests: snapshot.data!,
                        gameId: widget.arguments["game"].id);
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
              roundByGameId(widget.arguments["game"].id).then((value) => {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed("/create_ans", arguments: {
                      'game': widget.arguments["game"],
                      'players': _playerList,
                      'round': value[0]
                    })
                  });
            },
            child: const Text('Add Answer'),
          ),
          ElevatedButton(
            onPressed: () {
              roundByGameId(widget.arguments["game"].id).then((value) => {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed("/choose_ans", arguments: {
                      'game': widget.arguments["game"],
                      'players': _playerList,
                      'round': value
                    })
                  });
            },
            child: const Text('Respond Answer'),
          ),
        ]));
  }
}

class FriendRequestsList extends StatelessWidget {
  const FriendRequestsList(
      {super.key, required this.friendRequests, required this.gameId});

  final List<FriendRequest> friendRequests;
  final int gameId;

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
                sendLobbyRequests(gameId, item.recieverPlayer);
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
                sendLobbyRequests(gameId, item.senderPlayer);
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

class LobbyList extends StatelessWidget {
  const LobbyList({super.key, required this.lobbies});

  final List<Lobby> lobbies;

  @override
  Widget build(BuildContext context) {
    var widgetList = [];
    for (var item in lobbies) {
      if (item.aceptedRequest == true) {
        widgetList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('user: ${item.player} '),
            ElevatedButton(
              onPressed: () {
                deleteLobby(item.id).then((value) => {
                      if (item.player == globals.userId)
                        {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacementNamed("/ongoing_games")
                        }
                      else
                        {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacementNamed("/game_lobby", arguments: {
                            'game': Game(
                                id: item.game,
                                gameState: item.playerState,
                                name: item.aceptedRequest.toString(),
                                host: item.player)
                          })
                        }
                    });
              },
              child: const Text('Kick'),
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
