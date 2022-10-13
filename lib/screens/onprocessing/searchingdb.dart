import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:promnight/screens/dashboard.dart';
import 'package:promnight/screens/onprocessing/assigningmatch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchingDB extends StatefulWidget {
  const SearchingDB({Key? key}) : super(key: key);

  @override
  State<SearchingDB> createState() => _SearchingDBState();
}

class _SearchingDBState extends State<SearchingDB> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String gender = "";
  String mainCollec = "";
  String subCollec = "";
  String docId = "";

  String mainCollec2 = "";
  String subCollec2 = "";
  String docId2 = "";

  int count = 0;
  //This count is used to avoid execution of the validate function twice.

  bool isLoading = true;
  String matchedwith = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genderFinder();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(
        color: Colors.black,
      ),
    ));
  }

  void validater() async {
    int count = 0;
    //this function checks if the database is empty by checking the count.
    //If it is, then it will add the current users value to the database
    //otherwise it will take the most recent value and match them.
    print(mainCollec + " " + subCollec + " " + docId);
    await _firestore.collection(mainCollec).doc(docId).get().then((value) {
      setState(() {
        count = value.data()!["count"];
        print("$count Will be the count");
      });
    });
    print("This is the count = $count");

    if (count == 0) {
      //Add the users detail to boysinthepool, change the type to 2 in profile
      //and increase the count.
      _firestore
          .collection(mainCollec2)
          .doc(docId2)
          .collection(subCollec2)
          .doc(_auth.currentUser!.uid)
          .set({
        "id": _auth.currentUser!.uid,
        "time": FieldValue.serverTimestamp(),
      });
      _firestore
          .collection(mainCollec2)
          .doc(docId2)
          .update({"count": FieldValue.increment(1)});
      _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .update({"type": 2});
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    } else {
      //Give the matched with id and change the type to 3 of both the users
      // by decrementing the value in girls pool and deleting the value from
      // the girls pool.
      if (!mounted) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AssigningAMatch(
                    mainCollec: mainCollec,
                    subCollec: subCollec,
                    docId: docId,
                    mainCollec2: mainCollec2,
                    subCollec2: subCollec2,
                    docId2: docId2,
                  )));
    }
  }

  void genderFinder() {
    _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        gender = value.data()!["gender"];
      });
      print(gender);
      if (gender == "Male") {
        setState(() {
          mainCollec = "girls";
          subCollec = "girlsinthepool";
          docId = "pKcudBMRHfgPz6wPfF52";
          mainCollec2 = "boys";
          subCollec2 = "boysinthepool";
          docId2 = "8ZgafofYKWrqc0LzqANo";
        });
      } else {
        setState(() {
          mainCollec = "boys";
          subCollec = "boysinthepool";
          docId = "8ZgafofYKWrqc0LzqANo";
          mainCollec2 = "girls";
          subCollec2 = "girlsinthepool";
          docId2 = "pKcudBMRHfgPz6wPfF52";
        });
      }
      if (count == 0) {
        validater();
        count++;
      }
    });
  }
}
