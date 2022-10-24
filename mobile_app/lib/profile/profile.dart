import 'package:flutter/material.dart';
import '../globals_vars.dart' as globals;
import 'package:mobile_app/api/profile_api.dart';
import '../globals_vars.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const String _title = 'Profile';

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return MaterialApp(
      title: _title,
      home: Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage('assets/background3.png'),
                  fit: BoxFit.cover)),
          child: Scaffold(
            body: ProfileWidget(arguments: arguments),
            backgroundColor: Colors.transparent,
          )),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key, required this.arguments});

  final Map<dynamic, dynamic> arguments;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

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
            Text('Profile of player ${widget.arguments["userId"]}'),
            FutureBuilder<Player>(
              future: findPlayerById(widget.arguments["userId"]),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  return PlayerStatsList(player: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ]),
        ]),
      ),
    );
  }
}

class PlayerStatsList extends StatelessWidget {
  const PlayerStatsList ({super.key, required this.player});

  final Player player;
  
  @override
  Widget build(BuildContext context) {
    var widgetList = [];
    
    widgetList.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("Matches won: ${player.matchesWon}"),
      ]
    ));

    widgetList.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("Matches played: ${player.matchesWon + player.matchesLost}"),
      ]
    ));

    widgetList.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("Best answer: ${player.bestAnswer}"),
      ]
    ));

     widgetList.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("Best score: ${player.bestScore}"),
      ]
    ));
    if(player.playedRound < 1){
          widgetList.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,     
            children: <Widget>[
              const Text("Rounds win percentage: 0%"),
      ]));
    }
    else{
      widgetList.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Rounds win percentage: ${player.matchPercentage}"),
      ]));
    }

    widgetList.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        //Thought it was a funny way of putting it :)
        Text("Relationships status: ${player.manyFriends}"),
      ]
    ));

    widgetList.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text("Social Activity in game: ${player.groupPlaying}"),
      ]
    ));
 
       
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[for (var item in widgetList) item],
    );
  }
}