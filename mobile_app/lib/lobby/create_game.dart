import 'package:flutter/material.dart';
import '../globals_vars.dart' as globals;
import 'package:mobile_app/api/friends_api.dart';
import 'package:mobile_app/api/game_api.dart';
import 'package:mobile_app/api/lobby_api.dart';

class CreateGameView extends StatelessWidget {
  const CreateGameView({super.key});

  static const String _title = 'Create Game';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const CreateGameWidget(),
      ),
    );
  }
}

class CreateGameWidget extends StatefulWidget {
  const CreateGameWidget({super.key});

  @override
  State<CreateGameWidget> createState() => _CreateGameWidgetState();
}

class _CreateGameWidgetState extends State<CreateGameWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController gameNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: gameNameController,
                  decoration: const InputDecoration(
                    hintText: 'Game Name',
                    labelText: 'Game Name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createGame(gameNameController.text).then((value) =>
                          {Navigator.of(context, rootNavigator: true).pop()});
                    }
                  },
                  child: const Text('Create Game'),
                ),
              ],
            ),
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
                        friendRequests: snapshot.data!, game: 1);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ]));
  }
}

class FriendRequestsList extends StatelessWidget {
  const FriendRequestsList(
      {super.key, required this.friendRequests, required this.game});

  final List<FriendRequest> friendRequests;
  final int game;
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
                sendLobbyRequests(game, item.recieverPlayer);
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
                sendLobbyRequests(game, item.recieverPlayer);
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
