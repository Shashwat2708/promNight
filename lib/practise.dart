import 'package:email_auth/email_auth.dart';
import 'package:promnight/methods/firebasemethods.dart';
import 'package:promnight/screens/dashboard.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LogInPrac extends StatefulWidget {
  const LogInPrac({Key? key}) : super(key: key);

  @override
  State<LogInPrac> createState() => _LogInPracState();
}

class _LogInPracState extends State<LogInPrac> {
  bool showPass = true;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isLoading = false;
  String errorText = "";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(children: [
                SizedBox(
                  height: size.height / 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios))
                  ],
                ),
                SizedBox(
                  height: size.height / 15,
                ),
                NeumorphicIcon(
                  CupertinoIcons.heart_fill,
                  size: 140,
                  style: NeumorphicStyle(
                    //depth: 12,
                    color: Colors.red[600], //customize color here
                  ),
                ),
              ]),
              SizedBox(
                height: size.height / 35,
              ),
              Container(
                height: size.height / 1.5,
                color: Colors.grey[100],
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 21),
                        child: Text(
                          "Welcome Back",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 21, top: 6),
                        child: Text(
                          "Let's Sign in     ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 30,
                      ),
                      customField(size, false, "Email", email),
                      SizedBox(
                        height: size.height / 35,
                      ),
                      customField(size, showPass, "Password", pass),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width / 15,
                            ),
                            showPass
                                ? Icon(Icons.remove_red_eye_outlined,
                                    color: Colors.grey[700])
                                : Icon(Icons.remove_red_eye,
                                    color: Colors.grey[700]),
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: Text(
                                "Show Password",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height / 20,
                      ),
                      Center(
                        child: Text(
                          errorText,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              sendOTP();
                              if (email.text.isNotEmpty &&
                                  pass.text.isNotEmpty) {
                                try {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  loginUser(email.text, pass.text)
                                      .then((value) async {
                                    if (value != null) {
                                      // Navigator.pushReplacement(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const Dashboard()));
                                      // await FirebaseAnalytics.instance
                                      //     .logEvent(name: "UserLoggedIn");
                                    } else {
                                      setState(() {
                                        errorText = "Invalid Credentials";
                                      });
                                      print("User not found");
                                      sendOTP();
                                    }
                                  });
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            child: Container(
                              height: size.height / 15,
                              width: size.width / 3,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                  color: Colors.red[600],
                                  boxShadow: [
                                    //Bottom right shadow will be darker
                                    BoxShadow(
                                        color: Colors.grey.shade600,
                                        offset: const Offset(4, 4),
                                        blurRadius: 21,
                                        spreadRadius: 3),

                                    //top left shadow will be lighter
                                    const BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(-4, -4),
                                        blurRadius: 15,
                                        spreadRadius: 1)
                                  ]),
                              child: Center(
                                child: isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendOTP() async {
    EmailAuth helper = EmailAuth(sessionName: "Test Session");
    var res = await helper.sendOtp(recipientMail: email.text);
    if (res) {
      print("Otp Sent");
    } else {
      print("Not sent");
    }
  }

  Widget customField(
      Size size, bool val, String text, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width / 1.1,
          height: size.height / 14,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Colors.grey[100],
              boxShadow: [
                //Bottom right shadow will be darker
                BoxShadow(
                    color: Colors.grey.shade600,
                    offset: const Offset(4, 4),
                    blurRadius: 21,
                    spreadRadius: 3),

                //top left shadow will be lighter
                const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4, -4),
                    blurRadius: 15,
                    spreadRadius: 1)
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 8),
            child: TextFormField(
              onChanged: (value) {},
              controller: controller,
              obscureText: val,
              style: const TextStyle(color: Colors.black),
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                isCollapsed: false,
                fillColor: Colors.grey,
                hintText: text,
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget hearts(double size) {
    return NeumorphicIcon(
      CupertinoIcons.heart_fill,
      size: size,
      style: NeumorphicStyle(
        color: Colors.grey[300],
        depth: 7,
      ),
    );
  }
}
