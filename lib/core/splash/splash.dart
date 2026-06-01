import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie/core/database/cachehelper.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      if ( Cachehelper.contain(key: 'email') == true) {
        Navigator.pushNamed(context,'display',);
      } else {
        Navigator.pushNamed(context,'onboarding',);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/Movie Theatre.json'),
            SizedBox(height: 60),
            CircularProgressIndicator(strokeWidth: 2),
          ],
        ),
      ),
    );
  }
}
