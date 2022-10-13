import 'package:promnight/screens/auth/registration/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CollegeInfo extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String age;
  final String height;
  const CollegeInfo(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.age,
      required this.height})
      : super(key: key);

  @override
  State<CollegeInfo> createState() => _CollegeInfoState();
}

class _CollegeInfoState extends State<CollegeInfo> {
  var gender = ["Male", "Female"];
  String genderVal = "Male";
  final course = ["B.Tech", "BAJMC", "BBA", "LLB", "B.Sc.", "BCA", "Others"];
  String courseVal = "B.Tech";
  final year = ["2017", "2018", "2019", "2020", "2021", "2022"];
  String yearVal = "2022";
  final pref = ["Friendship", "Relationship"];
  String prefVal = "Friendship";

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
                  height: size.height / 40,
                ),
                NeumorphicText(
                  "Other Info",
                  style: NeumorphicStyle(color: Colors.grey[700]),
                  textStyle: NeumorphicTextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Pacifico"),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    " We respect and acknowledge the LGBTQ community but due to imporper sex ration, we were forced to give option of only male and female gender.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //For the gender
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 12, left: 9),
                              child: Text("Gender",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: size.height / 15,
                              width: size.width / 3,
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
                                padding: const EdgeInsets.all(12),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    borderRadius: BorderRadius.circular(30),
                                    dropdownColor: Colors.grey[100],
                                    isExpanded: true,
                                    items:
                                        gender.map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValueSelected) {
                                      // Your code to execute, when a menu item is selected from drop down
                                      setState(() {
                                        genderVal = newValueSelected!;
                                      });
                                    },
                                    value: genderVal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 12,
                        ),

                        //For the year
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 12, left: 9),
                              child: Text("Year",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              height: size.height / 15,
                              width: size.width / 3,
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
                                padding: const EdgeInsets.all(12),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    borderRadius: BorderRadius.circular(30),
                                    dropdownColor: Colors.grey[100],
                                    isExpanded: true,
                                    items:
                                        year.map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(dropDownStringItem),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValueSelected) {
                                      // Your code to execute, when a menu item is selected from drop down
                                      setState(() {
                                        yearVal = newValueSelected!;
                                      });
                                    },
                                    value: yearVal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 24,
                    ),

                    //For the course
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 12, left: 9),
                          child: Text("Course",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          height: size.height / 15,
                          width: size.width / 1.5,
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
                            padding: const EdgeInsets.all(12),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(30),
                                dropdownColor: Colors.grey[100],
                                isExpanded: true,
                                items: course.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                  );
                                }).toList(),
                                onChanged: (String? newValueSelected) {
                                  // Your code to execute, when a menu item is selected from drop down
                                  setState(() {
                                    courseVal = newValueSelected!;
                                  });
                                },
                                value: courseVal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 24,
                    ),

                    //For the preference
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 12, left: 9),
                          child: Text("What are you looking for?",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          height: size.height / 15,
                          width: size.width / 1.5,
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
                            padding: const EdgeInsets.all(12),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(30),
                                dropdownColor: Colors.grey[100],
                                isExpanded: true,
                                items: pref.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                  );
                                }).toList(),
                                onChanged: (String? newValueSelected) {
                                  // Your code to execute, when a menu item is selected from drop down
                                  setState(() {
                                    prefVal = newValueSelected!;
                                  });
                                },
                                value: prefVal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 15,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register(
                                          firstName: widget.firstName,
                                          lastName: widget.lastName,
                                          age: widget.age,
                                          height: widget.height,
                                          gender: genderVal,
                                          course: courseVal,
                                          year: yearVal,
                                          pref: prefVal,
                                        )));
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );
}
