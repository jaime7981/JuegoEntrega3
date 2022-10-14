import 'package:flutter/material.dart';
import '../globals_vars.dart' as globals;
import 'package:mobile_app/api/friends_api.dart';

class GameRoomView extends StatelessWidget {
  const GameRoomView({super.key});

  static const String _title = 'Game Room';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const GameRoomWidget(),
      ),
    );
  }
}

class GameRoomWidget extends StatefulWidget {
  const GameRoomWidget({super.key});

  @override
  State<GameRoomWidget> createState() => _GameRoomState();
}

class _GameRoomState extends State<GameRoomWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    labelText: 'Username',
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
                      sendFriendRequests(usernameController.text).then((value) {
                        debugPrint(value.body.toString());
                        Navigator.of(context, rootNavigator: true)
                            .pushReplacementNamed("/gameRoom");
                      }).catchError((error) {
                        debugPrint(error.toString());
                      });
                    }
                  },
                  child: const Text('Send Friend Request'),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child:
                      const Text("usuarios en lobby : \n pedrito \n lucquini "),
                  //colocar lista de usuarios dentro de una sala
                ),
              ],
            ),
          ),
          Container(
            child: const Text("usuarios pendientes del lobby : "),
            //colocar lista de usuarios dentro de una sala
          ),
          Container(
            child: const Text("invitar usuario : "),
            //colocar lista de usuarios dentro de una sala
          ),
          Container(
            child: Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    debugPrint("toy funcionando");
                  },
                  child: const Text('began'),
                ),
                ElevatedButton(
                  onPressed: () {
                    debugPrint("toy funcionando");
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: const Text('Backs'),
                ),
              ],
            ),
          ),
        ]);
  }
}

void gameRoom() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatelessWidget(),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  const MyStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('The Enchanted Nightingale'),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('BUY TICKETS'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LISTEN'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
