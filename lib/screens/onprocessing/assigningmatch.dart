import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:promnight/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssigningAMatch extends StatefulWidget {
  String mainCollec;
  String subCollec;
  String docId;

  String mainCollec2;
  String subCollec2;
  String docId2;
  AssigningAMatch(
      {Key? key,
      required this.mainCollec,
      required this.subCollec,
      required this.docId,
      required this.mainCollec2,
      required this.subCollec2,
      required this.docId2})
      : super(key: key);

  @override
  State<AssigningAMatch> createState() => _AssigningAMatchState();
}

class _AssigningAMatchState extends State<AssigningAMatch> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int count = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String matchedwith = "";

    return Scaffold(
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Oh Wait!!!",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(
              height: size.height / 15,
            ),
            const CircularProgressIndicator(
              color: Colors.black,
            ),
            SizedBox(
              height: size.height / 15,
            ),
            Center(
              child: Text(
                "We found someone for you",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
            StreamBuilder(
                stream: _firestore
                    .collection(widget.mainCollec)
                    .doc(widget.docId)
                    .collection(widget.subCollec)
                    .orderBy("time")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  // print(snapshot.data!.docs[0]['name']);
                  print("Hello world");
                  try {
                    if (count == 0) {
                      matchedwith = snapshot.data!.docs[0].id;
                      print("$matchedwith is the new doc id");
                      assigner(matchedwith);
                      count++;
                    }
                  } catch (e) {
                    print(e);
                  }

                  return const SizedBox();
                })
          ],
        ),
      ),
    );
  }

  Future<void> assigner(String matchedwith) async {
    //This will be used to get the matched with uid and then assing that to both
    //the users after and also update the type field along with giving the chat
    //roomid and then delete the opposite genderpool and decrement the count.
    String currentchatroomid = _auth.currentUser!.uid + matchedwith;
    final inditime = DateTime.now();

    await _firestore.collection("users").doc(_auth.currentUser!.uid).update({
      "matchedwith": matchedwith,
      "type": 3,
      "currentchatroomid": currentchatroomid,
      "matchwithtime": DateFormat('hh:mm').format(inditime),
      "matchwithdate": DateFormat('dd-MM-yyyy').format(inditime),
    });
    await _firestore.collection("users").doc(matchedwith).update({
      "matchedwith": _auth.currentUser!.uid,
      "type": 3,
      "currentchatroomid": currentchatroomid,
      "matchwithtime": DateFormat('hh:mm').format(inditime),
      "matchwithdate": DateFormat('dd-MM-yyyy').format(inditime),
    }).then((value) async {
      await _firestore
          .collection(widget.mainCollec)
          .doc(widget.docId)
          .collection(widget.subCollec)
          .doc(matchedwith)
          .delete();
      await _firestore
          .collection(widget.mainCollec)
          .doc(widget.docId)
          .update({"count": FieldValue.increment(-1)});
      await _firestore
          .collection(widget.mainCollec2)
          .doc(widget.docId2)
          .update({"count": FieldValue.increment(-1)});
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    });
  }
}
