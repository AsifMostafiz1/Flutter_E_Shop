
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:flutter/material.dart';




class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      ),
      body: AdminSignInScreen(),

    );
  }
}


class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen>
{

  final TextEditingController _adminPasswordTextController = TextEditingController();
  final TextEditingController _adminIdTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Image.asset("images/admin.png",height: 240,width: 240,),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Text("Admin",style: TextStyle(fontSize: 30),),
                  CustomTextField(
                    controller: _adminIdTextController,
                    data: Icons.email,
                    hintText: " Id",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _adminPasswordTextController,
                    hintText: " Password",
                    data: Icons.lock,
                    isObsecure: true,
                  ),

                  SizedBox(height: 40,),

                  Container(
                    width: 150,
                    height: 50,
                    child: RaisedButton(onPressed: (){
                      _adminIdTextController.text.isNotEmpty &&
                          _adminPasswordTextController.text.isNotEmpty
                          ? loginAdmin()
                          : showDialog(
                          context: context,
                          builder: (e){
                            return ErrorAlertDialog(message: "Enter email and Password",);
                          });
                    },
                      color: Colors.blue,
                      child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),),
                  ),
                  SizedBox(height: 100,),

                  Container(
                    height: 4,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue,
                  ),


                ],
              ),
            ),

            FlatButton.icon(

                onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>AuthenticScreen())),
                icon: Icon(Icons.admin_panel_settings_outlined,color: Colors.blue,),
                label: Text("Not admin? Go Back",))


          ],
        ),
      ),
    );
  }

  loginAdmin(){
      Firestore.instance.collection("admins").getDocuments().then((snapshot){
        snapshot.documents.forEach((result) { 
          if(result.data['id']!=_adminIdTextController.text.trim())
            {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Id is incorrect")));
            }

          else if(result.data['password']!=_adminPasswordTextController.text.trim())
          {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Password is incorrect")));
          }
          else
            {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text("Welcome "+result.data['name'])));

              setState(() {
                _adminIdTextController.text ="";
                _adminPasswordTextController.text="";
              });

              Route route = MaterialPageRoute(builder: (e)=> UploadPage());
              Navigator.pushReplacement(context, route);

            }
        });
      });
  }
}
