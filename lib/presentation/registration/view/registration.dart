import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/color_constants.dart';
import '../../globalWidgets/reusable_textfield.dart';
import '../../login/view/login.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var usercont = TextEditingController();

  var passcont = TextEditingController();

  var pass1;

  late SharedPreferences prefs;

  var usernameformkey = GlobalKey<FormState>();

  var passformkey = GlobalKey<FormState>();

  var confpassformkey = GlobalKey<FormState>();

  bool showpass = true;
  bool showpass1 = true;

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
                    left: MediaQuery.of(context).size.width * 0.28),
                child: const Text(
                  "REGISTRATION",
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
                            formkey: usernameformkey,
                            name: "Username",
                            hinttext: "Enter your username",
                            controller: usercont,
                            validator: (user) {
                              if (user!.isEmpty) {
                                return "This field is required";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.width * 0.02,
                            right: MediaQuery.of(context).size.width * 0.02,
                          ),
                          child: ReusableTextField(
                            formkey: passformkey,
                            name: "Password",
                            hinttext: "Enter your password",
                            controller: passcont,
                            validator: (pass) {
                              pass1 = pass;
                              if (pass!.isEmpty) {
                                return "This field is required";
                              } else if (pass.length < 5) {
                                return "Atleast 5 character must be present";
                              }
                              return null;
                            },
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
                          child: ReusableTextField(
                            name: "Confirm Password",
                            hinttext: "Re-Enter your password",
                            formkey: confpassformkey,
                            validator: (confpass) {
                              if (pass1 != confpass) {
                                return "Password is not same";
                              }
                              return null;
                            },
                            obsecuringtext: showpass1,
                            suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (showpass1 == false) {
                                      showpass1 = true;
                                    } else {
                                      showpass1 = false;
                                    }
                                  });
                                },
                                icon: Icon(showpass1 == true
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
                              if (usernameformkey.currentState!.validate() &&
                                  passformkey.currentState!.validate() &&
                                  confpassformkey.currentState!.validate()) {
                                storedata(usercont.text, passcont.text);

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                    (route) => false);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                    "Registration Successful",
                                  ),
                                  backgroundColor: ColorConstants.Greenhead,
                                ));
                              } else if (usernameformkey.currentState!
                                      .validate() ==
                                  false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Username must be provided "),
                                        backgroundColor:
                                            ColorConstants.Greenhead));
                              } else if (passformkey.currentState!.validate() ||
                                  confpassformkey.currentState!.validate() ==
                                      false) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Check your password"),
                                  backgroundColor: ColorConstants.Greenhead,
                                ));
                              }
                            },
                            child: const Text(
                              "Register ",
                              style: TextStyle(
                                  color: ColorConstants.mainWhite,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            },
                            child: RichText(
                                text: const TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                    children: [
                                  TextSpan(text: "Already have an account ? "),
                                  TextSpan(
                                      text: "Log In",
                                      style: TextStyle(
                                          color: ColorConstants.Greenhead))
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

  void storedata(String uusername, String passwordd) async {
    prefs = await SharedPreferences.getInstance();

    var userr = await prefs.setString('usernames', uusername);
    var psw = await prefs.setString('passwords', passwordd);
    var log = await prefs.setBool('loggedin', false);
  }
}
