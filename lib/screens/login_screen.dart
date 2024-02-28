import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool loadingIndicator = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loadingIndicator,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                  enabledBorder: kEnabledOutlineInputBorder,
                  focusedBorder: kFocusedOutlineInputBorder,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                  enabledBorder: kEnabledOutlineInputBorder,
                  focusedBorder: kFocusedOutlineInputBorder,
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  title: 'Log In',
                  onPressedFunction: () async {
                    setState(() {
                      loadingIndicator = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                        email: email,
                        password: password,
                      );

                      // Check if the user exists
                      if (user != null) {
                        // Navigate to the ChatScreen upon successful login
                        Navigator.pushNamed(context, ChatScreen.id);
                      } else {
                        // Handle the case when user is null
                        print('User is null');
                      }

                      // Reset loading state
                      setState(() {
                        loadingIndicator = false;
                      });
                    } catch (e) {
                      // Catch and print any errors that occur during authentication
                      print('Error during sign in: $e');
                      print('An error occurred. Please try again.');

                      // Reset loading state
                      setState(() {
                        loadingIndicator = false;
                      });
                    }
                  },
                  colour: Colors.lightBlueAccent,
                  heroTag: 'loginButton'),
            ],
          ),
        ),
      ),
    );
  }
}
