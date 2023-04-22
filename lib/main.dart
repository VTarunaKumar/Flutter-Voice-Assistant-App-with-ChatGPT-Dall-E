import 'package:flutter/material.dart';
import 'package:flutter_voice_assistant_chatgpt_dall_e/home_page.dart';
import 'package:flutter_voice_assistant_chatgpt_dall_e/pallete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jarvis',
      theme: ThemeData.light(useMaterial3: true).copyWith(scaffoldBackgroundColor: Pallete.whiteColor),
      home: const HomePage(),
    );
  }
}
