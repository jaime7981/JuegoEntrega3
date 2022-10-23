import 'package:flutter/material.dart';
import '../api/login_api.dart';
import 'background.dart';
import 'package:mobile_app/responsive.dart';
import 'components/image_register.dart';
import 'components/account_text.dart';
import '../globals_vars.dart';
import 'login.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  static const String _title = 'Register Page';

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileRegisterScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: RegisterWidget(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: RegisterWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}

class MobileRegisterScreen extends StatelessWidget {
  const MobileRegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const RegisterScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: RegisterWidget(),
            ),
            Spacer(),
          ],
        ),
      ],
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
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
          ),),
          TextFormField(
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
          const Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "register_btn",
            child: ElevatedButton(
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
                          confirmationController.text)
                      .then((value) =>
                          {Navigator.of(context, rootNavigator: true).pop()});
                } else {
                  debugPrint('password dont matches');
                }
              }
            },
            child: const Text('Register'),
            ),
            
                            
            ),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginView();
                  },
                )
              );
            }
          )
                     


        ],
      ),
    );
  }
}
