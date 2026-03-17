import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'theme/combine_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Combine Overwatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: CombineColors.bgDark,
      ),
      home: const HomePage(),
    );
  }
}
