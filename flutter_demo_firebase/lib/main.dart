import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}



class HomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HomePage> {
  Future getData() async
  {
    var fireStore = Firestore.instance;
    QuerySnapshot qn = await fireStore.collection("Countries").getDocuments();
    return qn.documents;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getData(),
          builder: (_,snapshot){
              return ListView.builder(
                //itemCount: snapshot.data.lenght,
                  itemBuilder: (_,index){
                    DocumentSnapshot data = snapshot.data[index];
                    return Card(
                        child: ListTile(
                          title: Text("data.toString()"),
                        ),
                    );

                  });
          },
        ),
    );
  }
}
