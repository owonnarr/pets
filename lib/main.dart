import 'package:flutter/material.dart';
import 'package:pets/providers/PetProvider.dart';
import 'package:pets/screens/PetScreen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PetProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PetScreen(),
    );
  }
}