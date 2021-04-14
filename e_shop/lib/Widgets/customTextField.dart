import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget
{
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsecure = true;



  CustomTextField(
      {Key key, this.controller, this.data, this.hintText,this.isObsecure}
      ) : super(key: key);



  @override
  Widget build(BuildContext context)
  {
    return Container
    (
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(width: 1,color: Colors.blueAccent),
        color: Colors.white
      ),

      margin: EdgeInsets.only(left: 30,top: 10,right: 30),
      child: TextFormField(
        controller: controller,
        obscureText: isObsecure,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          focusColor: Theme.of(context).accentColor,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Icon(
              data,
              color: Colors.blue,
            ),
          )
        ),
      ),
    );
  }
}
