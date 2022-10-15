import 'package:flutter/material.dart';

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
          const Text('TODO: My games list endpoint'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed("/gameRoom");
                },
                child: const Text('example lobby'),
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint('TODO: Accept Game');
                },
                child: const Text('Accept'),
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint('TODO: Refuse Game');
                },
                child: const Text('Refuse'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed("/gameRoom");
                },
                child: const Text('example lobby'),
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint('TODO: Accept Game');
                },
                child: const Text('Accept'),
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint('TODO: Refuse Game');
                },
                child: const Text('Refuse'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
