import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:gowild/HomeScreen.dart';
// import 'dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var pass = '';
    return FlutterLogin(
      // title: 'GoWild',
      logo: const AssetImage('assets/images/logo.png'),
      onLogin: (loginData) {
        // save user entered password in pass variable
        // pass = loginData.password;
        print('button pressed');
        print(loginData.name);
        print(pass); // add this line to print the pass variable
        return Future(() => null);
      },
      onSignup: (_) => Future(() => null),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      },
      onRecoverPassword: (_) => Future(() => null),
      messages: LoginMessages(
        userHint: 'User',
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

  DashboardScreen() {}
}
