import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Practise1 extends StatefulWidget {
  const Practise1({Key? key}) : super(key: key);

  @override
  State<Practise1> createState() => _Practise1State();
}

class _Practise1State extends State<Practise1> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Center(
      child: StreamBuilder(
        stream: _firestore
            .collection('boys')
            .doc("8ZgafofYKWrqc0LzqANo")
            .collection('boysinthepool')
            .orderBy("time", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print(snapshot.data!.docs[0]['name']);
          print(snapshot.data!.docs[0].id);
          //if (snapshot.data!.docs.isEmpty) {
          return SizedBox();
        },
      ),
      // child: FloatingActionButton(
      //   onPressed: () {
      //     uploadInBoys();
      //   },
      //   child: const Icon(Icons.add),
      // ),
    )));
  }

  void getCount() {
    _firestore
        .collection("boys")
        .doc("8ZgafofYKWrqc0LzqANo")
        .get()
        .then((value) {
      print(value.data()!["count"]);
    });
  }

  void readCurrentGender() {}

  void uploadInBoys() {
    _firestore
        .collection("boys")
        .doc("8ZgafofYKWrqc0LzqANo")
        .collection("boysinthepool")
        .add({
      "name": "Saumya",
      "time": FieldValue.serverTimestamp(),
    });

    _firestore
        .collection("boys")
        .doc("8ZgafofYKWrqc0LzqANo")
        .update({"count": FieldValue.increment(1)});
  }

  void removeFromBoys() {
    _firestore
        .collection("boys")
        .doc("8ZgafofYKWrqc0LzqANo")
        .collection("boysinthepool")
        .where("count", isEqualTo: 2)
        .get()
        .then((value) {
      _firestore
          .collection("boys")
          .doc("8ZgafofYKWrqc0LzqANo")
          .collection("boysinthepool")
          .doc(value.docs[0].id)
          .delete();
      //print(value.docs[0].id);
    });

    _firestore
        .collection("boys")
        .doc("8ZgafofYKWrqc0LzqANo")
        .update({"count": FieldValue.increment(-1)});
  }

  void randomGenerator() {
    int count = 0;
    _firestore
        .collection("boys")
        .doc("8ZgafofYKWrqc0LzqANo")
        .get()
        .then((value) {
      print("Count on cloud is ${value.data()!["count"]}");
      setState(() {
        count = value.data()!["count"];
      });
      print("Here is $count");
      int newCount = 1 + Random().nextInt(count - 1);
      print(newCount);
    });
  }
}
