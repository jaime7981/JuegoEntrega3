import 'package:flutter/material.dart';
import 'package:mobile_app/api/answer_api.dart';
import 'package:mobile_app/api/game_api.dart';
import 'package:mobile_app/api/lobby_api.dart';
import 'package:mobile_app/api/question_api.dart';
import 'package:mobile_app/api/round_api.dart';
import '../globals_vars.dart' as globals;

class MainGameView extends StatelessWidget {
  const MainGameView({super.key});
  static const String _title = 'Choose Answer';

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MainGameWidget(arguments: arguments),
      ),
    );
  }
}

class MainGameWidget extends StatefulWidget {
  const MainGameWidget({super.key, required this.arguments});
  final Map<dynamic, dynamic> arguments;

  @override
  State<MainGameWidget> createState() => _MainGameWidgetState();
}

class _MainGameWidgetState extends State<MainGameWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Answer> answers = widget.arguments['answers'];
    List<Lobby> lobby = widget.arguments['players'];

    if (widget.arguments['game'].gameState == 'A') {
      return RespondQuestion(
          questionId: widget.arguments['round'][0].question,
          answers: widget.arguments['answers'],
          lobbyPlayers: widget.arguments['players'],
          gameId: widget.arguments['game'].id);
    } else if (widget.arguments['game'].gameState == 'W') {
      return SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
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
                onPressed: () {
                  debugPrint(widget.arguments["round"].toString());
                  if (answers.length >= lobby.length - 1) {
                    // Ultima pregunta por ser subida
                    createAnswersByRoundId(
                            widget.arguments["round"].id, answerController.text)
                        .then((value) => {
                              // Se debe cambiar a modalidad responder
                              changeToAnswerMode(widget.arguments['game'].id)
                                  .then((value) => {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop()
                                      })
                            });
                  } else {
                    createAnswersByRoundId(
                            widget.arguments["round"].id, answerController.text)
                        .then((value) =>
                            {Navigator.of(context, rootNavigator: true).pop()});
                  }
                },
                child: const Text('Submit Answer'),
              ),
            ],
          ),
        ),
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
    } else if (widget.arguments['game'].gameState == 'S') {
      return ElevatedButton(
        onPressed: () {
          debugPrint('TODO: Start Round');
        },
        child: const Text('Start Round'),
      );
    }

    return const Text('Something went wrong with unkown error');
  }
}

class RespondQuestion extends StatelessWidget {
  const RespondQuestion(
      {super.key,
      required this.questionId,
      required this.answers,
      required this.lobbyPlayers,
      required this.gameId});
  final int questionId;
  final List<Answer> answers;
  final List<Lobby> lobbyPlayers;
  final int gameId;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text('Question:'),
          FutureBuilder<List<Question>>(
              future: findQuestionById(questionId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  debugPrint(snapshot.error.toString());
                  return const Center(
                    child: Text('An error has occurred!'),
                  );
                } else if (snapshot.hasData) {
                  return MixedListWidget(
                      question: snapshot.data!,
                      userAnswers: answers,
                      lobbyPlayers: lobbyPlayers,
                      gameId: gameId);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ]);
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

class MixedListWidget extends StatefulWidget {
  const MixedListWidget(
      {super.key,
      required this.question,
      required this.userAnswers,
      required this.lobbyPlayers,
      required this.gameId});

  final List<Question> question;
  final List<Answer> userAnswers;
  final List<Lobby> lobbyPlayers;
  final int gameId;

  @override
  State<MixedListWidget> createState() => _MixedListWidgetState();
}

class _MixedListWidgetState extends State<MixedListWidget> {
  bool _showAnswer = false;
  String _pointsWon = '';

  @override
  Widget build(BuildContext context) {
    var widgetList = [];
    List<Question> question = widget.question;
    List<Answer> userAnswers = widget.userAnswers;
    widgetList.add(Text(question[0].question));
    List<String> questionAnswers = [
      question[0].ans_1,
      question[0].ans_2,
      question[0].ans_3,
      question[0].ans_4
    ];
    questionAnswers.shuffle();
    List<String> finalAnswers = [question[0].correctAnswer];

    for (var item in userAnswers) {
      finalAnswers.add(item.playerAnswer);
    }

    for (var item in questionAnswers) {
      if (finalAnswers.length <= 4) {
        finalAnswers.add(item);
      } else {
        break;
      }
    }
    finalAnswers.shuffle();

    for (var item in finalAnswers) {
      widgetList.add(ElevatedButton(
        onPressed: () {
          setState(() {
            _showAnswer = !_showAnswer;
            if (question[0].correctAnswer == item) {
              // User correct wins
              for (var lobby in widget.lobbyPlayers) {
                if (lobby.player == globals.userId) {
                  updateLobbyPoints(lobby.id, lobby.points + 100);
                }
              }
              _pointsWon = '100 pts won';
            } else {
              for (var answers in userAnswers) {
                if (answers.playerAnswer == item) {
                  // User answer wins
                  for (var lobby in widget.lobbyPlayers) {
                    if (lobby.player == answers.player) {
                      updateLobbyPoints(lobby.id, lobby.points + 150);
                    }
                  }
                  _pointsWon = 'Player id ${answers.player} wins 150 points';
                  break;
                }
              }
              _pointsWon = 'No points won';
            }
          });
          resetGame(widget.gameId).then((value) => {});
        },
        child: Text(item),
      ));
    }

    widgetList.add(Column(
      children: <Widget>[
        Visibility(
            visible: _showAnswer,
            child: Column(
              children: [
                Text('Correct Answer: ${question[0].correctAnswer}'),
                Text('Points: $_pointsWon'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: const Text('Back to lobby'),
                ),
              ],
            ))
      ],
    ));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[for (var item in widgetList) item],
    );
  }
}
