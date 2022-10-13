import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:promnight/premium.dart/payment.dart';

class PremiumInfo extends StatefulWidget {
  const PremiumInfo({Key? key}) : super(key: key);

  @override
  State<PremiumInfo> createState() => _PremiumInfoState();
}

class _PremiumInfoState extends State<PremiumInfo> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
                opacity: 0.6)),
        child: Column(
          children: [
            SizedBox(
              height: size.height / 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width / 50,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey[700],
                    )),
              ],
            ),
            SizedBox(
              height: size.height / 1.15,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  NeumorphicText(
                    "What comes in Premium?",
                    style: NeumorphicStyle(color: Colors.grey[700]),
                    textStyle: NeumorphicTextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Pacifico"),
                  ),
                  getnow(size),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 21),
                    child: Text(
                      "1. Select the gender you want to see the profiles of.",
                      style: TextStyle(color: Colors.grey[800], fontSize: 21),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 60,
                  ),
                  Center(
                    child: Container(
                      height: size.height / 3,
                      width: size.width / 1.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: AssetImage("assets/gender.png"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 21, top: 15),
                    child: Text(
                      "2. View the profiles of all the male or female users using the app.",
                      style: TextStyle(color: Colors.grey[800], fontSize: 21),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 60,
                  ),
                  Center(
                    child: Container(
                      height: size.height / 1.8,
                      width: size.width / 1.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              image: AssetImage("assets/profiles.png"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 150,
                  ),
                  getnow(size),
                  SizedBox(
                    height: size.height / 60,
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    ));
  }

  Widget getnow(Size size) {
    return Padding(
      padding: const EdgeInsets.only(top: 21),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Payment()));
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
              color: Colors.grey[900],
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
              "Get Now",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
