import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//  splash screen
class SplashScreen extends StatelessWidget {
  static const String route = "splash_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Currency", style: GoogleFonts.pacifico(fontSize: 30))),
        ],
      ),
    );
  }
}
