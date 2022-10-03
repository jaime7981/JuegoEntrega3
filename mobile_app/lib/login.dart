import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/* 
// Async functions
Future<void> loadData() async {
  var dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  http.Response response = await http.get(dataURL);
  setState(() {
    widgets = jsonDecode(response.body);
  });
}

// Send Post Request
Future<http.Response> createUser(String username, String password, String confirmation) {
  static const _baseUrl = 'http://127.0.0.1:8000';
  return http.post(
    Uri.parse('$_baseUrl/usercontrol/players/'),
    headers: <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password1' : password,
      'password2' : confirmation,
    }),
  );
}

class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}
*/

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  //static const String _title = 'Flutter Code Sample';
  static const String _title = 'Login Page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const LoginWidget(),
      ),
    );
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          TextFormField(
            controller: passwordController,
            obscureText: _isObscure,
            decoration: InputDecoration(
                labelText: 'Password',
                // this button is used to toggle the password visibility
                suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    })),
          ),
          ElevatedButton(
            onPressed: () {
              // Validate will return true if the form is valid, or false if
              // the form is invalid.
              if (_formKey.currentState!.validate()) {
                // Process data.
                var data = {
                  'username': usernameController.text,
                  'password': passwordController.text
                };
                debugPrint('form data: $data');
                login(usernameController.text, passwordController.text);
              }
            },
            child: const Text('Login'),
          ),
          ElevatedButton(
            onPressed: () {
              // Change to register View
              Navigator.of(context, rootNavigator: true).pushNamed("/register");
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}

// API requests
Future<http.Response> createPlayer(
    String username, String password, String confirmation) async {
  const baseUrl = 'http://0.0.0.0:8000';

  final response = await http.post(
    Uri.parse('$baseUrl/usercontrol/players/'),
    headers: <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password1': password,
      'password2': confirmation,
    }),
  );

  if (response.statusCode == 200) {
    debugPrint(jsonDecode(response.body));
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to create Player.');
  }
}

/*
var response = await post(Uri.parse(url),
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: {
      'username': username,
      'password': password,
    },
    encoding: Encoding.getByName("utf-8"));
*/

Future<http.Response> login(String username, String password) async {
  const baseUrl = 'http://192.168.0.187:8000';

  final response = await http.post(
    Uri.parse('$baseUrl/usercontrol/api-token-auth/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    var token = jsonDecode(response.body)['token'].toString();
    debugPrint(token);
    return response;
  } else {
    throw Exception('Failed to login.');
  }
}
