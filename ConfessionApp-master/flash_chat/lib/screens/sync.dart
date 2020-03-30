import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/screens/Timeline.dart';
import 'package:flutter/material.dart';
 Firestore firestore = Firestore.instance;  
class NewTimeline extends StatefulWidget {
  static String id  = 'Timeline_screen';
  @override
  _NewTimelineState createState() => _NewTimelineState();
}

class _NewTimelineState extends State<NewTimeline> {
  List<DocumentSnapshot> products = []; // stores fetched products  
  
bool isLoading = false; // track if products fetching  
  
bool hasMore = true; // flag for more products available or not  
//List <bool> _liked = false as List<bool>;
int documentLimit = 10; // documents to be fetched per request  
  
DocumentSnapshot lastDocument; // flag for last document from where next 10 records to be fetched  
  
ScrollController _scrollController = ScrollController(); 
@override

void initState() {
    super.initState();
    getProducts();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.20;
      if (maxScroll - currentScroll <= delta) {
        getProducts();
      }
    });
}

getProducts() async {  
   if (!hasMore) {  
     print('No More Products');  
     return;  
   }  
   if (isLoading) {  
     return;  
   }  
   setState(() {  
     isLoading = true;  
   });  
   QuerySnapshot querySnapshot;  
   if (lastDocument == null) {  
     querySnapshot = await firestore  
         .collection('info')  
         .orderBy('title')  
         .limit(documentLimit)  
         .getDocuments();  
   } else {  
     querySnapshot = await firestore  
         .collection('info')  
         .orderBy('title')  
         .startAfterDocument(lastDocument)  
         .limit(documentLimit)  
         .getDocuments();  
     print(1);  
   }  
   if (querySnapshot.documents.length < documentLimit) {  
     hasMore = false;  
   }  
   lastDocument = querySnapshot.documents[querySnapshot.documents.length-1];  
   products.addAll(querySnapshot.documents);  
   setState(() {  
     isLoading = false;  
   });   
 }   

  @override
   Widget build(BuildContext context) {  
   return Scaffold(  
     appBar: AppBar(  
       title: Text('Your TimeLine'),  
     ),  
     body: Column(children: [  
       Expanded(  
         child: products.length == 0  
             ? Center(  
                 child: Text('No Posts Yet'),  
               )  
             : ListView.builder(  
                 controller: _scrollController,  
                 itemCount: products.length,  
                 itemBuilder: (context, index) {  
                   return CustomWidget(  
                     //contentPadding: EdgeInsets.all(5),  
                     content: Text(products[index].data['title']),  
                     trailingIconOne: new Icon(Icons.share, color: Colors.blueAccent,),
                     trailingIconTwo: new Icon(Icons.favorite, color: Colors.grey,),
                      //  new IconButton(
                      //   icon: Icon(liked ? Icons.favorite : Icons.favorite_border, color: liked ? Colors.redAccent : Colors.grey ,),
                      //    onPressed: () {
                      //      setState(() {
                      //        liked = !liked;
                      //      });
                      //   },),
                      date: DateTime.now().toString(),
                      index: index, 
                     //subtitle: Text(products[index].data['short_desc']),  
                   );  
                 },  
               ),  
       ),  
       isLoading  
           ? Container(  
               //width: MediaQuery.of(context).size.width,  
               //padding: EdgeInsets.all(5),  
               //color: Colors.yellowAccent,  
               alignment:Alignment.center,child: CircularProgressIndicator(),)
               //child: CircularProgressIndicator(),
              //  child: Text(  
              //    'Loading',  
              //    textAlign: TextAlign.center,  
              //    style: TextStyle(  
              //      fontWeight: FontWeight.bold,  
              //    ),  
              //  ),  
              
           : Container()  
     ]),  
   );  
 }  
}

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  bool liked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}