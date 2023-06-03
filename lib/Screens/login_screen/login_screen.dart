import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:gowild/Screens/login_screen/login_screen_model.dart';
import 'package:gowild/routes/routes.dart';

import '../../backend/api_requests/registration_screen_api.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _password;
  late String _email;

  void _login() async {
    print('login pressed email' + _email + '.' + _password);
    final userLogin = UserLogin(
      email: _email,
      password: _password,
    );
    try {
      final loginId = await Api.loginUser(userLogin);
      if (loginId == 1) {
        Navigator.pushReplacementNamed(context, '/homeScreen');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to log the user'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      theme: LoginTheme(
        primaryColor: Theme.of(context).colorScheme.primary,
        // pageColorDark: Theme.of(context).colorScheme.background,
        cardTheme: CardTheme(
          color: const Color.fromARGB(255, 255, 255, 255),
          elevation: 15,
          margin: const EdgeInsets.only(top: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      logo: const AssetImage('assets/images/logo.png'),
      onLogin: (loginData) {
        // save user entered password in pass variable
        // pass = loginData.password;
        _email = loginData.name;
        _password = loginData.password;
        // print('pressed');
        print(loginData.name);

        print('pw is ' + _email);
        // print(pass); // add this line to print the pass variable
        return Future(() => null);
      },

      onSignup: (signupData) {
        Navigator.pushNamed(context, AppRoutes.registration, arguments: {
          'name': signupData.name,
          'password': signupData.password
        });
        print(signupData.name);
        print(signupData.password);
        // print(signupData.confirmPassword);
        return null;
        // return Future(() => null);
      },
      onSubmitAnimationCompleted: () {
        _login();
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const HomeScreen()));
      },
      // },

      onRecoverPassword: (_) => Future(() => null),
      messages: LoginMessages(
        userHint: 'Email',
        passwordHint: 'Pass',
        confirmPasswordHint: 'Confirm',
        loginButton: 'LOG IN',
        signupButton: 'REGISTER',
        forgotPasswordButton: 'Forgot huh?',
        recoverPasswordButton: 'HELP ME',
        goBackButton: 'GO BACK',
        confirmPasswordError: 'Not match!',
        recoverPasswordDescription:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
    );
  }
}
