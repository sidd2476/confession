import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/Timeline.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/sync.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/RoundedButtons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  Firestore firestore = Firestore.instance;
  String groupName;
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
//    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
    Future.delayed(
      Duration(seconds: 1),
      () async {
          final sharePrefsInstance = await SharedPreferences.getInstance();

          final email = sharePrefsInstance.getString("email");
          final password  =  sharePrefsInstance.getString("password");

          if( email != null && password != null) {
             // navigate to your other screen since the user is authenticated
             Navigator.pushNamed(context, AddDataToFireStore.id,arguments:{ 'email': email});
          }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Row(
                children: <Widget>[
                  Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                  Expanded(
                    flex: 5,
                    child: TypewriterAnimatedTextKit(
                      text: ['Flash Chat'],
                      textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
                color: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                text: 'Log In'),
            RoundedButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                text: 'Register'),
            TextField(
              onChanged: (value){
                setState(() {
                  groupName = value;
                });
              },
            ),
          ],
        ),
      ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () async{
// //            firestore.collection('$groupName').add({
// //              'text': groupName
// //            });
//           DocumentSnapshot snapshot = await firestore.collection('messages').document('sid').get();
//           },
//         ),
    );
  }
}
