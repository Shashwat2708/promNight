import 'package:promnight/screens/auth/login/login.dart';
import 'package:promnight/screens/auth/registration/basicinfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(children: [
        Container(
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover,
                  opacity: 0.6)),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(
                //   width: size.width / 20,
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: NeumorphicIcon(
                    CupertinoIcons.heart_fill,
                    size: size.height / 7,
                    style: NeumorphicStyle(
                      //depth: 12,
                      color: Colors.red[600], //customize color here
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // NeumorphicIcon(
                //   CupertinoIcons.heart_fill,
                //   size: size.height / 20,
                //   style: NeumorphicStyle(
                //     //depth: 12,
                //     color: Colors.red[600], //customize color here
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: NeumorphicText("promNight",
                      style: NeumorphicStyle(color: Colors.grey[700], depth: 7),
                      textStyle: NeumorphicTextStyle(
                          fontSize: size.height / 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Pacifico")),
                ),
                NeumorphicIcon(
                  CupertinoIcons.heart_fill,
                  size: size.height / 10,
                  style: NeumorphicStyle(
                    //depth: 12,
                    color: Colors.red[600], //customize color here
                  ),
                ),
                SizedBox(
                  width: size.width / 20,
                ),
              ],
            ),
            SizedBox(
              height: size.height / 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BasicInfo()));
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
                child: const Center(
                  child: Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            Text(
              "or",
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LogIn()));
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
                child: const Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 7,
            ),
            Text(
              "A Shashwat Singh Production",
              style: TextStyle(color: Colors.grey[500], fontSize: 15),
            )
          ],
        ),
      ]),
    );
  }
}
