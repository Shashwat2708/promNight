// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:euphoria/screens/dashboard.dart';
// import 'package:euphoria/screens/onprocessing/inthedb.dart';
// import 'package:euphoria/screens/onprocessing/matchfound.dart';
// import 'package:euphoria/screens/onprocessing/searchingdb.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// //Types -
// //1 - Searching for gender and other values
// //2 - Added info to the db
// //3 - Assigned a value
// class OnProcessing extends StatefulWidget {
//   const OnProcessing({Key? key}) : super(key: key);

//   @override
//   State<OnProcessing> createState() => _OnProcessingState();
// }

// class _OnProcessingState extends State<OnProcessing> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   int type = 0;
//   String gender = "";
//   String mainCollec = "";
//   String subCollec = "";
//   String docId = "";

//   String mainCollec2 = "";
//   String subCollec2 = "";
//   String docId2 = "";

//   int count = 0;

//   bool isLoading = true;
//   String matchedwith = "";

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getType();
//   }

//   void getType() {
//     _firestore
//         .collection("users")
//         .doc(_auth.currentUser!.uid)
//         .get()
//         .then((value) {
//       setState(() {
//         type = value.data()!["type"];
//       });
//       if (type == 1) {
//         print("Validater will work");
//         genderFinder();
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) => const Dashboard()));
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     if (type == 1) {
//       return SizedBox(height: size.height / 3, child: const OnProcessing());
//     } else if (type == 2) {
//       return SizedBox(
//         height: size.height / 3,
//         child: const InTheDB(),
//       );
//     } else if (type == 3) {
//       return SizedBox(
//         height: size.height / 3,
//         child: const MatchFound(),
//       );
//     }
//     return const SizedBox();
//   }

// //These are the functions for search screen
// //The functions are - validater, genderFinder
//   void validater() {
//     int count = 0;
//     //this function checks if the database is empty by checking the count.
//     //If it is, then it will add the current users value to the database
//     //otherwise it will take the most recent value and match them.
//     _firestore.collection(mainCollec).doc(docId).get().then((value) {
//       count = value.data()!["count"];
//     });
//     if (count == 0) {
//       //Add the users detail to boysinthepool, change the type to 2 in profile
//       //and increase the count.
//       _firestore
//           .collection(mainCollec2)
//           .doc(docId2)
//           .collection(subCollec2)
//           .doc(_auth.currentUser!.uid)
//           .set({
//         "id": _auth.currentUser!.uid,
//         "time": FieldValue.serverTimestamp(),
//       });
//       _firestore
//           .collection(mainCollec2)
//           .doc(docId2)
//           .update({"count": FieldValue.increment(1)});

//       _firestore
//           .collection("users")
//           .doc(_auth.currentUser!.uid)
//           .update({"type": 2});
//     } else {
//       //Give the matched with id and change the type to 3 of both the users
//       // by decrementing the value in girls pool and deleting the value from
//       // the girls pool.
//     }
//   }

//   void genderFinder() {
//     _firestore
//         .collection("users")
//         .doc(_auth.currentUser!.uid)
//         .get()
//         .then((value) {
//       setState(() {
//         gender = value.data()!["gender"];
//       });
//       print(gender);
//       if (gender == "Male") {
//         setState(() {
//           mainCollec = "girls";
//           subCollec = "girlsinthepool";
//           docId = " 3S2I4HRVXDSyBAcyp1Z3";
//           mainCollec2 = "boys";
//           subCollec2 = "boysinthepool";
//           docId2 = "8ZgafofYKWrqc0LzqANo";
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           mainCollec = "boys";
//           subCollec = "boysinthepool";
//           docId = "8ZgafofYKWrqc0LzqANo";
//           mainCollec2 = "girls";
//           subCollec2 = "girlsinthepool";
//           docId2 = " 3S2I4HRVXDSyBAcyp1Z3";
//           isLoading = false;
//         });
//       }
//     });
//     validater();
//   }
// }
