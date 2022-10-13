import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  final dynamic userid;
  const ChatScreen({
    Key? key,
    required this.chatRoomId,
    required this.userid,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _chats = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final inditime = DateTime.now();
  bool chatIsEmpty = true;
  String _message = "";
  String copiedText = "";
  late Timestamp copiedTextTime;
  bool isLoading = true;
  bool notPressed = true;
  late bool isItYourChat;
  late Timestamp lastChatTime;
  String secondLastChatMessage = '';
  String secodLastChatMessageTime = '';
  String secodLastChatMessageDate = '';
  Map<String, dynamic>? usermap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valueFinder();
  }

  void valueFinder() {
    _firestore.collection("users").doc(widget.userid).get().then((value) {
      setState(() {
        usermap = value.data();
        isLoading = false;
        print(usermap!["firstName"]);
      });
    });
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    _chats.dispose();
  }

  nullChecker(String photoUrl) {
    try {
      return NetworkImage(photoUrl);
    } catch (e) {
      return const AssetImage("assets/logo.png");
    }
  }

  timeConverter(String date) {
    if (int.parse(date.substring(6)) - inditime.year == 0) {
      if (int.parse(date.substring(3, 5)) - inditime.month == 0) {
        if (int.parse(date.substring(0, 2)) - inditime.day == 0) {
          return "Today";
        } else if ((int.parse(date.substring(0, 2)) - inditime.day).abs() ==
            1) {
          return "Yesterday";
        } else {
          return date;
        }
      } else {
        return date;
      }
    } else {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: isLoading
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
            )
          : Scaffold(
              appBar: notPressed
                  ? AppBar(
                      elevation: 0,
                      backgroundColor: Colors.grey[200],
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey[600],
                        ),
                      ),
                      title: Row(
                        children: [
                          SizedBox(
                              height: size.height / 20,
                              width: size.width / 10,
                              child: CircleAvatar(
                                  radius: 30,
                                  child: CircleAvatar(
                                      backgroundColor: const Color(0xff0F0E13),
                                      radius: 62,
                                      backgroundImage: nullChecker(
                                          usermap!["profileImage"])))),
                          SizedBox(
                            width: size.width / 30,
                          ),
                          Text(usermap!["firstName"],
                              style: TextStyle(
                                  fontSize: 18,
                                  decoration: TextDecoration.none,
                                  color: Colors.grey[800])),
                        ],
                      ),
                      actions: [
                        IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context),
                              );
                            },
                            icon: Icon(
                              Icons.report,
                              color: Colors.grey[600],
                            ))
                      ],
                    )
                  : AppBar(
                      backgroundColor: Colors.grey[700],
                      leading: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey[700],
                      ),
                      actions: [
                        IconButton(
                            onPressed: () async {
                              await Clipboard.setData(
                                      ClipboardData(text: copiedText))
                                  .then((value) {
                                snackBar(context);
                              });
                              setState(() {
                                notPressed = true;
                                copiedText = "";
                              });
                            },
                            icon: const Icon(
                              Icons.content_copy,
                              color: Colors.white,
                            )),
                        isItYourChat
                            ? IconButton(
                                onPressed: () async {
                                  //deleting chat
                                  String ChatID = "";
                                  await _firestore
                                      .collection('chatroom')
                                      .doc(widget.chatRoomId)
                                      .collection('chats')
                                      .where("time", isEqualTo: copiedTextTime)
                                      .get()
                                      .then((value) {
                                    setState(() {
                                      ChatID = value.docs[0].id;
                                    });
                                  });

                                  if (copiedTextTime == lastChatTime) {
                                    try {
                                      await _firestore
                                          .collection("chatroom")
                                          .doc(widget.chatRoomId)
                                          .collection("chats")
                                          .doc(ChatID)
                                          .delete();

                                      setState(() {
                                        notPressed = true;
                                        copiedText = "";
                                      });

                                      Map<String, dynamic> userinfo = {
                                        'indidate': secodLastChatMessageDate,
                                        'inditime': secodLastChatMessageTime,
                                        "lastmessage": secondLastChatMessage,
                                        'time': lastChatTime
                                      };
                                      _firestore
                                          .collection("chatted")
                                          .doc(_auth.currentUser!.uid)
                                          .collection("users")
                                          .doc(usermap!["uid"])
                                          .update(userinfo);
                                      //for user2
                                      _firestore
                                          .collection("chatted")
                                          .doc(usermap!["uid"])
                                          .collection("users")
                                          .doc(_auth.currentUser!.uid)
                                          .update(userinfo);
                                      setState(() {
                                        notPressed = true;
                                        copiedText = "";
                                        isItYourChat = false;
                                      });
                                    } catch (e) {
                                      return;
                                    }
                                    print("Last one");
                                  } else {
                                    print("Not the last one");
                                    await _firestore
                                        .collection("chatroom")
                                        .doc(widget.chatRoomId)
                                        .collection("chats")
                                        .doc(ChatID)
                                        .delete();

                                    setState(() {
                                      notPressed = true;
                                      copiedText = "";
                                      isItYourChat = false;
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ))
                            : Container()
                      ],
                    ),
              backgroundColor: Colors.grey[700],
              body: Container(
                color: Colors.grey[100],
                child: SingleChildScrollView(
                  child: Stack(children: [
                    Column(
                      children: [
                        SingleChildScrollView(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                notPressed = true;
                                chatIsEmpty = true;
                              });
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: SizedBox(
                                height: size.height / 1.23,
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: _firestore
                                      .collection('chatroom')
                                      .doc(widget.chatRoomId)
                                      .collection('chats')
                                      .orderBy("time", descending: true)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      // readApply(snapshot, size);

                                      try {
                                        lastChatTime =
                                            snapshot.data!.docs[0]['time'];
                                        secondLastChatMessage =
                                            snapshot.data!.docs[1]['message'] ??
                                                "";
                                        secodLastChatMessageDate = snapshot
                                                .data!.docs[1]['indidate'] ??
                                            "";
                                        secodLastChatMessageTime = snapshot
                                                .data!.docs[1]['inditime'] ??
                                            "";
                                      } catch (e) {
                                        print(e);
                                      }

                                      return ListView.builder(
                                          reverse: true,
                                          shrinkWrap: true,
                                          //controller: _scrollController,
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (context, index) {
                                            Map<String, dynamic> map = snapshot
                                                .data!.docs[index]
                                                .data() as Map<String, dynamic>;

                                            if (map['messageType'] != 2) {
                                              return messageAssigner(
                                                  size, map, context);
                                            } else {
                                              return const SizedBox();
                                            }
                                          });
                                    }
                                  },
                                )),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          height: size.height / 12.9,
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 6,
                              ),
                              SizedBox(
                                height: size.height / 17,
                                width: size.width / 1.25,
                                child: TextFormField(
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        chatIsEmpty = false;
                                        print("Typing");
                                      });
                                    } else {
                                      setState(() {
                                        chatIsEmpty = true;
                                        print("Not typing");
                                      });
                                    }
                                  },
                                  style: const TextStyle(color: Colors.black),
                                  controller: _chats,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    isCollapsed: false,
                                    fillColor: Colors.black,
                                    hintText: "Type here",
                                    hintStyle:
                                        TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              SizedBox(
                                height: size.height / 15,
                                child: FloatingActionButton(
                                  heroTag: 1,
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 0, 0),
                                  child: const Center(
                                    child: Icon(
                                      Icons.send,
                                      size: 30,
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_chats.text.isEmpty) {
                                    } else {
                                      _message = _chats.text;
                                      _chats.clear();
                                      //print(_message);
                                      FirebaseAnalytics.instance
                                          .logEvent(name: "ChatSent");

                                      sendingMessages(_message);
                                      await FirebaseAnalytics.instance
                                          .logEvent(name: "ChatSent");
                                    }
                                    setState(() {
                                      chatIsEmpty = true;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
    );
  }

  // Future readApply(AsyncSnapshot<QuerySnapshot> snapshot, Size size) async {
  //   final QuerySnapshot result = await FirebaseFirestore.instance
  //       .collection('chatted')
  //       .doc(_auth.currentUser!.uid)
  //       .collection("users")
  //       .where('name', isEqualTo: widget.username)
  //       .get();

  //   final List<DocumentSnapshot> documents = result.docs;

  //   if (documents.isNotEmpty) {
  //     _firestore
  //         .collection("chatted")
  //         .doc(_auth.currentUser!.uid)
  //         .collection("users")
  //         .doc(widget.userid)
  //         .update({
  //       "read": true,
  //     });
  //   }
  // }

  Future sendingMessages(String _message) async {
    try {
      _firestore
          .collection("chatted")
          .doc(_auth.currentUser!.uid)
          .collection("users")
          .doc(usermap!["uid"])
          .get()
          .then((value) async {
        if (int.parse(value["indidate"].substring(6)) - inditime.year == 0 &&
            int.parse(value["indidate"].substring(3, 5)) - inditime.month ==
                0 &&
            int.parse(value["indidate"].substring(0, 2)) - inditime.day == 0) {
          Map<String, dynamic> messages = {
            "messageType": 0,
            "sendby": _auth.currentUser!.displayName,
            "idFrom": _auth.currentUser!.uid,
            "idTo": usermap!["uid"],
            "message": _message,
            "sendto": usermap!["firstName"],
            "inditime": DateFormat('hh:mm a').format(inditime),
            "indidate": DateFormat('dd-MM-yyyy').format(inditime),
            "time": FieldValue.serverTimestamp(),
            "reaction": ""
          };

          await _firestore
              .collection('chatroom')
              .doc(widget.chatRoomId)
              .collection('chats')
              .add(messages);
        } else {
          Map<String, dynamic> messages = {
            "messageType": 1,
            "sendby": _auth.currentUser!.displayName,
            "idFrom": _auth.currentUser!.uid,
            "idTo": usermap!["uid"],
            "message": _message,
            "sendto": usermap!["firstName"],
            "inditime": DateFormat('hh:mm a').format(inditime),
            "indidate": DateFormat('dd-MM-yyyy').format(inditime),
            "time": FieldValue.serverTimestamp(),
            "reaction": ""
          };

          await _firestore
              .collection('chatroom')
              .doc(widget.chatRoomId)
              .collection('chats')
              .add(messages);
        }
      });

      //This is for the chatted collection in firestore
      if (_message.isNotEmpty) {
        Map<String, dynamic> userinfo1 = {
          "name": usermap!["firstName"],
          "profileImage": usermap!["profileImage"],
          "time": FieldValue.serverTimestamp(),
          "lastmessage": _message,
          "read": true,
          "id": usermap!["uid"],
          "roomid": widget.chatRoomId,
          "inditime": DateFormat('hh:mm a').format(inditime),
          "indidate": DateFormat('dd-MM-yyyy').format(inditime)
        };

        Map<String, dynamic> userinfo2 = {
          "name": _auth.currentUser!.displayName,
          "profileImage": _auth.currentUser!.photoURL,
          "time": FieldValue.serverTimestamp(),
          "lastmessage": _message,
          "read": false,
          "id": _auth.currentUser!.uid,
          "roomid": widget.chatRoomId,
          "inditime": DateFormat('hh:mm a').format(inditime),
          "indidate": DateFormat('dd-MM-yyyy').format(inditime)
        };

        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('chatted')
            .doc(_auth.currentUser!.uid)
            .collection("users")
            .where('id', isEqualTo: usermap!["uid"])
            .get();

        final List<DocumentSnapshot> documents = result.docs;

        if (documents.isNotEmpty) {
          //for user1
          _firestore
              .collection("chatted")
              .doc(_auth.currentUser!.uid)
              .collection("users")
              .doc(
                usermap!["uid"],
              )
              .update({
            "lastmessage": _message,
            "time": FieldValue.serverTimestamp(),
            "inditime": DateFormat('hh:mm a').format(inditime),
            "indidate": DateFormat('dd-MM-yyyy').format(inditime)
          });
          //for user2
          _firestore
              .collection("chatted")
              .doc(
                usermap!["uid"],
              )
              .collection("users")
              .doc(_auth.currentUser!.uid)
              .update({
            "lastmessage": _message,
            "time": FieldValue.serverTimestamp(),
            "inditime": DateFormat('hh:mm a').format(inditime),
            "indidate": DateFormat('dd-MM-yyyy').format(inditime)
          });
        } else {
          Map<String, dynamic> messages = {
            "messageType": 1,
            "sendby": _auth.currentUser!.displayName,
            "idFrom": _auth.currentUser!.uid,
            "idTo": usermap!["uid"],
            "message": _message,
            "sendto": usermap!["firstName"],
            // "uidOfSendTo": usermap!["uid"],
            "inditime": DateFormat('hh:mm a').format(inditime),
            "indidate": DateFormat('dd-MM-yyyy').format(inditime),
            "time": FieldValue.serverTimestamp(),
          };

          await _firestore
              .collection('chatroom')
              .doc(widget.chatRoomId)
              .collection('chats')
              .add(messages);
          //for user 1
          _firestore
              .collection("chatted")
              .doc(_auth.currentUser!.uid)
              .collection("users")
              .doc(usermap!["uid"])
              .set(userinfo1);
          //for user2
          _firestore
              .collection("chatted")
              .doc(usermap!["uid"])
              .collection("users")
              .doc(_auth.currentUser!.uid)
              .set(userinfo2);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Widget messageAssigner(
      Size size, Map<String, dynamic> map, BuildContext context) {
    if (map['messageType'] == 1) {
      //return dated messgae
      return Column(
        crossAxisAlignment: map['idFrom'] == _auth.currentUser!.uid
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              timeConverter(map['indidate']),
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
          messages(size, map, context)
        ],
      );
    } else if (map['messageType'] == 2) {
      return const SizedBox();
    } else {
      return messages(size, map, context);
    }
  }

  Widget messages(Size size, Map<String, dynamic> map, BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        if (map['idFrom'] != _auth.currentUser!.uid) {
          print("It ain't yours");
          setState(() {
            notPressed = false;
            copiedText = map['message'];
            isItYourChat = false;
          });
        } else {
          try {
            setState(() {
              notPressed = false;
              copiedText = map['message'];
              copiedTextTime = map['time'];
              isItYourChat = true;
            });
          } catch (e) {
            return;
          }
        }
      },
      child: Container(
        width: size.width / 3,
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: map['idFrom'] == _auth.currentUser!.uid
                  ? Alignment.topRight
                  : Alignment.topLeft,
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.80),
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 10),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: map['idFrom'] == _auth.currentUser!.uid
                            ? const Radius.circular(15)
                            : const Radius.circular(30),
                        bottomLeft: map['idFrom'] == _auth.currentUser!.uid
                            ? const Radius.circular(30)
                            : const Radius.circular(15),
                        topLeft: const Radius.circular(30),
                        topRight: const Radius.circular(30)),
                    gradient: map['idFrom'] == _auth.currentUser!.uid
                        ? const LinearGradient(
                            colors: [Colors.blue, Colors.blue],
                            stops: [0.0, 1.0])
                        : const LinearGradient(
                            colors: [Colors.black, Colors.black],
                            stops: [0.0, 1.0])),
                child: Text(
                  map['message'],
                  style: const TextStyle(
                    //fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height / 110),
            Container(
              alignment: map['idFrom'] == _auth.currentUser!.uid
                  ? Alignment.topRight
                  : Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 2, bottom: 2, right: 10),
                child: Text(
                  map["inditime"],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool loadingHere = false;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      backgroundColor: Colors.grey[100],
      title: Center(
        child: Text(
          "Permission Required",
          style: TextStyle(color: Colors.grey[700], fontSize: 24),
        ),
      ),
      content: SizedBox(
        height: size.height / 6,
        width: size.width,
        child: const Text(
          "This is for reporting an abusive user.\n\nBy clicking on allow, you are giving us the permission to review your chats with this user only, in order for us to ban the user.",
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                print("accept");
                setState(() {
                  loadingHere = true;
                });
                _firestore.collection("reports").add({
                  "reporterID": _auth.currentUser!.uid,
                  "abuserID": widget.userid
                });
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red[600],
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                height: size.height / 16,
                width: size.width / 2,
                child: Center(
                  child: loadingHere
                      ? SizedBox(
                          height: size.height / 30,
                          width: size.width / 15,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : const Text(
                          "Allow and Report",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

void snackBar(BuildContext context) {
  const snackbar = SnackBar(
    content: Text(
      "Text Copied",
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black, fontSize: 15),
    ),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.white,
    shape: StadiumBorder(),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 125),
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}



//messageType:
//0-current message
//1-current message on a new day
//2-messages that shouldn't be displayed