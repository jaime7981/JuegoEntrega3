
import 'package:flutter/material.dart';
import '../globals_vars.dart' as globals;
import 'package:mobile_app/api/friends_api.dart';

class ListRoomView extends StatelessWidget {
  const ListRoomView({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const ListRoomWidget(),
      ),
    );
  }
}



class ListRoomWidget extends StatefulWidget {
  const ListRoomWidget({super.key});

    @override
  State<ListRoomWidget> createState() => _ListRoomState();
}
class _ListRoomState extends State<ListRoomWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album),
              title: Text('question about iniversidad de los andes'),
              subtitle: Text('user in: Luquini, pepito, juanito ', style: TextStyle(fontSize: 20.0),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('ENTER'),
                  onPressed: () {/* ... */},
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('LOG OUT'),
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