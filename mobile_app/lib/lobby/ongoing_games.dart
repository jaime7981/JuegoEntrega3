import 'package:flutter/material.dart';

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
          const Text('TODO: My games list endpoint'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed("/game_lobby");
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
                      .pushNamed("/game_lobby");
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
