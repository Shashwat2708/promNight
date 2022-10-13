import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<User?> createAccount(
    String firstName,
    String lastName,
    String email,
    String password,
    String age,
    String height,
    String course,
    String year,
    String gender,
    String pref) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  try {
    User? user = (await auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      await user.updateDisplayName(firstName);

      await firestore.collection("users").doc(auth.currentUser!.uid).set({
        "firstName": firstName,
        "lastName": lastName,
        "email": email.toLowerCase(),
        "about": "",
        "pref": pref,
        "age": age,
        "height": height,
        "course": course,
        "year": year,
        "gender": gender,
        "uid": auth.currentUser!.uid,
        "pushtoken": "null",
        "key": password,
        "type": 0,
        "matchedwith": "",
        "matchwithtime": "",
        "matchwithdate": "",
        "skipNext": false,
        "currentchatroomid": "",
        "profileImage": "",
        "insta": "",
        "isBanned": false,
        "premium": false
      });
      if (gender == "Female") {
        await firestore.collection("mada").doc(auth.currentUser!.uid).set({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "age": age,
          "height": height,
          "course": course,
          "year": year,
          "gender": gender,
          "uid": auth.currentUser!.uid,
          "profileImage": "",
          "insta": "",
          "dateTimeRegistered": FieldValue.serverTimestamp(),
        });
        await FirebaseAnalytics.instance.logEvent(name: "FemaleUsers");
      } else {
        await firestore.collection("nonmada").doc(auth.currentUser!.uid).set({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "age": age,
          "height": height,
          "course": course,
          "year": year,
          "gender": gender,
          "uid": auth.currentUser!.uid,
          "profileImage": "",
          "insta": "",
          "dateTimeRegistered": FieldValue.serverTimestamp(),
        });
        await FirebaseAnalytics.instance.logEvent(name: "MaleUsers");
      }

      return user;
    } else {
      return user;
    }
  } catch (e) {
    return null;
  }
}

Future<User?> loginUser(String email, String password) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    User? user = (await auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      return user;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future signingOut() async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut();
  } catch (e) {
    return null;
  }
}
