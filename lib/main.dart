import 'package:flutter/material.dart';
import 'package:seenight_game/screen/game_screen.dart';

void main() {
  runApp(const SeeNightApp());
}

class SeeNightApp extends StatelessWidget {
  const SeeNightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SeeNight: Be Brave',
      home: GameScreen(),
    );
  }
}
