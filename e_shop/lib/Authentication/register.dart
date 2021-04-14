import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';

import '../Widgets/customTextField.dart';



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}



class _RegisterState extends State<Register>
{
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _cPasswordTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String userImageUrl ="";
  File _imageFile;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 15),
            InkWell(
              onTap: selectAndPickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.black26,
                backgroundImage: _imageFile==null?null: FileImage(_imageFile),
                child: _imageFile==null? Icon(Icons.add_photo_alternate_outlined,size: 60,color: Colors.blueAccent,) : null
              ),
              ),
            SizedBox(height: 8),

            Form(
              key: _formKey,
              child: Column(
                children: [
                        CustomTextField(
                          controller: _nameTextController,
                          data: Icons.person,
                          hintText: " Enter Name",
                          isObsecure: false,
                        ),
                  CustomTextField(
                    controller: _emailTextController,
                    data: Icons.email,
                    hintText: " Enter Email",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextController,
                    hintText: " Enter Password",
                    data: Icons.lock,
                    isObsecure: true,
                  ),
                  CustomTextField(
                    controller: _cPasswordTextController,
                    hintText: " Confirm Password",
                    data: Icons.lock,
                    isObsecure: true,
                  ),
                  SizedBox(height: 40,),

                Container(
                  width: 250,
                  child: RaisedButton(onPressed: (){uploadAndSaveImage();},
                  color: Colors.blue,
                  child: Text("Saved"),),
                )

                ],
              ),
            )
          ],
        ),
      ),
    );
    
  }

 Future<void> selectAndPickImage() async
  {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }
  Future<void> uploadAndSaveImage() async
  {
    if(_imageFile==null)
      {
        showDialog(
            context: context,
            builder: (c){
                  return ErrorAlertDialog(message: "Please Select an image file",);
            });
      }
    else{
      _passwordTextController.text==_cPasswordTextController.text
          ? _nameTextController.text.isNotEmpty && _emailTextController.text.isNotEmpty
              && _passwordTextController.text.isNotEmpty && _cPasswordTextController.text.isNotEmpty
                  ? uploadToStorage() : displayDialogue("Please Fill All The information")
          : displayDialogue("Password Doesn't Match");
    }
  }

  displayDialogue(String msg){
    showDialog(
        context: context,
        builder:(c){
          return ErrorAlertDialog(message: msg,);
        });
  }

  uploadToStorage() async
  {
      showDialog(
          context: context,
          builder: (c)
          {
            return LoadingAlertDialog(message: "'Authenticating, Please wait.....",);
          });

      String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();

      StorageReference storageReference = FirebaseStorage.instance.ref().child(imageFileName);

      StorageUploadTask storageUploadTask = storageReference.putFile(_imageFile);

      StorageTaskSnapshot taskSnapshot =  await storageUploadTask.onComplete;

      await taskSnapshot.ref.getDownloadURL().then((url){
        userImageUrl=url;
        _registerUser();
      });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async{

    FirebaseUser firebaseUser;

    await _auth.createUserWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim()
        ).then((auth){
          firebaseUser = auth.user;
        }).catchError((error){
          Navigator.pop(context);

          showDialog(
              context: context,
              builder:(c){
                return ErrorAlertDialog(message: error.toString(),);
              });
    });

    if (firebaseUser!=null)
      {
        saveUserInformationToFireStore(firebaseUser).then((value){
          Navigator.pop(context);
          Route route = MaterialPageRoute(builder: (c)=> StoreHome());
          Navigator.pushReplacement(context, route);
        });
      }
  }
  Future saveUserInformationToFireStore(FirebaseUser firebaseUser) async
  {
    Firestore.instance.collection("users").document(firebaseUser.uid).setData({
      "uid": firebaseUser.uid,
      "email": firebaseUser.email,
      "name": _nameTextController.text.trim(),
      "url": userImageUrl,
      EcommerceApp.userCartList: ["garbageValue"]
    });
    await EcommerceApp.sharedPreferences.setString("uid", firebaseUser.uid);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userEmail, firebaseUser.email);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userName, _nameTextController.text.trim());
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl, userImageUrl);
    await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, ["garbageValue"]);
  }
}

