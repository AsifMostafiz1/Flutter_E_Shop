import 'package:flutter/material.dart';

AppBar header(context,{ bool isAppTitle= false,String strTitle,disableBackButton = false}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    automaticallyImplyLeading: disableBackButton? false : true,
    title: Text(
      isAppTitle? "Instragram" : strTitle,
          style: TextStyle(
              color: Colors.white,
            fontFamily: isAppTitle? "Signatra": "",
            fontSize: isAppTitle ? 40 : 25
    ),
    ),
    centerTitle: true,
    backgroundColor: Colors.purple,

  );
}
