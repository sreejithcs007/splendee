import 'dart:async';


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/imageconstants.dart';
import '../bottomnav/view/bottomnav.dart';
import '../login/view/login.dart';
import 'introduction_screen.dart';


class Splashscreen extends StatefulWidget{
  const Splashscreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashscreenState();
}

class SplashscreenState extends State<Splashscreen> {
  late SharedPreferences p ;
  @override
  void initState() {

   Timer(const Duration(seconds: 5), () {
     check();
    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> OnboardingScreen()), (route) => false);
   });
    super.initState();
  }

  Future<void> check()async {
    p = await SharedPreferences.getInstance();

    var loggedin = p .getBool("loggedin");

    var seenintro = p.getBool('seenonboarding');
    var nme = p.getString('usernames');

    if(seenintro == true && loggedin == true){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNav(nme)));
    }
    else if(seenintro == true){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));

    }
    else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const OnboardingScreen()));
    }




  }
  @override
  Widget build(BuildContext context) {
   return Scaffold (
     backgroundColor:  Color(0xFF135D66),
     body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Container(
             height: MediaQuery.of(context).size.height*0.2,
             width: MediaQuery.of(context).size.width*0.4,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(10)
             ),

               child: Image(image: AssetImage(ImageConstants.splashimage),)),
           Text("Splendee",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)
       
         ],
       ),
     ),
   );
  }

}