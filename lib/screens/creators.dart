import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/services.dart';

class Creators extends StatefulWidget {
  const Creators({Key? key}) : super(key: key);

  @override
  State<Creators> createState() => _CreatorsState();
}

class _CreatorsState extends State<Creators> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: size.height / 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: Colors.grey[700],
                    ))
              ],
            ),
            SizedBox(
              height: size.height / 40,
            ),
            Center(
              child: NeumorphicText(
                "The Creators Are",
                style: NeumorphicStyle(color: Colors.grey[700], depth: 7),
                textStyle: NeumorphicTextStyle(
                    fontSize: size.height / 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Pacifico"),
              ),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            SizedBox(
              height: size.height,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('creators')
                    .orderBy("count")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return SizedBox(
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height / 30,
                          ),
                          const Icon(
                            Icons.error,
                            size: 180,
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        //print(snapshot.data!.docs[index]['chatroom'][0]);
                        return tiles(
                          size,
                          snapshot.data!.docs[index]['name'],
                          snapshot.data!.docs[index]['instagram'],
                        );
                      });
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget tiles(Size size, String name, String instagram) {
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: instagram))
            .then((value) => snackBar(context, name));
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            height: size.height / 9,
            width: size.width / 1.1,
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(50),
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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18, left: 18),
                    child: SizedBox(
                      width: size.width / 1.5,
                      child: Text(
                        name.split(" ")[0],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 21),
                child: SizedBox(
                  width: size.width / 1.2,
                  child: Text(
                    "IG Account - $instagram",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void snackBar(BuildContext context, String name) {
    var snackbar = SnackBar(
      content: Text(
        "${name.split(" ")[0]}'s IG Account Copied",
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 15),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.white,
      shape: const StadiumBorder(),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
