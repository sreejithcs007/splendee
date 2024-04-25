
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/imageconstants.dart';
import '../login/view/login.dart';



class  OnboardingScreen extends StatefulWidget{
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  late SharedPreferences pref;
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(

          image: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SizedBox(
                height: MediaQuery.of(context).size.height/2,
                width: double.infinity,
                child: Image(image: AssetImage(ImageConstants.introfirst),fit: BoxFit.contain,)),
          ),
       titleWidget: const Padding(
         padding: EdgeInsets.only(top: 30.0),
         child: Text("ALL YOUR EXPENSE FINANCE IN ONE PLACE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),textAlign: TextAlign.center),
       ),
          bodyWidget: const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text("See the bigger picture by having all your finance in one place",style: TextStyle(color: Colors.grey,fontSize: 20),textAlign: TextAlign.center,),
          ),



        ),

        PageViewModel(
            image: Image(image: AssetImage(ImageConstants.introtrack)),
            titleWidget: const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text("TRACK YOUR SPENDING",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),textAlign: TextAlign.center),
            ),
            bodyWidget: const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text("Keep track of your expenses manually",style: TextStyle(color: Colors.grey,fontSize: 20),textAlign: TextAlign.center,),
            )


        ),

        PageViewModel(
            image: Image(image: AssetImage(ImageConstants.introknow)),
            titleWidget: const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text("KNOW WHERE YOUR MONEY GOES",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),textAlign: TextAlign.center),
            ),
            bodyWidget: const Padding(
              padding: EdgeInsets.only(top: 30.0),
              child: Text("You can now track your income and expenses",style: TextStyle(color: Colors.grey,fontSize: 20),textAlign: TextAlign.center,),
            )
        ),

      ],

      onDone: ()async{
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool('seenonboarding', true);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
      },
      onSkip: ()async{
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool('seenonboarding', true);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);

      },
      dotsDecorator: const DotsDecorator(activeColor: Colors.black,color: Colors.grey),
      done: const Text("Get Started",style: TextStyle(color: Colors.green,fontSize: 15),),
      next: const Text("NEXT",style: TextStyle(color: Colors.green,fontSize: 15),),
      skip: const Text("Skip",style: TextStyle(color: Colors.grey,fontSize: 15),),
      showSkipButton: true,


    );
  }
}