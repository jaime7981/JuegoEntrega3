import 'package:flutter/material.dart';
import 'package:mobile_app/api/answer_api.dart';
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
  late String _gameStateButton;

  @override
  Widget build(BuildContext context) {
    if (widget.arguments["game"].gameState == 'S') {
      _gameStateButton = 'Start Game';
    } else if (widget.arguments["game"].gameState == 'W') {
      _gameStateButton = 'Writing Answers';
    } else if (widget.arguments["game"].gameState == 'A') {
      _gameStateButton = 'Answering';
    }
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          const Text('Game Status'),
          Text('Name: ${widget.arguments["game"].name}'),
          Text('State: ${widget.arguments["game"].gameState}'),
          const Text('States: Starting/Writing/Answering'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('Joined Players'),
              const Text('States: Ready/Waiting/Answering'),
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
              if (widget.arguments["game"].gameState == 'S') {
                resetGame(widget.arguments['game'].id).then((value) => {
                      roundAnswersByGameId(widget.arguments['game'].id)
                          .then((answersValue) => {
                                roundByGameId(widget.arguments["game"].id)
                                    .then((value) => {
                                          findGameById(
                                                  widget.arguments['game'].id)
                                              .then((value) => {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .pushReplacementNamed(
                                                            "/game_lobby",
                                                            arguments: {
                                                          'game': value
                                                        })
                                                  })
                                        })
                              })
                    });
              } else {
                roundAnswersByGameId(widget.arguments['game'].id)
                    .then((answersValue) => {
                          roundByGameId(widget.arguments["game"].id)
                              .then((value) => {
                                    Navigator.of(context, rootNavigator: true)
                                        .pushNamed("/main_game", arguments: {
                                      'game': widget.arguments["game"],
                                      'players': _playerList,
                                      'round': value,
                                      'answers': answersValue,
                                    }).then((value) => {
                                              if (answersValue.length >=
                                                  _playerList.length - 1)
                                                {
                                                  // Se debe cambiar a modalidad responder
                                                  changeToAnswerMode(widget
                                                          .arguments['game'].id)
                                                      .then((value) => {})
                                                }
                                            })
                                  })
                        });
              }
            },
            child: Text(_gameStateButton),
          ),
          ElevatedButton(
            onPressed: () {
              findGameById(widget.arguments['game'].id).then((value) => {
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed("/game_lobby",
                            arguments: {'game': value})
                  });
            },
            child: const Text('Refresh Lobby Data'),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('user: ${item.player} '),
                Text('state: ${item.playerState} '),
                Text('points: ${item.points} '),
              ],
            ),
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
