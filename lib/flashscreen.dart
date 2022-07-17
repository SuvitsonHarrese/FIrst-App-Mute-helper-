import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mute_help/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNav(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.only(bottom: 250),
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 80,),
            Image.asset(
              'images/Helper.png',
              // width: 500,
              // height: 500,
              // fit: BoxFit.cover,
            ),
            SizedBox(
              height: 220,
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
            ),
            // SizedBox(height: 218,),
          ],
        ),
      ),
    );
  }
}
