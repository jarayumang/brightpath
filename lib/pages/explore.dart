import 'package:brightspot/pages/explore/centers.dart';
import 'package:brightspot/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:brightspot/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Explore',
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
                children: [
                  Text('Places',
                      style: GoogleFonts.gabarito(
                        textStyle: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: [
                        buildPageContainer('Therapy Centers',
                            HugeIcons.strokeRoundedSchool01, context),
                        buildPageContainer('Playgrounds',
                            HugeIcons.strokeRoundedBasketball02, context),
                        buildPageContainer(
                            'Schools', HugeIcons.strokeRoundedSchool, context),
                        buildPageContainer('Hospitals',
                            HugeIcons.strokeRoundedHospital02, context),
                      ],
                    ),
                  ),
                  Text('People',
                      style: GoogleFonts.gabarito(
                        textStyle: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: [
                        buildPageContainer('Doctors',
                            HugeIcons.strokeRoundedDoctor01, context),
                        buildPageContainer('Therapist',
                            HugeIcons.strokeRoundedDoctor03, context),
                        buildPageContainer('Organizations',
                            HugeIcons.strokeRoundedCity02, context),
                      ],
                    ),
                  ),
                  Text('Events',
                      style: GoogleFonts.gabarito(
                        textStyle: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: [
                        buildPageContainer('Consultations',
                            HugeIcons.strokeRoundedComputerVideo, context),
                        buildPageContainer('Playdates',
                            HugeIcons.strokeRoundedFootball, context),
                        buildPageContainer('Trainings',
                            HugeIcons.strokeRoundedMentoring, context),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed functionality here, like opening a map screen
          print('Map button tapped');
        },
        backgroundColor: AppColors.lightGreen,
        child: const Icon(
          HugeIcons.strokeRoundedMapsLocation01, // The map icon
          size: 30,
          color: AppColors.black,
        ),
      ),
    );
  }

  Widget buildPageContainer(String label, IconData icon, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CentersList()),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          // Border color
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        child: Column(
          children: [
            HugeIcon(
              icon: icon,
              size: 20,
              color: AppColors.black,
            ),
            // Your desired icon
            SizedBox(width: 8),
            // Space between icon and text
            Text(
              label,
              style: GoogleFonts.gabarito(
                textStyle: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w200,
                  fontSize: 10,
                ),
              ),
            ),
            // Your text
          ],
        ),
      ),
    );
  }
}
