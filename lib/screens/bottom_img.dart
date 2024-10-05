// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BottomImages extends StatefulWidget {
  const BottomImages({super.key});

  @override
  State<BottomImages> createState() => _BottomImagesState();
}

class _BottomImagesState extends State<BottomImages> {
  Widget buildImageWithText(String imagePath, String text1, String text2) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02), 
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13.0),
            child: Image.asset(
              imagePath,
              width: width * 0.5,
              height: height * 0.35,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 70, 
            left: 10, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: TextStyle(
                    fontSize: height*0.018,
                    color: Colors.white,
                  ),
                ),
                Text(
                  text2,
                  style: TextStyle(
                    fontSize: height*0.023,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: height * 0.02, right: height * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Travel Inspiration',
                style: TextStyle(fontSize: height*0.02, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    'Dubai',
                    style: TextStyle(fontSize: height*0.02, color: Colors.black54),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          height: height * 0.4,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              buildImageWithText('assets/bt-1.png', 'Explore', 'Nature'),
              buildImageWithText('assets/bt-2.png', 'Discover', 'Cities'),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left:height*0.02),
          child: Text('Flights & Hotel Packages',style: TextStyle(fontSize: height*0.02, color: Colors.black,fontWeight: FontWeight.bold),),
        ),
        Padding(
          padding: EdgeInsets.all(height*0.01),
          child: Image.asset('assets/downimg.png'),
        )
      ],
    );
  }
}
