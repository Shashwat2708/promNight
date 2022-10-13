import 'package:promnight/screens/auth/landing.dart';
import 'package:promnight/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticateCheck extends StatefulWidget {
  const AuthenticateCheck({Key? key}) : super(key: key);

  @override
  _AuthenticateCheckState createState() => _AuthenticateCheckState();
}

class _AuthenticateCheckState extends State<AuthenticateCheck> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return const Dashboard();
    } else {
      return const LandingPage();
    }
  }
}
