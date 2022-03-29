import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {

  static String id = "/registration";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool _saving = false;

  @override
  void initState()  {
     // startFirebase();

    super.initState();
  }

  // void startFirebase() async {
  //   await Firebase.initializeApp();
  //   print("Firebase was init properly");
  // }






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

            //Logo Assets
            Container(
              height: 200.0,
              child: Image.asset('images/logo.png'),
            ),


            //Visual Spacer
            SizedBox(
              height: 48.0,
            ),


            //Email Text Field
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
                //Do something with the user input.
              },
              decoration:kInputTextField.copyWith(hintText: "Enter your email"),
            ),


            //Visual Spacer
            SizedBox(
              height: 8.0,
            ),


            //Password Text Field
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
                password = value;
              },
              decoration: kInputTextField.copyWith(hintText: "Enter your password"),
            ),


            //Visual Spacer
            SizedBox(
              height: 24.0,
            ),

            //Sign up button
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () async{
                    //Implement registration functionality.
                    print(email);

                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      if (newUser != null){
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    }
                    catch(e) {
                      print("We couldn't save it boss");
                      print(e);
                    }

                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
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
