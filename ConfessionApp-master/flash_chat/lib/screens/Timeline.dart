import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/comment.dart';
import 'package:flash_chat/screens/sync.dart';
import 'package:flutter/material.dart';

// class AddDataToFireStore extends StatefulWidget {
//   @override
//   _AddDataToFireStoreState createState() => _AddDataToFireStoreState();
// }

// class _AddDataToFireStoreState extends State<AddDataToFireStore> {
//   ScrollController controller;
  
//   @override
  
//   void initState() {
//     super.initState();
//     controller = new ScrollController()..addListener(_scrollListener);
//   }

//   @override
//   void dispose() {
//     controller.removeListener(_scrollListener);
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text('row $index'),);
//   },
//   );
//   }
// void _scrollListener() {
//     print(controller.position.extentAfter);
//     if (controller.position.extentAfter < 500) {
//       setState(() {
//         .addAll(new List.generate(42, (index) => 'Inserted $index'));
//       });
//     }
//   }
// }

// class AddDataToFireStore extends StatelessWidget {
//   static String id  = 'Timeline_screen';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Post on Timeline'),),
//       body: ListView.builder(itemBuilder: (context,index){
//         return ListTile(title: Text('row $index'),);
//       }),
      
//     );
//   }
// }


class AddDataToFireStore extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  final db = Firestore.instance;
  //DocumentReference docRef;
  static String id  ='time' ;
  //String email;
  String postId;
  var post;
  @override
  Widget build(BuildContext context) {
    final  Map<String, Object>rcvdData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("Post on Timeline")),
      body: ListView(
        padding: EdgeInsets.all(12.0),
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
                await db.collection('info').document(rcvdData['email']).setData({'title': _controller.text ,'date': DateTime.now().toString(),'count': 0});
                Navigator.pushNamed(context, NewTimeline.id,arguments: {'email': rcvdData['email']});
                // postId = docRef.documentID;
                // print('$postId');
                // post = db.collection('info').document(postId).get();
                // print(post);
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
      //     StreamBuilder<QuerySnapshot>(
      //         stream: db.collection('info').orderBy('date',descending: false).snapshots(),
      //         builder: (context, snapshot) {
      //           if (snapshot.hasData) {
      //             return Column(
      //               children: snapshot.data.documents.map((doc) {
      //                 return CustomWidget(
      //                   content: Text(doc.data['title']),
      //                   date: DateTime.now().toString(),
      //                   trailingIconOne: new Icon(Icons.share, color: Colors.blueAccent,),
      //                   trailingIconTwo: new Icon(Icons.favorite, color: Colors.redAccent,),
                        
      //                   );
      //               }).toList(),
      //             );
      //           } else {
      //             return SizedBox();
      //           }
      //         }),
      //   ],
      // ),
      ]
    ));
  }
}

class CustomWidget extends StatelessWidget {
  String date;
  Text content;
  int index;
  Icon trailingIconOne;

  Icon trailingIconTwo;

 // List <bool> _liked;

  CustomWidget(
      {@required this.date, @required this.content, @required this.trailingIconOne, @required this.trailingIconTwo, int index});

  //get db => null;
  final db1 = Firestore.instance;
  //final ref = db1.collection('info');
//   void incrementCounter(int num) async {
//     Firestore.instance.
//             collection('info').
//             document('your_document').
//             updateData(<String, dynamic> {
//       'count': FieldValue.increment(num),
//     });
// }

  @override
  Widget build(BuildContext context){
    final  Map<String, Object>rcvdData = ModalRoute.of(context).settings.arguments;
    return new Card(
      child: new Column(
        children: <Widget>[
          new Column (children: <Widget>[
            new Container (child: new Text(date), color: Colors.yellow[200],),
            new Container(height: 15.0,),
            new Text('$content'),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new IconButton(icon: trailingIconOne, onPressed: (){
                  Navigator.pushNamed(context, CommentSection.id,arguments: {'email': rcvdData['email']});
                  
                }),
                new Container(width: 10.0,),
                new IconButton(icon: trailingIconTwo,onPressed: (){
                  // setState(){
                  // _liked[index] = true;
                  // }
                }
                )
          ], ),

            //  new Divider(height: 15.0,color: Colors.red,),
            ],
          )
        ],
      ),
    );
  }
}