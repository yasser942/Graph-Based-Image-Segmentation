import 'package:flutter/material.dart';
import 'package:image_segmenter/screens/onboarding.dart';
import 'package:image_segmenter/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xffC53F3F),
        ),
        useMaterial3: true,
      ),
      home:  const SplashScreen(),
    );
  }
}
