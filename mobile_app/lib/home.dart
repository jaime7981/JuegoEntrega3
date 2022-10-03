import 'package:flutter/material.dart';
import './globals_vars.dart' as globals;

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const String _title = 'Home Page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const HomeWidget(),
      ),
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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              globals.userToken = '';
              Navigator.of(context, rootNavigator: true).pushNamed("/");
            },
            child: const Text('Logout'),
          ),
        ]);
  }
}
