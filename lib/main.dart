import 'package:flutter/material.dart';
import 'package:progress_bar_circular/pages/circular_progress_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Circular Progress Bar',
      home: CircularProgressPage(),
    );
  }
}
