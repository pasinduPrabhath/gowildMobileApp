import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:gowild/routes/routes.dart';
// import 'registration_screen.dart';
// import 'dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var pass = '';
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
        print('pressed');
        print(loginData.name);
        print(pass); // add this line to print the pass variable
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
        Navigator.pushNamed(context, AppRoutes.homeScreen);
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
