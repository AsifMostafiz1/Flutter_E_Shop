import 'package:flutter/material.dart';
import 'package:flutter_instragram/widgets/HeaderWidget.dart';
import 'package:flutter_instragram/widgets/ProgressWidget.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn gSignIn = GoogleSignIn();
class TimeLinePage extends StatefulWidget {
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  signout()
  {
    gSignIn.signOut();
  }
  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context,isAppTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      //circularProgress(),
       linearProgress(),
       TextButton(onPressed: signout, child: Text("SingOut"))

    ],
    )

    );
  }
}
