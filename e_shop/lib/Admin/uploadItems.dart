import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;


class UploadPage extends StatefulWidget
{
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage>
{
  bool get wantKeepAlive => true;
  File file;

  @override
  Widget build(BuildContext context) {
    return displayAdminHomeScreen();
  }
  displayAdminHomeScreen()
  {
    return Scaffold(
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

        leading: IconButton(
            icon: Icon(Icons.border_color,color: Colors.white,),
            onPressed: (){
              Route route = MaterialPageRoute(builder: (e)=> AdminShiftOrders());
              Navigator.pushReplacement(context, route);
            }),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.pop(context);
                Route route = MaterialPageRoute(builder: (e)=>SplashScreen());
                Navigator.pushReplacement(context, route);
              },
              child: Text("Logout",style: TextStyle(color: Colors.white),))
        ],
      ),

      body: getAdminHomeScreenBody(),
    );
  }

  getAdminHomeScreenBody()
  {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shop_two_rounded,color: Colors.blue,size: 200,),
            RaisedButton(
              color: Colors.blue,
                child: Text("Add New item",style: TextStyle(color: Colors.white),),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onPressed:(){
                        takeImage(context);
            }),
          ],
        ),
      ),
    );
  }
  takeImage(mContext)
  {
    showDialog(
        context: mContext,
        builder: (con){
            return SimpleDialog(
              title: Padding(
                padding: const EdgeInsets.only(bottom:15.0),
                child: Text("Select Image From",style: TextStyle(fontSize: 25,color: Colors.blue),),
              ),

              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom:10.0),
                  child: SimpleDialogOption(
                    child: Text("Open Camera",style: TextStyle(fontSize: 16,color: Colors.blue),),
                    onPressed:captureImageFormCamera,
                  ),
                ),
                SimpleDialogOption(
                  child: Text("Open Gallery",style: TextStyle(fontSize: 16,color: Colors.blue),),
                  onPressed: selectImageFormGallery,

                ),

                Center(
                  child: SimpleDialogOption(
                    child: Padding(
                      padding: const EdgeInsets.only(left:50.0),
                      child: Text("cancel",style: TextStyle(fontSize: 16,color: Colors.blue),),
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },

                  ),
                ),
              ],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.grey.shade200,

            );
        });
  }
  captureImageFormCamera() async{
    Navigator.pop(context);

    File imageFile =await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 680,maxWidth:970 );


      setState(() {
        file = imageFile;
      });
  }

  selectImageFormGallery()async{
    Navigator.pop(context);

    File imageFile =await ImagePicker.pickImage(source: ImageSource.gallery,maxHeight: 680,maxWidth:970 );


    setState(() {
      file = imageFile;
    });
  }

}
