import 'package:promnight/screens/auth/registration/otherinfo.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({Key? key}) : super(key: key);

  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController height = TextEditingController();
  bool isFilled = true;
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(children: [
        Container(
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  fit: BoxFit.cover,
                  opacity: 0.6)),
        ),
        SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          await Future.delayed(Duration(milliseconds: 60));
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey[700],
                        )),
                  ],
                ),
                SizedBox(
                  height: size.height / 50,
                ),
                NeumorphicText(
                  "Basic Info",
                  style: NeumorphicStyle(color: Colors.grey[700]),
                  textStyle: NeumorphicTextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Pacifico"),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: size.height / 20,
                    ),
                    customField(size, false, "First Name", 1.2, firstName),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    customField(size, false, "Last Name", 1.2, lastName),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customField(size, false, "Age", 2.5, age),
                        const SizedBox(
                          width: 15,
                        ),
                        customField(size, false, "Height (in cm)", 2.5, height),
                      ],
                    ),
                    Text(
                      errorText,
                      style: TextStyle(
                          color: Colors.red.withOpacity(0.7),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (firstName.text.isNotEmpty &&
                                lastName.text.isNotEmpty &&
                                age.text.isNotEmpty &&
                                height.text.isNotEmpty) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CollegeInfo(
                                            firstName: firstName.text
                                                .replaceAll(' ', ''),
                                            lastName: lastName.text
                                                .replaceAll(' ', ''),
                                            age: age.text.replaceAll(' ', ''),
                                            height:
                                                height.text.replaceAll(' ', ''),
                                          )));
                            } else {
                              setState(() {
                                isFilled = false;
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
                                color: Colors.red[600],
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
                            child: const Center(
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget customField(Size size, bool val, String text, double width,
      TextEditingController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width / width,
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
              controller: controller,
              onChanged: (value) {},
              obscureText: val,
              style: const TextStyle(
                color: Colors.black,
              ),
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
