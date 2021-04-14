import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/searchBox.dart';
import '../Models/item.dart';

double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent,Colors.lightBlueAccent]
                )
              ),
            ),
            title: Text("E-Shop",style: TextStyle(fontSize: 40,fontFamily: "Signatra"),),
            centerTitle: true,
            actions: [
              Stack(
                children: [
                  IconButton(
                      icon: Icon(Icons.card_travel_sharp,color: Colors.white,), onPressed: (){
                        Route route = MaterialPageRoute(builder:(c)=>CartPage());
                        Navigator.pushReplacement(context, route);
                  }),
                  Positioned(
                    //top:2, left: 4,
                      child: Stack(
                        children: [
                          Icon(Icons.brightness_1,size: 20,),
                          Positioned(
                            top: 3, bottom: 4,
                              child: Consumer<CartItemCounter>(builder: (context,counter,_){
                                return Text(counter.count.toString(),style: TextStyle(color: Colors.pinkAccent),);
                              })
                          )
                        ],
                      )
                  ),
                ],
              )
            ],
          ),

        drawer: MyDrawer(),
      ),
    );
  }
}



Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell();
}



Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container();
}



void checkItemInCart(String productID, BuildContext context)
{
}
