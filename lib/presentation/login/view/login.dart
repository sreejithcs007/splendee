
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/color_constants.dart';
import '../../bottomnav/view/bottomnav.dart';
import '../../globalWidgets/reusable_textfield.dart';
import '../../registration/view/registration.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var user = TextEditingController();
  var passw = TextEditingController();
  bool showpass = true;
  late bool loggedin;

  late SharedPreferences preff;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: ColorConstants.Greenhead,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .26,
                    left: MediaQuery.of(context).size.width * 0.4),
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                      color: ColorConstants.mainWhite,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.35,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04,
                            left: MediaQuery.of(context).size.width * 0.02,
                            right: MediaQuery.of(context).size.width * 0.02,
                          ),
                          child: ReusableTextField(
                            controller: user,
                            name: "Username",
                            hinttext: "Enter your username",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.width * 0.02,
                            right: MediaQuery.of(context).size.width * 0.02,
                          ),
                          child: ReusableTextField(
                            controller: passw,
                            name: "Password",
                            hinttext: "Enter your password",
                            obsecuringtext: showpass,
                            suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (showpass == false) {
                                      showpass = true;
                                    } else {
                                      showpass = false;
                                    }
                                  });
                                },
                                icon: Icon(showpass == true
                                    ? Icons.visibility_off
                                    : Icons.visibility)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.width * 0.02,
                            right: MediaQuery.of(context).size.width * 0.02,
                          ),
                          child: MaterialButton(
                            color: ColorConstants.Greenhead,
                            shape: const StadiumBorder(),
                            onPressed: () {
                              getdata(user.text, passw.text);
                            },
                            child: const Text(
                              "Login ",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                            },
                            child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                        color:ColorConstants.mainBlack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    children: [
                                  TextSpan(text: "Don't have an account ? "),
                                  TextSpan(
                                      text: "Register",
                                      style:
                                          TextStyle(color: ColorConstants.Greenhead))
                                ])))
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void getdata(String usernm, String pssw) async {
    preff = await SharedPreferences.getInstance();

    var getuser = preff.getString('usernames');
    var getpass = preff.getString('passwords');

    if (usernm == getuser && pssw == getpass) {
      preff.setBool('loggedin', true);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Successfully logged in"),
          backgroundColor: ColorConstants.Greenhead));
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNav(getuser)),
          (route) => false);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Incorrect username or password"),backgroundColor: ColorConstants.Greenhead,));
    }
  }
}
