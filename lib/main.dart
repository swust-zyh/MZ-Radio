import 'package:mzradio/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mzradio/pages/loading.dart';
import 'package:mzradio/pages/login.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent)); // 头部状态栏设置为透明
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily
      ),
      home: LoadPage(),
    );
  }
}