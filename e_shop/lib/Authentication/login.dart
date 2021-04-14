import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminLogin.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}





class _LoginState extends State<Login>
{
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/login.png",height: 240,width: 240,),
            Form(
              key: _formKey,
              child: Column(
                children: [
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

                  SizedBox(height: 40,),

                  Container(
                    width: 150,
                    height: 50,
                    child: RaisedButton(onPressed: (){
                      _emailTextController.text.isNotEmpty &&
                          _passwordTextController.text.isNotEmpty
                            ? loginUser()
                              : showDialog(
                                context: context,
                                builder: (e){
                                  return ErrorAlertDialog(message: "Enter email and Password",);
                                });
                    },
                      color: Colors.blue,
                      child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),),
                  ),
                  SizedBox(height: 40,),

                  Container(
                    height: 4,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue,
                  ),

                  FlatButton.icon(
                      onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminSignInPage())),
                      icon: Icon(Icons.admin_panel_settings_outlined,color: Colors.blue,),
                      label: Text("Admin Login"))

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
  FirebaseAuth _auth = FirebaseAuth.instance;
  void loginUser() async
  {
    showDialog(
        context: context,
        builder:(e){
          return LoadingAlertDialog(message: "Authenticating..Please wait..",);
        });
    FirebaseUser firebaseUser;
    
    await _auth.signInWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim()
    ).then((auth) {
      firebaseUser =auth.user;

    }).catchError((error){
      showDialog(
          context: context,
          builder: (e)
            {
              return ErrorAlertDialog(message: error.toString(),);
            }
            );
    });




    if(firebaseUser!=null)
      {
        readData(firebaseUser).then((s){
          Navigator.pop(context);
          Route route = MaterialPageRoute(builder: (e)=>StoreHome());
          Navigator.pushReplacement(context, route);
        });

      }

  }
  Future readData(FirebaseUser fuser) async{
      Firestore.instance.collection("users").document(fuser.uid).get().then((datasnapshot) async {
        await EcommerceApp.sharedPreferences.setString("uid", datasnapshot.data[EcommerceApp.userUID]);
        await EcommerceApp.sharedPreferences.setString(EcommerceApp.userEmail,datasnapshot.data[EcommerceApp.userEmail]);
        await EcommerceApp.sharedPreferences.setString(EcommerceApp.userName, datasnapshot.data[EcommerceApp.userName]);
        await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl, datasnapshot.data[EcommerceApp.userAvatarUrl]);

        List<String> cartList = datasnapshot.data[EcommerceApp.userCartList].cast<String>();
        await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList,cartList);

      });
  }
}
