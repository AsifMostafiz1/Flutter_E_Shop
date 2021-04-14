import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'login.dart';
import 'register.dart';
import 'package:e_shop/Config/config.dart';

import 'register.dart';


class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent,Colors.lightBlueAccent]
                )
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text(
                "E-Shop",style: TextStyle(fontSize: 40,fontFamily: "Signatra"),
              ),
            ),
            centerTitle: true,

            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.lock),text: "Login",),
                Tab(icon: Icon(Icons.person),text: "Register",),
              ],
              indicatorColor: Colors.white,
              indicatorWeight: 3,
            ),

          ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),

            child: TabBarView(
              children: [
                Login(),
                Register()
              ],
            ),
          ),
        ));
  }
}
