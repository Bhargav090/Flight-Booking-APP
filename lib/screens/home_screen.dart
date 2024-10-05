// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:jmrinfotech/screens/bottom_img.dart';
import 'package:jmrinfotech/screens/search_fileds.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedButton = 1;
  String selectedTripType = 'One Way';

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC4E59E),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {},
                ),
                Text('Search Flights'),
              ],
            ),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Image at the bottom
                Image.asset(
                  'assets/mainimg.png',
                  height: 150,
                  width: double.infinity, 
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    "Let's start your trip",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -25, 
                  left: (width - width * 0.85) / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildButton('Round Trip', 0, isLeft: true),
                      buildButton('One Way', 1), 
                      buildButton('Multi-city', 2, isRight: true),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.08),
            SearchFieldsScreen(selectedButton: selectedTripType),
            SizedBox(height: height * 0.08),
            BottomImages(),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String buttonText, int index, {bool isLeft = false, bool isRight = false}) {
    final double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedButton = index;
          selectedTripType = buttonText;
        });
      },
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          color: selectedButton == index ? Color(0xFF63AF23) : Colors.white,
          borderRadius: BorderRadius.horizontal(
            left: isLeft ? Radius.circular(14) : Radius.zero,
            right: isRight ? Radius.circular(14) : Radius.zero,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), 
              offset: Offset(0, 4), 
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: selectedButton == index ? Colors.white : Colors.black,
              fontSize: height * 0.016,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
