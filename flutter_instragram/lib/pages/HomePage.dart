import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instragram/models/user.dart';
import 'package:flutter_instragram/pages/CreateAccountPage.dart';
import 'package:flutter_instragram/pages/NotificationsPage.dart';
import 'package:flutter_instragram/pages/ProfilePage.dart';
import 'package:flutter_instragram/pages/SearchPage.dart';
import 'package:flutter_instragram/pages/TimeLinePage.dart';
import 'package:flutter_instragram/pages/UploadPage.dart';
import 'package:google_sign_in/google_sign_in.dart';




final userReference = Firestore.instance.collection("users");
final GoogleSignIn gSignIn = GoogleSignIn();


final DateTime timestamp = DateTime.now();
User currentUser;




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSigned = false;
  PageController  pageController;
  int currentIndex =0;


  void initState()
  {
    super.initState();

    pageController = PageController();

    gSignIn.onCurrentUserChanged.listen((event) {
      controlSignInAccount(event);
    },onError: (error){
        print("Error: "+error);
    });

    gSignIn.signInSilently(suppressErrors: false).then((value){
      controlSignInAccount(value);
    }).catchError((onError){
      print("Error"+onError);
    });
  }

controlSignInAccount(GoogleSignInAccount signInAccount) async
{

  if(signInAccount!=null)
    {
      await saveUserInfoToFireStore();
      setState(() {
        isSigned = true;
      });
    }

  else{
    setState(() {
      isSigned = false;
    });
  }
}
  saveUserInfoToFireStore() async{


   final GoogleSignInAccount gCurrentUser = gSignIn.currentUser;

   var currentUserId = gCurrentUser.email;

   final userName = await Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccountPage()));



   print(currentUserId);

    // if(!documentSnapshot.exists)
    //   {
    //     final userName = await Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateAccountPage()));
    //
    //     userReference.document(gCurrentUser.id).setData({
    //       "id": gCurrentUser.id,
    //       "profileName": gCurrentUser.displayName,
    //       "username": userName,
    //       "url": gCurrentUser.photoUrl,
    //       "email": gCurrentUser.email,
    //       "bio":"",
    //       "timestamp": timestamp,
    //     });
    //     documentSnapshot = await userReference.document(gCurrentUser.id).get();
    //   }
    // currentUser = User.fromDocument(documentSnapshot);

  }
void Dispose()
{
  pageController.dispose();
  super.dispose();
}

  signIn(){
    gSignIn.signIn();
  }

  signOutUser()
  {
    gSignIn.signOut();
  }

  changedPageBottomView(int pageIndex){
    setState(() {
      this.currentIndex = pageIndex;
    });
  }
  onTapPageChange(int pageIndex)
  {
    pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 400), curve: Curves.bounceInOut);
  }

  Widget buildHomeScreen(){
    return Scaffold(
      body: PageView(
        children: [
          TimeLinePage(),
          SearchPage(),
          UploadPage(),
          NotificationsPage(),
          ProfilePage(),
        ],
        controller: pageController,
        onPageChanged: changedPageBottomView,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: currentIndex,
        onTap: onTapPageChange,
        activeColor: Colors.purpleAccent,
        inactiveColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ],
      ),
    );
  }
  Scaffold buildSignInScreen(){
    return Scaffold(
      backgroundColor: Colors.pink[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Instragram",style: TextStyle(fontSize: 60,fontFamily: "Signatra",color: Colors.white),),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: signIn,
                child: Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/google_signin_button.png"),
                      fit: BoxFit.cover

                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    if(isSigned)
      {
        return buildHomeScreen();
      }
    else{
      return buildSignInScreen();
    }

  }
}
