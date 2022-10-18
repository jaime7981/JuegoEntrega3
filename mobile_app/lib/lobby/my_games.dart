import 'package:flutter/material.dart';
import 'package:mobile_app/api/game_api.dart';

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
          const Text('Created Games'),
          FutureBuilder<List<Game>>(
            future: userCreatedGames(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return GameList(games: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
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

class GameList extends StatelessWidget {
  const GameList({super.key, required this.games});

  final List<Game> games;

  @override
  Widget build(BuildContext context) {
    var widgetList = [];
    for (var item in games) {
      widgetList.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(item.name.toString()),
          ElevatedButton(
            onPressed: () {
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameLobbyView(
                      game: item,
                    ),
                  ));*/
              Navigator.of(context, rootNavigator: true)
                  .pushNamed("/game_lobby", arguments: {'game': item});
            },
            child: const Text('Enter'),
          ),
          ElevatedButton(
            onPressed: () {
              deleteGame(item.id).then((value) => {
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacementNamed("/my_games")
                  });
            },
            child: const Text('Delete'),
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
