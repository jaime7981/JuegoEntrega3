import 'package:flutter/material.dart';
import '../globals_vars.dart' as globals;
import 'package:mobile_app/api/friends_api.dart';
import '../globals_vars.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

  static const String _title = 'Friends Page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage('assets/background3.png'),
                  fit: BoxFit.cover)),
          child: Scaffold(
            body: FriendsWidget(),
            backgroundColor: Colors.transparent,
          )),
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/background3.png"),
                fit: BoxFit.cover)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Stack(alignment: Alignment.center, children: [
            Container(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.width * .07),
                  Text("Friends",
                      style: GoogleFonts.oswald(
                        textStyle: TextStyle(fontSize: 44),
                      )),
                ],
              ),
              width: double.infinity,
              height: 150,
              decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  label: Text("Back"),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed("/home");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                ),
                Expanded(child: Container()),
              ],
            )
          ]),
          Column(children: <Widget>[
            const Text('Accepted Friend Request'),
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
                        sendFriendRequests(usernameController.text)
                            .then((value) {
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
          ]),
        ]),
      ),
    );
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
                acceptFriendRequests(item.id).then((value) => {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed("/friends")
                    });
              },
              child: const Text('Accept'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteFriendRequests(item.id).then((value) => {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed("/friends")
                    });
              },
              child: const Text('Refuse'),
            ),
          ],
        ));
      } else if (item.aceptedRequest == false &&
          globals.username == item.senderUsername) {
        widgetList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Sent: ${item.recieverUsername}'),
            ElevatedButton(
              onPressed: () {
                deleteFriendRequests(item.id).then((value) => {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed("/friends")
                    });
              },
              child: const Text('Unsend'),
            ),
          ],
        ));
      } else if (item.aceptedRequest == true &&
          globals.username == item.senderUsername) {
        widgetList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Username: ${item.recieverUsername}'),
            ElevatedButton(
              onPressed: () {
                deleteFriendRequests(item.id).then((value) => {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed("/friends")
                    });
              },
              child: const Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                    "/profiles",
                    arguments: {'userId': item.recieverPlayer});
              },
              child: const Text('View Profile'),
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
                deleteFriendRequests(item.id).then((value) => {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed("/friends")
                    });
              },
              child: const Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pushNamed(
                    "/profiles",
                    arguments: {'userId': item.recieverPlayer});
              },
              child: const Text('View Profile'),
            ),
          ],
        ));
      } else {
        widgetList.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Username: ${item.senderUsername}'),
            ElevatedButton(
              onPressed: () {
                deleteFriendRequests(item.id).then((value) => {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacementNamed("/friends")
                    });
              },
              child: const Text('Delete'),
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
