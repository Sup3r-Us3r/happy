import 'package:flutter/material.dart';
import 'package:mobile_flutter/screens/home_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Happy',
    home: HomeScreen(),
    theme: ThemeData(
      fontFamily: 'Nunito',
      primaryColor: Color(0xFFF9FAFC),
      accentColor: Color(0xFF15C3D6),
      backgroundColor: Color(0xFFF2F3F5),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
    ),
  ));
}
