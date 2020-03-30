import 'package:flash_chat/screens/Timeline.dart';
import 'package:flash_chat/screens/comment.dart';
import 'package:flash_chat/screens/home.dart';
import 'package:flash_chat/screens/sync.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';



void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        AddDataToFireStore.id: (context) => AddDataToFireStore(),
        NewTimeline.id: (context) => NewTimeline(),
        CommentSection.id: (context) => CommentSection(),
      },
    );
  }
}
