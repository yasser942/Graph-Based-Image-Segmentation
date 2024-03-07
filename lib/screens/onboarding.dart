import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:image_segmenter/screens/home.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final List<Introduction> list = [
    Introduction(
      title: 'Welcome',
      subTitle: 'Early Parkinson\'s detection',
      imageUrl: 'assets/Image folder.gif',
    ),
    Introduction(
      title: 'Image Analysis',
      subTitle: 'Analyzing spiral and wave images',
      imageUrl: 'assets/Image upload.gif',
    ),
    Introduction(
      title: 'Get Started',
      subTitle: 'Begin your journey',
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
            builder: (context) => HomePage(),
          ), //MaterialPageRoute
        );
      },
    );
  }
}
