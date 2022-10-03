import 'package:flutter/material.dart';
import '../api/login_api.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  static const String _title = 'Register Page';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const RegisterWidget(),
      ),
    );
  }
}

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmationController = TextEditingController();

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
                return 'Please enter a username';
              }
              return null;
            },
          ),
          TextField(
            controller: passwordController,
            obscureText: _isObscure,
            decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    })),
          ),
          TextField(
            controller: confirmationController,
            obscureText: _isObscure,
            decoration: InputDecoration(
                labelText: 'Confirmation',
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
              if (_formKey.currentState!.validate()) {
                // Validate if passwords matches
                var data = {
                  'username': usernameController.text,
                  'password': passwordController.text,
                  'confirmation': confirmationController.text
                };
                debugPrint('form data: $data');
                if (passwordController.text == confirmationController.text) {
                  debugPrint('password matches');
                  createPlayer(usernameController.text, passwordController.text,
                      confirmationController.text);
                } else {
                  debugPrint('password dont matches');
                }
              }
            },
            child: const Text('Register'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/");
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
