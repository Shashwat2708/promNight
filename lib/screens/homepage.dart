import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:promnight/screens/ads.dart';
import 'package:promnight/screens/onprocessing.dart';
import 'package:promnight/screens/onprocessing/inthedb.dart';
import 'package:promnight/screens/onprocessing/matchfound.dart';
import 'package:promnight/screens/onprocessing/searchingdb.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  late bool boxActivated;
  late String ignorableUid;
  int type = 0;
  bool ads = false;
  bool isLoaded = false;
  late final Map<String, dynamic>? otheruserMap;
  Map<String, dynamic>? adsuserMap = {};
  Random random = Random();

  //Once the user has clicked on the box, it notifies the user if their data is being recorded or not.
  // bool queryProcessing = false;

  //This is to check if the gender of the user is recieved and the data is stored in database or not?
  bool dataFetched = false;

  late String matchedwith;
  late String currentchatroomid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    typeSearch();
    isBoxActivated();
    analytics.logEvent(name: 'HomePage');
  }

  void isBoxActivated() {
    _firestore
        .collection("constants")
        .doc("IhVXFO9IsYW30imDWVpd")
        .get()
        .then((value) {
      setState(() {
        boxActivated = value.data()!["boxactivate"];
        ignorableUid = value.data()!["ignorableUid"];
        ads = value.data()!["ads"];

        print(ads);
      });
      if (ads = true) {
        _firestore
            .collection("ads")
            .doc("hHyS5C2A4cmzyi6MD7dH")
            .get()
            .then((value) async {
          if (value.data()!["count"] == 0) {
            setState(() {
              isLoaded = true;
            });
          } else if (value.data()!["count"] == 1) {
            _firestore
                .collection("ads")
                .doc("hHyS5C2A4cmzyi6MD7dH")
                .collection("group1")
                .where("groupNum", isEqualTo: 1)
                .get()
                .then((newValue) {
              setState(() {
                adsuserMap = newValue.docs[0].data();
                isLoaded = true;
                print(adsuserMap!["ad1Link"]);
              });
            });
          } else {
            int adCount = 1 + random.nextInt(value.data()!["count"] - 1);

            _firestore
                .collection("ads")
                .doc("hHyS5C2A4cmzyi6MD7dH")
                .collection("group1")
                .where("groupNum", isEqualTo: adCount)
                .get()
                .then((newValue) {
              setState(() {
                adsuserMap = newValue.docs[0].data();
                isLoaded = true;
              });
            });
          }
        });
      } else {
        setState(() {
          isLoaded = true;
        });
      }
    });
  }

  void typeSearch() {
    //This function is to find what user has selected and if they are available.
    _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        type = value.data()!["type"];
      });
      if (type == 3) {
        _firestore
            .collection("users")
            .doc(value.data()!["matchedwith"])
            .get()
            .then((newvalue) {
          setState(() {
            otheruserMap = newvalue.data();
            dataFetched = true;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoaded
          ? Stack(children: [
              Container(
                height: size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.cover,
                        opacity: 0.6)),
              ),
              SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.height / 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: size.width / 10,
                          ),
                          NeumorphicText(
                            "promNight",
                            style: NeumorphicStyle(color: Colors.grey[700]),
                            textStyle: NeumorphicTextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Pacifico"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height / 50,
                      ),
                      // ads
                      //     ? AdsDisplay(
                      //         adsuserMap: adsuserMap,
                      //         ads: ads,
                      //       )
                      //     : const SizedBox(),
                      SizedBox(
                        height: size.height / 20,
                      ),
                      boxActivated
                          ? type == 2
                              ? const InTheDB()
                              : type == 3
                                  ? dataFetched
                                      ? MatchFound(
                                          userMap: otheruserMap,
                                        )
                                      : const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        )
                                  : Center(
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (type == 0) {
                                            await analytics.logEvent(
                                                name: 'findingMatch');

                                            if (!mounted) return;
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SearchingDB()));
                                          }
                                        },
                                        child: Container(
                                          width: size.width / 1.2,
                                          decoration: BoxDecoration(
                                              // image: const DecorationImage(
                                              //   image: AssetImage('assets/wallpaper.png'),
                                              //   fit: BoxFit.cover,
                                              // ),
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              boxShadow: const [
                                                //Bottom right shadow will be darker
                                                BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 186, 186, 186),
                                                    offset: Offset(0, 0),
                                                    blurRadius: 6,
                                                    spreadRadius: 3),
                                              ]),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, left: 8),
                                                child: Text(
                                                  "Find your match now",
                                                  style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.grey[700],
                                                    // shadows: <Shadow>[
                                                    //   Shadow(
                                                    //     offset: Offset(1.0, 3.0),
                                                    //     blurRadius: 6.0,
                                                    //     color: Color.fromARGB(255, 114, 114, 114),
                                                    //   ),
                                                    //   // Shadow(
                                                    //   //   offset: Offset(10.0, 10.0),
                                                    //   //   blurRadius: 8.0,
                                                    //   //   color: Color.fromARGB(125, 0, 0, 255),
                                                    //   // ),
                                                    // ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Column(
                                                children: [
                                                  Center(
                                                    child: SizedBox(
                                                      height: size.height / 3,
                                                      child: const Image(
                                                        image: AssetImage(
                                                            "assets/boxActivated.png"),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8),
                                                    child: Text(
                                                      "Tap the box to find your match",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey[700],
                                                        // shadows: <Shadow>[
                                                        //   Shadow(
                                                        //     offset: Offset(1.0, 1.0),
                                                        //     blurRadius: 6.0,
                                                        //     color: Color.fromARGB(255, 114, 114, 114),
                                                        //   )
                                                        //]
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: size.height / 90),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                          : Center(
                              child: GestureDetector(
                                onTap: () async {
                                  //This is not the activated box.
                                  await analytics.logEvent(
                                      name: 'peopleTrying');
                                },
                                child: Container(
                                  width: size.width / 1.2,
                                  decoration: BoxDecoration(
                                      // image: const DecorationImage(
                                      //   image: AssetImage('assets/wallpaper.png'),
                                      //   fit: BoxFit.cover,
                                      // ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: const [
                                        //Bottom right shadow will be darker
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                255, 186, 186, 186),
                                            offset: Offset(0, 0),
                                            blurRadius: 6,
                                            spreadRadius: 3),
                                      ]),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, left: 8),
                                        child: Text(
                                          "Find your match now",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[700],
                                            // shadows: <Shadow>[
                                            //   Shadow(
                                            //     offset: Offset(1.0, 3.0),
                                            //     blurRadius: 6.0,
                                            //     color: Color.fromARGB(255, 114, 114, 114),
                                            //   ),
                                            //   // Shadow(
                                            //   //   offset: Offset(10.0, 10.0),
                                            //   //   blurRadius: 8.0,
                                            //   //   color: Color.fromARGB(125, 0, 0, 255),
                                            //   // ),
                                            // ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        children: [
                                          Center(
                                            child: SizedBox(
                                              height: size.height / 3,
                                              child: const Image(
                                                image: AssetImage(
                                                    "assets/box.png"),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: Text(
                                              "Box is not active yet.",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey[700],
                                                // shadows: <Shadow>[
                                                //   Shadow(
                                                //     offset: Offset(1.0, 1.0),
                                                //     blurRadius: 6.0,
                                                //     color: Color.fromARGB(255, 114, 114, 114),
                                                //   )
                                                //]
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: size.height / 90),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: size.height / 90),
                    ]),
              ),
            ])
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            ),
    );
  }
}
