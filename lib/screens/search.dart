import 'package:promnight/premium.dart/allusersdisplay.dart';
import 'package:promnight/premium.dart/premiuminfo.dart';
import 'package:promnight/screens/profiles/onsearchprofile.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  bool isLoading = false;
  Map<String, dynamic>? userMap;
  String currentUserEmail = "";
  String searchtext = "Search User";
  bool premium = false;
  var gender = ["Male", "Female"];
  String genderVal = "Male";

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _search.dispose();
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _firestore
        .collection("users")
        .where("uid", isEqualTo: _auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        currentUserEmail = value.docs[0].data()['email'];
        premium = value.docs[0].data()['premium'];
      });
    });
  }

  nullChecker(String photoUrl) {
    try {
      return NetworkImage(photoUrl);
    } catch (e) {
      return const AssetImage("assets/main.png");
    }
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    try {
      if (currentUserEmail != _search.text) {
        await _firestore
            .collection('users')
            .where("email", isEqualTo: _search.text.toLowerCase())
            .get()
            .then((value) {
          setState(() {
            userMap = value.docs[0].data();
            isLoading = false;
          });
        });
      } else {
        setState(() {
          searchtext = "Searching yourself?";
        });
      }
    } catch (e) {
      setState(() {
        searchtext = "The User does not exist";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //
      backgroundColor: Colors.grey[300],
      body: SizedBox(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 18,
            ),
            Center(
              child: SizedBox(
                width: size.width / 1.1,
                child: Container(
                  width: size.width / 1.2,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: Colors.grey[200],
                      boxShadow: [
                        //Bottom right shadow will be darker
                        BoxShadow(
                            color: Colors.grey.shade400,
                            offset: const Offset(0, 0),
                            blurRadius: 15,
                            spreadRadius: 1),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: SizedBox(
                          height: size.height / 14,
                          width: size.width / 1.5,
                          child: TextField(
                            style: const TextStyle(color: Colors.black),
                            controller: _search,
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              //prefixIcon: Icon(Icons.search),
                              hintText: "Search by email",
                              hintStyle: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: size.height / 20,
                        child: FloatingActionButton(
                            backgroundColor: Colors.grey[800],
                            onPressed: () async {
                              onSearch();
                              await analytics.logEvent(name: 'PeopleSearching');
                            },
                            child: const Icon(Icons.search)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: userMap != null
                  ? GestureDetector(
                      onTap: () {
                        try {
                          // String roomId = chatRoomId(
                          //     _auth.currentUser?.uid != null
                          //         ? _auth.currentUser!.uid
                          //         : "No Display name",
                          //     userMap!['uid']);
                          //2908

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchProfile(
                                        userMap: userMap,
                                      )));
                        } catch (e) {
                          return;
                        }
                      },
                      child: Container(
                        height: size.height / 10,
                        decoration: const BoxDecoration(
                            // color: primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 20,
                            ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                child: SizedBox(
                                    height: size.height / 16,
                                    width: size.width / 8,
                                    child: CircleAvatar(
                                        radius: 30,
                                        child: CircleAvatar(
                                            backgroundColor: Colors.black,
                                            radius: 62,
                                            backgroundImage: nullChecker(
                                                userMap!["profileImage"]))))),
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: size.width / 1.4,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        userMap!["firstName"],
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.grey[800],
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Text(
                                      //   snapshot.data!.docs[index]['time']
                                      //       .toString(),
                                      //   style:
                                      //       TextStyle(color: Colors.white),
                                      // )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: size.width / 2,
                                        child: Text(userMap!["email"],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            //softWrap: false,
                                            style: TextStyle(
                                                color: Colors.grey[700])),
                                      ),
                                      // Text("$numbering",
                                      //     style: const TextStyle(color: Colors.white))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    )
                  : premium
                      ? Center(
                          child: SizedBox(
                            width: size.width / 1.2,
                            //The button to vies the list of all the users
                            child: Column(children: [
                              Text(
                                "Which gender profiles would you like to see?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 21),
                              ),
                              SizedBox(
                                height: size.height / 40,
                              ),
                              Container(
                                height: size.height / 15,
                                width: size.width / 3.5,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    ),
                                    color: Colors.grey[200],
                                    boxShadow: [
                                      //Bottom right shadow will be darker
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          offset: const Offset(0, 0),
                                          blurRadius: 15,
                                          spreadRadius: 1),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      borderRadius: BorderRadius.circular(30),
                                      dropdownColor: Colors.grey[100],
                                      isExpanded: true,
                                      items: gender
                                          .map((String dropDownStringItem) {
                                        return DropdownMenuItem<String>(
                                          value: dropDownStringItem,
                                          child: Text(dropDownStringItem),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValueSelected) {
                                        // Your code to execute, when a menu item is selected from drop down
                                        setState(() {
                                          genderVal = newValueSelected!;
                                        });
                                      },
                                      value: genderVal,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height / 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DisplayAll(
                                                gender: genderVal,
                                              )));
                                },
                                child: Container(
                                  height: size.height / 15,
                                  width: size.width / 2,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                      color: Colors.grey[700],
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
                                      "See Profiles",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ),
                        )
                      : Column(
                          children: [
                            Text(
                              searchtext,
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 15),
                            ),
                            SizedBox(
                              height: size.height / 50,
                            ),
                            Text(
                              "Unlock Premium",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 50,
                                  fontFamily: "Pacifico"),
                            ),
                            SizedBox(
                              height: size.height / 40,
                            ),
                            Container(
                              height: size.height / 2.8,
                              width: size.width / 1.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
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
                              child: Center(
                                  child: Text(
                                "Wondering who else is using the app?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 45,
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                            SizedBox(
                              height: size.height / 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PremiumInfo()));
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
                                    color: Colors.grey[700],
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
                                    "Learn More",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
            )
          ],
        ),
      ),
    );
  }
}
