import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:promnight/screens/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:promnight/screens/profiles/firstguide.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController about = TextEditingController();
  final TextEditingController igAccount = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String errorText = "";
  bool _isLoading = false;
  File? file;
  imagepicker() async {
    //await Permission.storage.request();
    await Permission.photos.request();
    await Permission.camera.request();

    var permissionStatus = await Permission.camera.status;

    if (permissionStatus.isGranted) {
      try {
        XFile? xfile = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 40);

        file = File(xfile!.path);
        setState(() {});
      } catch (e) {
        return;
      }
    }
  }

  updateProfile(BuildContext context) async {
    Map<String, dynamic> map = {};
    if (file != null) {
      setState(() {
        errorText = "Do not press the back button";
      });
      print(file!.length());
      String? url = await uploadImage();
      map = {"profileImage": url, "about": about.text, "insta": igAccount.text};

      FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .update(map)
            .then((newValue) async {
          try {
            if (value.data()!["gender"] == "Female") {
              await FirebaseFirestore.instance
                  .collection("mada")
                  .doc(_auth.currentUser!.uid)
                  .update(map);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Guide()));
            } else {
              await FirebaseFirestore.instance
                  .collection("nonmada")
                  .doc(_auth.currentUser!.uid)
                  .update(map);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Guide()));
            }
          } catch (e) {
            print(e);
          }
        });
      });
    }
  }

  Future<String?> uploadImage() async {
    var snapshot = await FirebaseStorage.instance
        .ref()
        .child('profile')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .putFile(file!);

    var downloadurl = await (snapshot.ref.getDownloadURL());

    return downloadurl;
    // await FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .update({
    //   "profileurl": downloadurl,
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height / 20,
            ),
            Text(
              "Final Step",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            file == null
                ? GestureDetector(
                    onTap: () {
                      print("Choose a profile photo");
                      imagepicker();
                    },
                    child: Center(
                      child: Container(
                        height: size.height / 4,
                        // width: size.width / 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                          boxShadow: [
                            //Bottom right shadow will be darker
                             BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(0, 0),
                    blurRadius: 15,
                    spreadRadius: 1),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.camera,
                                size: 50,
                              ),
                              SizedBox(
                                height: size.height / 30,
                              ),
                              Text(
                                "Choose a photo",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      print("Choose a profile photo");
                      imagepicker();
                    },
                    child: Center(
                        child: Container(
                      height: size.height / 4,
                      // width: size.width / 5,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                          boxShadow: [
                            //Bottom right shadow will be darker
                             BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(0, 0),
                    blurRadius: 15,
                    spreadRadius: 1),
                          ],
                          image: DecorationImage(
                              image: Image.file(file!).image,
                              fit: BoxFit.cover)),
                    ))),
            SizedBox(
              height: size.height / 20,
            ),
            //
            Row(
              children: [
                SizedBox(
                  width: size.width / 21,
                ),
                Text(
                  "Instagram Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height / 60,
            ),
            customField(size, false, "Share your insta account", igAccount),
            SizedBox(
              height: size.height / 20,
            ),
            //
            Row(
              children: [
                SizedBox(
                  width: size.width / 21,
                ),
                Text(
                  "About You",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height / 60,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
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
                ],
              ),
              height: size.height / 6,
              width: size.width / 1.07,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  decoration: const InputDecoration(
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    hintText: "Write only 3 lines about yourself.",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  style: const TextStyle(color: Colors.black),
                  controller: about,
                  maxLines: 4,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            Text(
              errorText,
              style: const TextStyle(color: Colors.red),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            GestureDetector(
              onTap: () {
                if (file != null && about.text.isNotEmpty) {
                  if (about.text.length > 40) {
                    setState(() {
                      _isLoading = true;
                      errorText = "";
                    });
                    updateProfile(context);
                  } else {
                    setState(() {
                      errorText = "Please write something more about yourself";
                    });
                  }
                } else {
                  setState(() {
                    errorText = "Please fill everything";
                  });
                }
              },
              child: Container(
                height: size.height / 15,
                width: size.width / 3,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    color: Colors.red[700],
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
                child: Center(
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Finish",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 60,
            )
          ],
        ),
      ),
    ));
  }

  Widget customField(
      Size size, bool val, String text, TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width / 1.1,
          height: size.height / 14,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Colors.grey[100],
              boxShadow: [
                //Bottom right shadow will be darker
                 BoxShadow(
                    color: Colors.grey.shade300,
                    offset: const Offset(0, 0),
                    blurRadius: 15,
                    spreadRadius: 1),
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 8),
            child: TextFormField(
              onChanged: (value) {},
              controller: controller,
              obscureText: val,
              style: const TextStyle(color: Colors.black),
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                isCollapsed: false,
                fillColor: Colors.grey,
                hintText: text,
                hintStyle: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
