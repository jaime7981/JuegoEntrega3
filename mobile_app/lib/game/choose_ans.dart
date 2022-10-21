import 'package:flutter/material.dart';

class ChooseAnsView extends StatelessWidget {
  const ChooseAnsView({super.key});
  static const String _title = 'Choose Answer';

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: ChooseAnsWidget(arguments: arguments),
      ),
    );
  }
}

class ChooseAnsWidget extends StatefulWidget {
  const ChooseAnsWidget({super.key, required this.arguments});
  final Map<dynamic, dynamic> arguments;

  @override
  State<ChooseAnsWidget> createState() => _ChooseAnsWidgetState();
}

class _ChooseAnsWidgetState extends State<ChooseAnsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          const Text('test_user1: Ready'),
          const Text('test_user2: Ready'),
          const Text('test_user3: Waiting'),
          Text('${widget.arguments.keys}'),
          Text('${widget.arguments.values}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Answer One'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Answer Two'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('Answer Three'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Answer Four'),
              ),
            ],
          ),
        ]));
  }
}
