import 'package:flutter/material.dart';
import 'package:text_editor/feature/app_layout/app_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppLayout(),
    );
  }
}
