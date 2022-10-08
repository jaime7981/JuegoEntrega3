import 'package:flutter/material.dart';
import '../globals_vars.dart' as globals;

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
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              globals.userToken = '';
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text('Back'),
          ),
        ]);
  }
}
