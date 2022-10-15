import 'package:flutter/material.dart';

class MyGamesView extends StatelessWidget {
  const MyGamesView({super.key});

  static const String _title = 'My Games';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyGamesWidget(),
      ),
    );
  }
}

class MyGamesWidget extends StatefulWidget {
  const MyGamesWidget({super.key});

  @override
  State<MyGamesWidget> createState() => _MyGamesWidgetState();
}

class _MyGamesWidgetState extends State<MyGamesWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text('TODO: My games list endpoint'),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/gameRoom");
            },
            child: const Text('example lobby'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/gameRoom");
            },
            child: const Text('example lobby'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed("/create_game");
            },
            child: const Text('Create Game'),
          ),
        ],
      ),
    );
  }
}
