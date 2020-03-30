

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentSection extends StatelessWidget {
  static String id = 'COmment_cec';
  TextEditingController _controller = TextEditingController();
  final database = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    final  Map<String, Object>rcvdData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      bottomNavigationBar: Padding(padding: MediaQuery.of(context).viewInsets,
  child: ListView(
    padding: EdgeInsets.all(20.0),
    children: <Widget>[
      Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Who\'s on your mind'),
            ),
            ),
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Add'),
              color: Colors.blueAccent,
              onPressed: () async {
                // DocumentReference ref =
                await database.collection('info').document(rcvdData['email']).collection('comme').add({'comments': _controller.text ,'date': DateTime.now().toString(),'count': 0});
                // postId = docRef.documentID;
                // print('$postId');
                // post = db.collection('info').document(postId).get();
                // print(post);
              },
            ),
          ),
    ], 
      
    ),
  ),
    
      
    );
  }
}
