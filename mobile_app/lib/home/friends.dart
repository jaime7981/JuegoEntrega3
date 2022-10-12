import 'package:flutter/material.dart';
import '../globals_vars.dart' as globals;
import 'package:mobile_app/api/friends_api.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

  static const String _title = 'Friends Page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const FriendsWidget(),
      ),
    );
  }
}

class FriendsWidget extends StatefulWidget {
  const FriendsWidget({super.key});

  @override
  State<FriendsWidget> createState() => _FriendsWidgetState();
}

class _FriendsWidgetState extends State<FriendsWidget> {
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
                            .pushReplacementNamed("/friends");
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('Acepted Friend Request'),
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
              const Text('Sent Friend Request'),
              FutureBuilder<List<FriendRequest>>(
                future: userSentFriendRequests(),
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
              const Text('Recieved Friend Request'),
              FutureBuilder<List<FriendRequest>>(
                future: userRecievedFriendRequests(),
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
        ]);
  }
}

class FriendRequestsList extends StatelessWidget {
  const FriendRequestsList({super.key, required this.friendRequests});

  final List<FriendRequest> friendRequests;

  @override
  Widget build(BuildContext context) {
    var widgetList = [];
    for (var item in friendRequests) {
      if (item.aceptedRequest == false &&
          globals.username == item.recieverUsername) {
        widgetList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(item.senderUsername.toString()),
            ElevatedButton(
              onPressed: () {
                acceptFriendRequests(item.senderUsername, item.id).then(
                    (value) => {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacementNamed("/friends")
                        });
              },
              child: const Text('Accept Friend Request'),
            ),
          ],
        ));
      } else if (item.aceptedRequest == false &&
          globals.username == item.senderUsername) {
        widgetList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Waiting response from: ${item.recieverUsername}'),
          ],
        ));
      } else if (item.aceptedRequest == true &&
          globals.username == item.senderUsername) {
        widgetList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Username: ${item.recieverUsername}'),
          ],
        ));
      } else if (item.aceptedRequest == true &&
          globals.username == item.recieverUsername) {
        widgetList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Username: ${item.senderUsername}'),
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
