import 'package:flutter/material.dart';
import 'package:brightspot/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Home',
          style: GoogleFonts.gabarito(
            textStyle: const TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 0.5),
          ),
        ),
        backgroundColor: AppColors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 25, 15, 25),
        child: SafeArea(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('test')],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
