import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          "assets/shopping-cart.json",
          repeat: false,
          frameRate: FrameRate(60),
          width: 200,
          onLoaded: (p0) => Timer(
            Duration(milliseconds: (p0.seconds * 1000).floor()),
            () => Navigator.of(context).pushReplacementNamed("/"),
          ),
        ),
      ),
    );
  }
}
