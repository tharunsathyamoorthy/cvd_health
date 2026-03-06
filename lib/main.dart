import 'package:flutter/material.dart';
import 'screens/input_screen.dart';

void main() {
  runApp(const CardioApp());
}

class CardioApp extends StatelessWidget {
  const CardioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cardio Prediction',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const InputScreen(),
    );
  }
}
