import 'package:flutter/material.dart';
import 'ui/screens/categories.dart';


void main() {
  runApp(const Tasty());
}

class Tasty extends StatelessWidget {
  const Tasty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
