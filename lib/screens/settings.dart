import 'package:promnight/methods/firebasemethods.dart';
import 'package:promnight/screens/auth/landing.dart';
import 'package:promnight/screens/auth/login/login.dart';
import 'package:promnight/screens/creators.dart';
import 'package:promnight/screens/guide.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          SizedBox(
            height: size.height / 40,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                print("Show Creators");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Creators()));
                FirebaseAnalytics.instance.logEvent(name: "CreatorPageVisited");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Creators",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.people)
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: size.height / 40,
          // ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () async {
                print("Guide");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Guide()));
                await FirebaseAnalytics.instance
                    .logEvent(name: "GuidePageVisited");
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Guide",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.tour)
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: size.height / 40,
          // ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {
                signingOut().then((value) async {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LandingPage()));
                  await FirebaseAnalytics.instance
                      .logEvent(name: "UserLoggedOut");
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Log Out",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(Icons.exit_to_app)
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
