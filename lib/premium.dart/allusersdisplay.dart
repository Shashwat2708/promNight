import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:promnight/screens/profiles/onsearchprofile.dart';

class DisplayAll extends StatefulWidget {
  final String gender;
  const DisplayAll({Key? key, required this.gender}) : super(key: key);

  @override
  State<DisplayAll> createState() => _DisplayAllState();
}

class _DisplayAllState extends State<DisplayAll> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  nullChecker(String photoUrl) {
    try {
      return NetworkImage(photoUrl);
    } catch (e) {
      return const AssetImage("assets/main.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(children: [
        SizedBox(
          height: size.height / 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width / 50,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey[700],
                )),
          ],
        ),
        Container(
          height: size.height / 1.2,
          child: StreamBuilder(
              stream: _firestore
                  .collection(widget.gender == "Male" ? "nonmada" : "mada")
                  .orderBy("dateTimeRegistered", descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchProfile(
                                            userMap: map,
                                          )));
                            },
                            child: Container(
                              height: size.height / 2.8,
                              width: size.width / 1.4,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: nullChecker(map["profileImage"]),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(30)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: size.height / 10,
                                    width: size.width / 1.2,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.8),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 6,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 21, top: 6),
                                            child: Text(
                                              "${map["firstName"]} ${map["lastName"]}, ${map["age"]}",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 21, top: 6),
                                            child: Text(
                                              "${map["course"]}, ${map["year"]}",
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                          )
                                        ]),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              }),
        )
      ]),
    ));
  }
}
