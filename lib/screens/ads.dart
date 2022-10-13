import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AdsDisplay extends StatefulWidget {
  Map<String, dynamic>? adsuserMap;
  bool ads;
  AdsDisplay({Key? key, required this.adsuserMap, required this.ads})
      : super(key: key);

  @override
  State<AdsDisplay> createState() => _AdsDisplayState();
}

class _AdsDisplayState extends State<AdsDisplay> {
  @override
  Widget build(BuildContext context) {
    return widget.ads
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 8),
                child: Center(
                  child: Text(
                    "Some exciting offers!",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]),
                  ),
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),

                //The items of the carousel

                items: [
                  ad(widget.adsuserMap!["ad1Link"],
                      widget.adsuserMap!["ad1Image"]),
                  ad(widget.adsuserMap!["ad2Link"],
                      widget.adsuserMap!["ad2Image"]),
                  ad(widget.adsuserMap!["ad3Link"],
                      widget.adsuserMap!["ad3Image"]),
                  ad(widget.adsuserMap!["ad4Link"],
                      widget.adsuserMap!["ad4Image"]),
                  ad(widget.adsuserMap!["ad5Link"],
                      widget.adsuserMap!["ad5Image"]),
                ],
              ),
            ],
          )
        : SizedBox();
  }

  Widget ad(String adLink, String adImage) {
    return GestureDetector(
      onTap: () {
        //Open the link
      },
      child: Container(
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: NetworkImage(adImage), fit: BoxFit.fill))),
    );
  }

  // nullChecker(String photoUrl) {
  //   try {
  //     return NetworkImage(photoUrl);
  //   } catch (e) {
  //     return const AssetImage("assets/main.png");
  //   }
  // }
}
