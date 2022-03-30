import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatefulWidget {

  static String id = "/chat";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  String messageText;
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore _cloud = FirebaseFirestore.instance;


  void getCurrentUser() async {

    var currentUser = _auth.currentUser;

    //tries to tap into the current user
    try {
      print(currentUser);
    }
    catch(e) {
      print(e);
    }

  }

  void getMessages() async {

    await for (var snapshot in _cloud.collection('messages').snapshots()) {

      for (var message in snapshot.docs) {

        print(message.data());

      }

    }

  }


  void messagesStream() async {

    //Loop to find all the documents in the collection
    await for (var snapshot in _cloud.collection('messages').snapshots() )
    {
      //  For loop to retrieve dat from snap shot
      for (var messages in snapshot.docs) {
        print(messages.data());
      }

    }
  }


@override
  void initState() {
    // TODO: implement initState
  // messagesStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var sender = _auth.currentUser.email;
    List<Padding> messagesListWidgets = [];


    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality

                _auth.signOut();
                Navigator.pop(context);

                // getMessages();

              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            StreamBuilder <QuerySnapshot> (
              stream: _cloud.collection('messages').snapshots(),
              builder: (context, snapshot){

                if (snapshot.hasData) {



                  for (DocumentSnapshot mess in snapshot.data.docs){
                    // final messageText = mess.data['text'];
                    final messageSender = mess.get('sender');
                    final messageText = mess.get('text');



                    final messageWidget = Padding(padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Text("this message, $messageText was sent by $messageSender",
                      style: TextStyle(
                      ),
                    ),);
                    messagesListWidgets.add(messageWidget);

                  }


                }
                return Column(
                    children: messagesListWidgets,

                );
              },
            ),

            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[



                  // StreamBuilder <QuerySnapshot> (
                  //   stream: _cloud.collection('messages').snapshots(),
                  //   builder: (context, snapshot){
                  //     if (snapshot.hasData) {
                  //       final  messages = snapshot.data.docs;
                  //       List<Text> messagesWidgets = [];
                  //       for (var mess in messages){
                  //         final messageText = mess;
                  //         print(mess);
                  //       }
                  //
                  //
                  //     }
                  //
                  //     return Column();
                  //   },
                  // ),


                  // TextField to enter your message



                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Does something with the user input.
                        messageText = value;


                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.

                      print("we outside");

                      _cloud.collection('messages').add({'text' : messageText,

                        'sender' : sender});



                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
