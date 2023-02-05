import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rentalapp/stream_builder.dart';

class Mysplashscreen extends StatefulWidget {
  const Mysplashscreen({Key? key}) : super(key: key);

  @override
  State<Mysplashscreen> createState() => _MysplashscreenState();
}

class _MysplashscreenState extends State<Mysplashscreen> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => const StreamWidget()),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/userinfo/splash_screen.png"),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Welcome",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white10,
                  fontSize: 40,
                  fontFamily: "Schyler",
                  letterSpacing: 3,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
