import 'package:flutter/material.dart';
import '../globals_vars.dart' as globals;
import '../globals_vars.dart';
import 'friends.dart';
import 'buttons.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String _title = 'Home Page';

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
            body: HomeWidget(),
            backgroundColor: Colors.transparent,
          )),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("assets/background3.png"),
              fit: BoxFit.cover)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, children: [
        Stack(alignment: Alignment.center, children: [
          Container(
            width: double.infinity,
            height: 150,
            
            child: Center(
           
              child: Image.asset(
               
                "assets/logo_lobby3.png",
              ),
            ),
            decoration: const BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
          ),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton.icon(
                label: Text("Friends"),
                icon: const Icon(
                  Icons.group,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pushNamed("/friends");
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
              )),
              Expanded(child: Container()),
              VerticalDivider(width: 1.0),
              Expanded(
                  child: ElevatedButton.icon(
                label: Text("Logout"),
                icon: const Icon(
                  Icons.logout,
                  size: 30,
                  color: Colors.white,
                ),

                onPressed: () {
                  globals.userToken = '';
                  globals.userId = 0;
                  globals.username = '';
                  Navigator.of(context, rootNavigator: true).pop();
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
              ))
            ],
          ),
        ]),
        SingleChildScrollView(
            child: Column(

                children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.width * 0.25),
                MenuButton(
                  onPressed: (() {                  
                    Navigator.of(context, rootNavigator: true).pushNamed("/my_games");
                    }
                  ),
                 
                buttonText: "My Games",
                            ),
                SizedBox(height: MediaQuery.of(context).size.width * .07),
                MenuButton(
                  onPressed: (() {                  
                    Navigator.of(context, rootNavigator: true).pushNamed("/ongoing_games");
                    }
                  ),
              
                buttonText: "Ongoing",
                            ),
                SizedBox(height: MediaQuery.of(context).size.width * .07),
                MenuButton(
                  onPressed: (() {                  
                    Navigator.of(context, rootNavigator: true).pushNamed("/game_invitations");
                    }
                  ),
              
                buttonText: "Invitations",
                            ),
                SizedBox(height: MediaQuery.of(context).size.width * .07),
                MenuButton(
                  onPressed: (() {                  
                    Navigator.of(context, rootNavigator: true)
                      .pushNamed("/profiles", arguments: {'userId': globals.userId});
                    }
                  ),
              
                buttonText: "My Profile",
                ),
                

            ])),
      ]),
    ));
  }
}
