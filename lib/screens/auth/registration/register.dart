import 'package:promnight/methods/authcheck.dart';
import 'package:promnight/methods/firebasemethods.dart';
import 'package:promnight/screens/auth/registration/terms.dart';
import 'package:promnight/screens/dashboard.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Register extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String age;
  final String height;
  final String gender;
  final String course;
  final String year;
  final String pref;

  const Register(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.age,
      required this.height,
      required this.gender,
      required this.course,
      required this.year,
      required this.pref})
      : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController email = TextEditingController();
  TextEditingController pass1 = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  bool isLoading = false;
  final Terms _tnc = Terms();

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
                        onPressed: () {
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
                  "Finally",
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
                    customField(size, false, "Bennett Email", 1.2, email),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    customField(size, true, "Password", 1.2, pass1),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    customField(size, true, "Re-enter Password", 1.2, pass2),
                    SizedBox(
                      height: size.height / 15,
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
                            try {
                              if (email.text.isNotEmpty &&
                                  pass1.text.isNotEmpty &&
                                  pass2.text.isNotEmpty) {
                                if (email.text
                                        .split("@")[1]
                                        .replaceAll(" ", "") !=
                                    "bennett.edu.in") {
                                  setState(() {
                                    errorText =
                                        "Only Bennett University email allowed";
                                  });
                                } else {
                                  print(email.text.length);
                                  if (pass1.text == pass2.text) {
                                    if (pass1.text.length < 8) {
                                      setState(() {
                                        errorText =
                                            "Password should be more than 8 characters";
                                      });
                                    } else {
                                      if (email.text.length >= 26) {
                                        if (emailValidater(email.text
                                            .toLowerCase()
                                            .substring(0, 3))) {
                                          setState(() {
                                            errorText = "";
                                          });
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                _buildPopupDialog(context),
                                          );
                                        } else {
                                          setState(() {
                                            errorText =
                                                "Not an existing Bennett Email ID";
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          errorText =
                                              "Not an existing Bennett Email ID";
                                        });
                                      }
                                    }
                                  } else {
                                    setState(() {
                                      errorText = "Passwords do not match";
                                    });
                                  }
                                }
                              }
                            } catch (e) {
                              print(e);
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
                            child: Center(
                              child: isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.grey[100],
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

  Widget _buildPopupDialog(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool loadingHere = false;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      backgroundColor: Colors.grey[100],
      title: Text(
        "Terms and Conditions",
        style: TextStyle(color: Colors.grey[700]),
      ),
      content: SizedBox(
        height: size.height / 2,
        width: size.width,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _tnc.termsAndConditions.length,
          itemBuilder: (context, index) {
            return Text(_tnc.termsAndConditions[index],
                style: TextStyle(
                  color: Colors.grey[700],
                ));
          },
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                setState(() {
                  loadingHere = true;
                });
                await createAccount(
                        widget.firstName,
                        widget.lastName,
                        email.text.toLowerCase(),
                        pass1.text,
                        widget.age,
                        widget.height,
                        widget.course,
                        widget.year,
                        widget.gender,
                        widget.pref)
                    .then((value) async {
                  if (value != null) {
                    setState(() {
                      loadingHere = true;
                    });
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AuthenticateCheck()));
                  } else {
                    setState(() {
                      isLoading = false;
                      errorText = "Some error occured";
                    });
                    Navigator.pop(context);
                  }
                  await FirebaseAnalytics.instance
                      .logEvent(name: "UserRegistered");
                });
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
                          "I Accept and Register",
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

  bool emailValidater(String emailFormat) {
    List emailFormats = [
      "e17",
      "e18",
      "e19",
      "e20",
      "e21",
      "e22",
      "m17",
      "m18",
      "m19",
      "m20",
      "m21",
      "m22",
      "t17",
      "t18",
      "t19",
      "t20",
      "t21",
      "t22",
      "l17",
      "l18",
      "l19",
      "l20",
      "l21",
      "l22",
      "la17",
      "la18",
      "la19",
      "la20",
      "la21",
      "la22",
    ];
    if (emailFormats.contains(emailFormat)) {
      return true;
    } else {
      return false;
    }
  }
}
