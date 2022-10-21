import 'package:flutter/material.dart';

class CreateAnsView extends StatelessWidget {
  const CreateAnsView({super.key});

  static const String _title = 'Create Answer';

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: CreateAnsWidget(arguments: arguments),
      ),
    );
  }
}

class CreateAnsWidget extends StatefulWidget {
  const CreateAnsWidget({super.key, required this.arguments});
  final Map<dynamic, dynamic> arguments;

  @override
  State<CreateAnsWidget> createState() => _CreateAnsWidgetState();
}

class _CreateAnsWidgetState extends State<CreateAnsWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: answerController,
                  decoration: const InputDecoration(
                    hintText: 'Your Answer',
                    labelText: 'Your Answer',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Submit Answer'),
                ),
              ],
            ),
          ),
          const Text('test_user4 responds'),
          const Text('Correct Answers:'),
          const Text('Other Answers'),
          const Text('test_user1: Answers Example'),
          const Text('test_user2: Answers Example'),
          const Text('test_user3: Waiting'),
          Text('${widget.arguments.keys}'),
          Text('${widget.arguments.values}'),
          Text('${widget.arguments['game']}'),
          Text('${widget.arguments['players']}'),
        ]));
  }
}
