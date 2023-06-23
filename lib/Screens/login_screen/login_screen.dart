// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:gowild/Screens/login_screen/login_screen_model.dart';
import 'package:gowild/Screens/registartion_screen/test_upload.dart';
import 'package:gowild/routes/routes.dart';
import '../../backend/api_requests/registration_screen_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _password;
  late String _email;
  bool _isLoading = false;

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    print('login pressed email' + _email + '.' + _password);
    final userLogin = UserLogin(
      email: _email,
      password: _password,
    );
    try {
      final loginData = await Api.loginUser(userLogin);
      if (loginData['success'] == 1) {
        Navigator.pushReplacementNamed(context, '/feed');
        // ignore: use_build_context_synchronously
        // if (loginData['role'] == 'admin') {
        //   // ignore: use_build_context_synchronously
        //   Navigator.pushReplacementNamed(context, '/admin_dashboard');
        // }
        // if (loginData['role'] == 'user') {
        //   // ignore: use_build_context_synchronously
        //   Navigator.pushReplacementNamed(context, '/feed');
        // }
        // if (loginData['role'] == 'serviceProvider') {
        //   // ignore: use_build_context_synchronously
        //   Navigator.pushReplacementNamed(context, '/feed');
        // }
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/');
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid Username or Password'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to log the user'),
        ),
      );
      Navigator.pushNamed(context, '/');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterLogin(
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
            _email = loginData.name;
            _password = loginData.password;
            return Future(() => null);
          },
          onSignup: (signupData) async {
            final emailAvailabilityResponse =
                await Api.checkEmailAvaialability(signupData.name);
            if (emailAvailabilityResponse == 'Email already exists') {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Email already exists'),
                ),
              );
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, '/');
            }
            if (emailAvailabilityResponse == 'Email is available') {
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, AppRoutes.registration, arguments: {
                'name': signupData.name,
                'password': signupData.password
              });
            }
            return null;
          },
          onSubmitAnimationCompleted: () async {
            _login();
          },
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
        ),
        if (_isLoading)
          Container(
            color: Color.fromARGB(255, 3, 3, 3).withOpacity(0.9),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    'Signin You in!',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
