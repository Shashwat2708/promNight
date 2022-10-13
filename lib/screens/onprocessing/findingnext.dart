import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:promnight/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FindingNext extends StatefulWidget {
  final String matchedwith;
  const FindingNext({Key? key, required this.matchedwith}) : super(key: key);

  @override
  State<FindingNext> createState() => _FindingNextState();
}

class _FindingNextState extends State<FindingNext> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findingNextUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: const Center(
          child: CircularProgressIndicator(color: Colors.black),
        ),
      ),
    );
  }

  void findingNextUser() {
    _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .update({"type": 0});
    print(_auth.currentUser!.uid);
    print(widget.matchedwith);
    _firestore.collection("users").doc(widget.matchedwith).update({"type": 0});
    if (!mounted) return;
    try {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      });
    } catch (e) {
      print(e);
    }
  }
}
