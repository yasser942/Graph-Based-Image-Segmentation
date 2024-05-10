import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:image_segmenter/screens/home.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final List<Introduction> list = [
    Introduction(
      title: 'Welcome',
      subTitle: 'Welcome to Image Segmenter',
      imageUrl: 'assets/Image folder.gif',
    ),
    Introduction(
      title: 'Image Analysis',
      subTitle: 'Analyze your image with Image Segmenter',
      imageUrl: 'assets/Image upload.gif',
    ),
    Introduction(
      title: 'Get Started',
      subTitle: 'Get started with Image Segmenter',
      imageUrl: 'assets/Image viewer.gif',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return IntroScreenOnboarding(
      backgroudColor: Colors.white,
      skipTextStyle: const TextStyle(color: Color(0xffC53F3F)),
      introductionList: list,
      onTapSkipButton: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ), //MaterialPageRoute
        );
      },
    );
  }
}
