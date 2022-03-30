import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {

  static String id = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String _user;
  String _password;
  bool _saving = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Logo Asset
            Container(
              height: 200.0,
              child: Image.asset('images/logo.png'),
            ),

            //Visual Spacer
            SizedBox(
              height: 48.0,
            ),

            //Username Text Field
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Does something with the user input.
                _user = value;
              },
              decoration: kInputTextField.copyWith(hintText: "Enter your email"),
            ),

            //Visual Spacer
            SizedBox(
              height: 8.0,
            ),

            //Password Text Field
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                //Does something with the user input.
                _password = value;
              },
              decoration: kInputTextField.copyWith(hintText: "Enter your password"),
            ),

            //Visual Spacer
            SizedBox(
              height: 24.0,
            ),

            //Login Button
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async {
                    //Implement login functionality.

                    try {
                      await _auth.signInWithEmailAndPassword(email: _user, password: _password);
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    catch(e) {
                      print(e);
                      print('Trouble signing in');
                    }

                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
