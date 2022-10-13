import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class InTheDB extends StatefulWidget {
  const InTheDB({Key? key}) : super(key: key);

  @override
  State<InTheDB> createState() => _InTheDBState();
}

class _InTheDBState extends State<InTheDB> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: size.width / 1.2,
        decoration: BoxDecoration(
            // image: const DecorationImage(
            //   image: AssetImage('assets/wallpaper.png'),
            //   fit: BoxFit.cover,
            // ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: const [
              //Bottom right shadow will be darker
              BoxShadow(
                  color: Color.fromARGB(255, 186, 186, 186),
                  offset: Offset(0, 0),
                  blurRadius: 15),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height / 40,
            ),
            Text(
              "Only A Few Moments!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            NeumorphicIcon(
              CupertinoIcons.heart_fill,
              size: 150,
              style: const NeumorphicStyle(
                color: Colors.red, //customize color here
              ),
            ),
            SizedBox(
              height: size.height / 150,
            ),
            Text(
              "You are in our database.\n We will soon find a random match for you.\nCheck back after a while.",
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: size.height / 40,
            ),
          ],
        ),
      ),
    );
  }
}
