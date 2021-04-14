

import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/addAddress.dart';
import 'package:e_shop/Store/Search.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
              Container(
                padding: EdgeInsets.only(top: 20,bottom: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent,Colors.lightBlueAccent]
                  )
                ),
                child: Column(
                  children: [
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(80)),
                      elevation: 8,
                      child: Container(
                        height: 160,
                        width: 160,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl
                              )
                          ),

                        )
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),style: TextStyle(fontSize: 30,fontFamily: "Signatra",color: Colors.white),)
                  ],
                ),
              ),

          Column(
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              Divider(height: 2,color: Colors.grey,),

              ListTile(
                leading: Icon(Icons.home),
                title: Text("My order"),
                onTap: (){
                  Route route = MaterialPageRoute(builder: (e)=>MyOrders());
                  Navigator.pushReplacement(context, route);
                },
              ),
              Divider(height: 2,color: Colors.grey,),


              ListTile(
                leading: Icon(Icons.home),
                title: Text("My Cart"),
                onTap: (){
                  Route route = MaterialPageRoute(builder: (e)=>CartPage());
                  Navigator.pushReplacement(context, route);
                },
              ),
              Divider(height: 2,color: Colors.grey,),


              ListTile(
                leading: Icon(Icons.home),
                title: Text("Search"),
                onTap: (){
                  Route route = MaterialPageRoute(builder: (e)=>SearchProduct());
                  Navigator.pushReplacement(context, route);
                },
              ),
              Divider(height: 2,color: Colors.grey,),

              ListTile(
                leading: Icon(Icons.home),
                title: Text("Add New Address"),
                onTap: (){
                  Route route = MaterialPageRoute(builder: (e)=>AddAddress());
                  Navigator.pushReplacement(context, route);
                },
              ),
              Divider(height: 2,color: Colors.grey,),

              ListTile(
                leading: Icon(Icons.home),
                title: Text("Logout"),
                onTap: (){
                  _auth.signOut().then((value){
                    Route route = MaterialPageRoute(builder: (e)=>AuthenticScreen());
                    Navigator.pushReplacement(context, route);
                  });

                },
              ),
              Divider(height: 2,color: Colors.grey,)
            ],
          )


        ],

      ),
    );
  }
}
