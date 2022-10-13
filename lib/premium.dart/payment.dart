import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
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
                            "Let's Get Premium",
                            style: NeumorphicStyle(color: Colors.grey[700]),
                            textStyle: NeumorphicTextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Pacifico"),
                          ),
                          SizedBox(
                            height: size.height / 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 21),
                                child: Text(
                                  "Follow the steps to get the premium",
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 21),
                                ),
                              ),
                            ],
                          ),

                          //Step-1
                          SizedBox(
                            height: size.height / 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width / 30,
                              ),
                              NeumorphicText(
                                "Step - 1",
                                style: NeumorphicStyle(color: Colors.grey[700]),
                                textStyle: NeumorphicTextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Pacifico"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height / 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width / 30,
                              ),
                              SizedBox(
                                width: size.width / 1.05,
                                child: Text(
                                  "Make the payment of ₹49 to the number given below via Paytm or Google Pay. To copy the number, click on it.",
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          infoBox(size, "+919718389309", 2.7),

                          //Step-2
                          SizedBox(
                            height: size.height / 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width / 30,
                              ),
                              NeumorphicText(
                                "Step - 2",
                                style: NeumorphicStyle(color: Colors.grey[700]),
                                textStyle: NeumorphicTextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Pacifico"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height / 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width / 30,
                              ),
                              SizedBox(
                                width: size.width / 1.05,
                                child: Text(
                                  "Email the screenshot from the id you have logged in with to email below, which is the bennett id of Shashwat Singh.",
                                  maxLines: 5,
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          infoBox(size, "E21CSEU0577@bennett.edu.in", 1.5),

                          //Step-3
                          SizedBox(
                            height: size.height / 60,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width / 30,
                              ),
                              NeumorphicText(
                                "Step - 3",
                                style: NeumorphicStyle(color: Colors.grey[700]),
                                textStyle: NeumorphicTextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Pacifico"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height / 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width / 30,
                              ),
                              SizedBox(
                                width: size.width / 1.05,
                                child: Text(
                                  "Just wait for a few hours. Your premium will be activated in less than 6 hours. If you are paying the morning, chance of premium getting activated faster are more than at night after 11 p.m.",
                                  maxLines: 5,
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height / 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget infoBox(Size size, String text, double width) {
    return Padding(
      padding: const EdgeInsets.only(top: 21),
      child: GestureDetector(
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: text))
              .then((value) => snackBar(context));
        },
        child: Container(
          height: size.height / 15,
          width: size.width / width,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Colors.grey[300],
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
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  void snackBar(BuildContext context) {
    var snackbar = SnackBar(
      content: Text(
        "Copied",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 15),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.white,
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 150),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
