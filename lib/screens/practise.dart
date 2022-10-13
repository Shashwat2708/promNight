import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.42,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 25),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/wallpaper.png"),
                          fit: BoxFit.fill)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: const Text(
                        "Melena Veronica, 23",
                        style: TextStyle(
                            fontFamily: "Proxima-Nova-Extrabold",
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ClipOval(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration:
                            const BoxDecoration(color: Color(0xFF15D374)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: const Text(
                    "Fashion Designer at Victoria Secret",
                    style: TextStyle(
                        fontFamily: "ProximaNova-Regular",
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: const Text(
                    "69m Away",
                    style: TextStyle(
                        fontFamily: "ProximaNova-Regular",
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: const Text(
                    "About Me",
                    style: TextStyle(
                        fontFamily: "Proxima-Nova-Bold",
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 30),
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: const Text(
                    "Hey guys, This is Malena. I’m here to find someone for hookup. I’m not interested in something serious. I would love to hear your adventurous story.",
                    style: TextStyle(
                        fontFamily: "ProximaNova-Regular",
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: const Text(
                    "Interests",
                    style: TextStyle(
                        fontFamily: "Proxima-Nova-Bold",
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                  ),
                  child: Wrap(
                    children: [
                      Container(
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0xFFFFE9E6).withOpacity(0.25)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 7, bottom: 7),
                            child: Text(
                              "Travel",
                              style: TextStyle(
                                  fontFamily: "ProximaNova-Regular",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0xFF33C0FF).withOpacity(0.25)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 7, bottom: 7),
                            child: Text(
                              "Dance",
                              style: TextStyle(
                                  fontFamily: "ProximaNova-Regular",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0xFFFF9933).withOpacity(0.25)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 7, bottom: 7),
                            child: Text(
                              "Fitness",
                              style: TextStyle(
                                  fontFamily: "ProximaNova-Regular",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0xFF5985FF).withOpacity(0.25)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 7, bottom: 7),
                            child: Text(
                              "Reading",
                              style: TextStyle(
                                  fontFamily: "ProximaNova-Regular",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          height: 30,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0xFF9933FF).withOpacity(0.25)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 7, bottom: 7),
                            child: Text(
                              "Photography",
                              style: TextStyle(
                                  fontFamily: "ProximaNova-Regular",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          height: 30,
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0xFF12B2B2).withOpacity(0.25)),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 7, bottom: 7),
                            child: Text(
                              "Music",
                              style: TextStyle(
                                  fontFamily: "ProximaNova-Regular",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 30),
                  child: const Text(
                    "Instagram Photos",
                    style: TextStyle(
                        fontFamily: "Proxima-Nova-Bold",
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.09,
            top: MediaQuery.of(context).size.height * 0.07,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.black,
              ),
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.05,
            top: MediaQuery.of(context).size.height * 0.08,
            child: const Icon(
              Icons.more_horiz,
              size: 20,
              color: Colors.black,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.15,
            child: FloatingActionButton(
              onPressed: () {},
              heroTag: "cross_2",
              backgroundColor: Colors.white,
              elevation: 10,
              child: const Icon(
                Icons.close,
                color: Color(0xFFA29FBE),
                size: 28,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.44,
            child: FloatingActionButton(
              onPressed: () {},
              heroTag: "love_2",
              backgroundColor: Colors.white,
              elevation: 10,
              child: const Icon(
                Icons.star,
                color: Color(0xFF4DD5FF),
                size: 20,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            right: MediaQuery.of(context).size.width * 0.15,
            child: FloatingActionButton(
              onPressed: () {},
              heroTag: "heart_2",
              backgroundColor: Colors.white,
              elevation: 10,
              child: const Icon(
                Icons.favorite,
                color: Color(0xFFFF636B),
                size: 24,
              ),
            ),
          )
        ],
      ),
    ));
  }
}
