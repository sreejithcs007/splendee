import 'package:flutter/material.dart';

class ReusableAlertBox  {
  final String title;
  ReusableAlertBox({required this.title});
   showMyDialog(context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            actions: [
              MaterialButton(onPressed: (){
                Navigator.pop(context);
              },child: Text("Yes"),),
              MaterialButton(onPressed: (){
                Navigator.pop(context);
              },child: Text("No"),)
            ],
          );
    }
    );
  }


}

