import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:promnight/screens/homepage.dart';
import 'package:promnight/screens/profiles/editprofile.dart';
import 'package:promnight/screens/profiles/personalprofile.dart';
import 'package:promnight/screens/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int _currentIndex = 0;
  bool isBanned = false;
  //Value to be changed here when building the final application
  bool isLoaded = true;
  final tabs = const [
    HomePage(),
    SearchPage(),
    PersonalProfile(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerNotification();
    configureLocalNotification();
    profileCompleteChecker();
  }

  void registerNotification() {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        //show notification
        showNotification(message.notification!);
      }
    });
    FirebaseMessaging.instance.getToken().then((token) {
      if (token != null) {
        Map<String, dynamic> map = {"pushtoken": token};
        _firestore.collection("users").doc(_auth.currentUser!.uid).update(map);
      }
    }).catchError((error) {});
  }

  void configureLocalNotification() {
    AndroidInitializationSettings initializationAndroidSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    IOSInitializationSettings initializationIOsSettings =
        const IOSInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationAndroidSettings,
      iOS: initializationIOsSettings,
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(RemoteNotification remoteNotification) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('com.example.doplop', 'doplop',
            playSound: true,
            enableVibration: true,
            importance: Importance.max,
            priority: Priority.high);

    IOSNotificationDetails iosNotificationDetails =
        const IOSNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(0, remoteNotification.title,
        remoteNotification.body, notificationDetails);
  }

  void profileCompleteChecker() async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      String profileVal = value.data()!["about"];
      if (profileVal == "") {
        //Fill The profile page first
        //
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const EditProfile()));
        snackBar(context, "Fill Your Profile First");
      } else {
        if (value.data()!["isBanned"] == true) {
          setState(() {
            isBanned = true;
          });
        } else {
          setState(() {
            isBanned = false;
            isLoaded = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isBanned
          ? Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    "You are banned because of absuive behaviour.\nYou will be notified once unbanned.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: GestureDetector(
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection("unbanRequest")
                            .add({
                          "uid": FirebaseAuth.instance.currentUser!.uid
                        });
                        snackBar(context, "Ban Requested");
                      },
                      child: Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.red[600]),
                        child: Center(
                            child: Text(
                          "Request Unban",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Scaffold(
              body: isLoaded
                  ? tabs[_currentIndex]
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              bottomNavigationBar: isLoaded
                  ? BottomNavigationBar(
                      unselectedItemColor: Colors.grey[700],
                      selectedItemColor: Colors.red,
                      currentIndex: _currentIndex,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.grey[100],
                      items: const [
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.home,
                            ),
                            label: ""),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.search), label: ""),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.person), label: ""),
                      ],
                      onTap: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    )
                  : const SizedBox(),
            ),
    );
  }

  void snackBar(BuildContext context, String msg) {
    var snackbar = SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 15),
      ),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.white,
      shape: StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 80),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
