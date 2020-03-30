import 'package:flash_chat/screens/Timeline.dart';
import 'package:flash_chat/screens/sync.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/RoundedButtons.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flash_chat/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  String EMAIL_VALUE,_PASSWORD_VALUE;
  bool _showSpinner = false;
  void _persistUserInfo() async {
  final sharePrefsInstance = await SharedPreferences.getInstance();

  sharePrefsInstance .setString("email", EMAIL_VALUE);
  sharePrefsInstance .setString("password", _PASSWORD_VALUE);

}
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 3),
      () async {
          final sharePrefsInstance = await SharedPreferences.getInstance();

          final email = sharePrefsInstance.getString("email");
          final password  =  sharePrefsInstance.getString("password");

          if( email != null && password != null) {
             // navigate to your other screen since the user is authenticated
             Navigator.pushNamed(context, NewTimeline.id);
          }
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 190.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  EMAIL_VALUE = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter Your E-mail',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  _PASSWORD_VALUE = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter Your Password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),

              RoundedButton(
                  color: Colors.blueAccent, onPressed: () async {
                    setState(() {
                      _showSpinner = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: EMAIL_VALUE, password: _PASSWORD_VALUE);
                      if(newUser != null){
                        Navigator.pushNamed(context, NewTimeline.id);
                        setState(() {
                          this._persistUserInfo();
                          _showSpinner = false;
                        });
                      }
                    }
                    catch(e){
                      print(e);
                    }
              }, text: 'Register'),
            ],
          ),
        ),
      ),
    );
  }
}
