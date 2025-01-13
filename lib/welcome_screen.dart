import 'package:flutter/material.dart';


void main() {
  runApp(WelcomeScreen());
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        padding: EdgeInsets.only(top: 100, bottom: 40),
        decoration: BoxDecoration(
          color: Colors.pinkAccent,
          image: DecorationImage(
            image: AssetImage("asset\OIP-removebg-preview.png"),
            fit: BoxFit.cover, 
          ),
        ),
      ),
    );
  }
}
