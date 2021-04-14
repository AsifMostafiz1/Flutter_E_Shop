import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_instragram/widgets/HeaderWidget.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _scaffold = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();
  String userName;


  submitUsername()
  {
      final form = _formkey.currentState;
      if(form.validate())
        {
          form.save();

          SnackBar snackBar = SnackBar(content: Text("Welcome "+userName));
          _scaffold.currentState.showSnackBar(snackBar);
          Timer(Duration(seconds: 4), (){
            Navigator.pop(context,userName);
          });
        }
  }


  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffold,
      appBar: header(context,strTitle: "Settings",disableBackButton: true),

      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 30.0),
                        child: Center(
                          child: Text("Set UserName",style: TextStyle(fontSize: 26.0),),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Form(
                      key: _formkey,
                      autovalidate: true,
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        validator: (val){
                          if(val.trim().length<5 || val.isEmpty)
                            {
                              return "User name is Too Short";
                            }
                          else if(val.trim().length>15){
                            return "User name is very long";
                          }
                          else{
                            return null;
                          }
                        },
                        onSaved: (val) => userName = val,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black
                            ),
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Username",
                          labelStyle: TextStyle(fontSize: 16.0),
                          hintText: "Username at least 5 character",
                          hintStyle: TextStyle(color: Colors.grey),

                        ),
                      ),

                    ),

                  ),
                ),
                GestureDetector(
                  onTap: submitUsername,
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.purple
                    ),

                    child: Center(
                      child: Text("Processed",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
