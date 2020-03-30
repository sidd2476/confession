import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final List<Widget> lst = [];
  void addlst(){
    for(var i=0;i<5;i++){
      lst.add(Text('Hello-$i'));
    }
  }
  @override
  Widget build(BuildContext context) {
    addlst();
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: <Widget>[
            for (int i=0;i<5;i++) lst[i],
          ],
        ),
      ),
    );
  }
}
