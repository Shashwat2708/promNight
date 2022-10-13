import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:promnight/screens/dashboard.dart';

class Guide extends StatelessWidget {
  const Guide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            height: size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.png"),
                    fit: BoxFit.cover,
                    opacity: 0.4)),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height / 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width / 50,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                Text(
                  "How to use the app?",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      fontFamily: "Pacifico"),
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: size.height / 1.3,
                        width: size.width / 1.1,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 21),
                                  child: Text(
                                    "Follow the steps to get the premium",
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 21),
                                  ),
                                ),
                              ],
                            ),

                            //Step-1
                            SizedBox(
                              height: size.height / 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width / 30,
                                ),
                                NeumorphicText(
                                  "Step - 1",
                                  style:
                                      NeumorphicStyle(color: Colors.grey[700]),
                                  textStyle: NeumorphicTextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Pacifico"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height / 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width / 30,
                                ),
                                SizedBox(
                                  width: size.width / 1.2,
                                  child: Text(
                                    "Click on the red box to start looking for a random match. We have made the entire match system random because we wanted everyone to get a chance. ",
                                    maxLines: 4,
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Container(
                                height: size.height / 2.4,
                                width: size.width / 1.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        image: AssetImage("assets/1.png"),
                                        fit: BoxFit.fill)),
                              ),
                            ),

                            //Step-2
                            SizedBox(
                              height: size.height / 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width / 30,
                                ),
                                NeumorphicText(
                                  "Step - 2",
                                  style:
                                      NeumorphicStyle(color: Colors.grey[700]),
                                  textStyle: NeumorphicTextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Pacifico"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height / 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width / 30,
                                ),
                                SizedBox(
                                  width: size.width / 1.2,
                                  child: Text(
                                    "If you see this page, it means that you will find a match very soon.",
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Container(
                                height: size.height / 2.4,
                                width: size.width / 1.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        image: AssetImage("assets/2.png"),
                                        fit: BoxFit.fill)),
                              ),
                            ),

                            //Step-3
                            SizedBox(
                              height: size.height / 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width / 30,
                                ),
                                NeumorphicText(
                                  "Step - 3",
                                  style:
                                      NeumorphicStyle(color: Colors.grey[700]),
                                  textStyle: NeumorphicTextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Pacifico"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height / 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width / 30,
                                ),
                                SizedBox(
                                  width: size.width / 1.2,
                                  child: Text(
                                    "While waiting, you can find your friends by searching via email or learn about the premium feature. ",
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Container(
                                height: size.height / 3,
                                width: size.width / 1.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        image: AssetImage("assets/3.png"),
                                        fit: BoxFit.fill)),
                              ),
                            ),

                            //Step-4
                            SizedBox(
                              height: size.height / 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width / 30,
                                ),
                                NeumorphicText(
                                  "Step - 4",
                                  style:
                                      NeumorphicStyle(color: Colors.grey[700]),
                                  textStyle: NeumorphicTextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Pacifico"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height / 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width / 30,
                                ),
                                SizedBox(
                                  width: size.width / 1.2,
                                  child: Text(
                                    "If you see this page, this would mean that you have found a random match. You can view their profile or chat with them. ",
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Container(
                                height: size.height / 2.2,
                                width: size.width / 1.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        image: AssetImage("assets/4.png"),
                                        fit: BoxFit.fill)),
                              ),
                            ),

                            //Step-5
                            SizedBox(
                              height: size.height / 60,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width / 30,
                                ),
                                NeumorphicText(
                                  "Step - 5",
                                  style:
                                      NeumorphicStyle(color: Colors.grey[700]),
                                  textStyle: NeumorphicTextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Pacifico"),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height / 100,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width / 30,
                                ),
                                SizedBox(
                                  width: size.width / 1.2,
                                  child: Text(
                                    "You will see find the next button which will help you find another person only after 3 hours of you both matching",
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Center(
                              child: Container(
                                height: size.height / 2.4,
                                width: size.width / 1.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                        image: AssetImage("assets/5.png"),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                          ]),
                        )),
                  ),
                ),
                SizedBox(
                  height: size.height / 10,
                )
              ],
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));
          },
          backgroundColor: const Color(0xffff1616),
          child: const Text(
            "Done",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
