import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:brightspot/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReportIssue extends StatelessWidget {
  const ReportIssue({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userId = user!.uid;
    final TextEditingController issueController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: AppColors.lightGreen,
          leading: IconButton(
            icon: const Icon(
              HugeIcons.strokeRoundedArrowLeft01,
              color: AppColors.black,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            border: Border(
              top: BorderSide(
                color: AppColors.borderGray,
                width: 1.0,
              ),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  print("Save Changes button pressed");
                },
                child: Text(
                  'Submit',
                  style: GoogleFonts.gabarito(
                    textStyle: const TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: AppColors.lightGreen,
              child: Text(
                'Report an issue',
                style: GoogleFonts.gabarito(
                  textStyle: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      letterSpacing: 0.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
              child: Text(
                'Report your issue',
                style: GoogleFonts.gabarito(
                  textStyle: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20, right: 50),
                child: Text(
                  'Your feedback is invaluable in ensuring we deliver the best experience possible.',
                  style: GoogleFonts.gabarito(
                    textStyle: const TextStyle(
                        color: AppColors.lightGray,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                )),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: issueController,
                maxLines: 15,
                style: TextStyle(fontSize: 11),
                decoration: InputDecoration(
                  hintText: 'Describe your issue here...',
                  hintStyle: const TextStyle(color: AppColors.lightGray),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.borderGray),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.lightGreen),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
