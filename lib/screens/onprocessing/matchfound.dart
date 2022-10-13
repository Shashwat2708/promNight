import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:promnight/screens/chatscreen.dart';
import 'package:promnight/screens/onprocessing/findingnext.dart';
import 'package:promnight/screens/profiles/onsearchprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MatchFound extends StatefulWidget {
  //Adding chatroomid and getting the users uid
  final Map<String, dynamic>? userMap;
  const MatchFound({Key? key, required this.userMap}) : super(key: key);

  @override
  State<MatchFound> createState() => _MatchFoundState();
}

class _MatchFoundState extends State<MatchFound> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final _currentTime = DateTime.now();
  bool findNext = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeAndDateGetter();
  }

  nullChecker(String photoUrl) {
    try {
      return NetworkImage(photoUrl);
    } catch (e) {
      return const AssetImage("assets/logo.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        children: [
          Text(
            "You're Matched With",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(
            height: size.height / 50,
          ),
          Container(
            width: size.width / 1.2,
            height: size.height / 2.1,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: nullChecker(widget.userMap!["profileImage"]),
                  fit: BoxFit.cover,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
                boxShadow: const [
                  //Bottom right shadow will be darker
                  BoxShadow(
                    color: Color.fromARGB(255, 186, 186, 186),
                    offset: Offset(0, 0),
                    blurRadius: 21,
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: size.height / 50,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.userMap!["firstName"]} ${widget.userMap!["lastName"]}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height / 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchProfile(
                                userMap: widget.userMap,
                              )));
                },
                child: Container(
                  height: size.height / 15,
                  width: size.width / 4,
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
                      "Profile",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width / 14,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                chatRoomId:
                                    widget.userMap!["currentchatroomid"],
                                userid: widget.userMap!["uid"],
                              )));
                  print(widget.userMap!["uid"]);
                },
                child: Container(
                  height: size.height / 15,
                  width: size.width / 4,
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
                      "Chat",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height / 40,
          ),
          findNext
              ? GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FindingNext(
                                  matchedwith: widget.userMap!["uid"],
                                )));
                  },
                  child: Container(
                    height: size.height / 15,
                    width: size.width / 2.5,
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
                        "Find Next Match",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              : Text(
                  "You will be able to find the next match after 3 hours of matching with ${widget.userMap!["firstName"]}.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
        ],
      ),
    );
  }

  void timeAndDateGetter() {
    _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      timeConverter(
          value.data()!["matchwithdate"], value.data()!["matchwithtime"]);
    });
  }

  String timeConverter(String date, String time) {
    if (int.parse(date.substring(6)) - _currentTime.year == 0) {
      if (int.parse(date.substring(3, 5)) - _currentTime.month == 0) {
        if (int.parse(date.substring(0, 2)) - _currentTime.day == 0) {
          if (_currentTime.hour - int.parse(time.substring(0, 2)) > 3) {
            setState(() {
              findNext = true;
            });
          }
          return time;
        } else if ((int.parse(date.substring(0, 2)) - _currentTime.day).abs() ==
            1) {
          setState(() {
            findNext = true;
          });
          return "Yesterday";
        } else {
          setState(() {
            findNext = true;
          });
          return date;
        }
      } else {
        setState(() {
          findNext = true;
        });
        return date;
      }
    } else {
      setState(() {
        findNext = true;
      });
      return date;
    }
  }
}
