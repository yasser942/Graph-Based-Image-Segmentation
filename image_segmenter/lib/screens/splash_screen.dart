import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_segmenter/screens/onboarding.dart';
import 'package:lottie/lottie.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash:
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LottieBuilder.asset('assets/splash.json',),
          ),
          const SizedBox(height: 20,),
          const Text('Image Segmenter', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),

        ],
       ),
         splashIconSize: 400,
         nextScreen: IntroductionScreen());
  }
}
