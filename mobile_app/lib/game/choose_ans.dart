import 'package:flutter/material.dart';
import 'package:mobile_app/api/answer_api.dart';
import 'package:mobile_app/api/question_api.dart';

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
          const Text('Question:'),
          FutureBuilder<List<Question>>(
              future: findQuestionById(widget.arguments['round'][0].question),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  debugPrint(snapshot.error.toString());
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(snapshot.data![0].question),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(snapshot.data![0].ans_1),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(snapshot.data![0].ans_2),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(snapshot.data![0].ans_3),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(snapshot.data![0].ans_4),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(snapshot.data![0].correctAnswer),
                            ),
                          ],
                        ),
                      ]);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          const Text('Players Answers'),
          FutureBuilder<List<Answer>>(
            future: roundAnswersByGameId(widget.arguments['game'].id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                debugPrint(snapshot.error.toString());
                return const Center(
                  child: Text('An error has occurred!'),
                );
              } else if (snapshot.hasData) {
                return AnswerList(answers: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ]));
  }
}

class AnswerList extends StatelessWidget {
  const AnswerList({super.key, required this.answers});

  final List<Answer> answers;

  @override
  Widget build(BuildContext context) {
    var widgetList = [];
    for (var item in answers) {
      widgetList.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('id: ${item.player}'),
          ElevatedButton(
            onPressed: () {},
            child: Text(item.playerAnswer),
          ),
        ],
      ));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[for (var item in widgetList) item],
    );
  }
}
