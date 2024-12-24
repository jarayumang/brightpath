import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:brightspot/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountInformation extends StatelessWidget {
  const AccountInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'No user is logged in.',
            style: GoogleFonts.gabarito(
              textStyle: const TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        ),
      );
    }

    final userId = user.uid;

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
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
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
                'Save Changes',
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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching user data.'),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text('No user data available.'),
            );
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: AppColors.lightGreen,
                child: Text(
                  'Account Information',
                  style: GoogleFonts.gabarito(
                    textStyle: const TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        letterSpacing: 0.5),
                  ),
                ),
              ),
              buildTextField(
                  'Email address', userData['email_address'] ?? 'N/A'),
              buildTextField('Full Name', userData['full_name'] ?? 'N/A'),
              buildTextField('Phone Number',
                  (userData['phone_number'] ?? 'N/A').toString()),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Delete account',
                  style: GoogleFonts.gabarito(
                    textStyle: const TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Your account will be permanently removed from the application. All your data will be lost.',
                    style: GoogleFonts.gabarito(
                      textStyle: const TextStyle(
                          color: AppColors.lightGray,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.errorBackground,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      print("Delete Account button pressed");
                    },
                    child: Text(
                      'Delete Account',
                      style: GoogleFonts.gabarito(
                        textStyle: const TextStyle(
                          color: AppColors.errorText,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildTextField(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.gabarito(
              textStyle: const TextStyle(
                  color: AppColors.lightGray,
                  fontWeight: FontWeight.bold,
                  fontSize: 10),
            ),
          ),
          TextField(
            readOnly: true,
            controller: TextEditingController(text: value),
            style: const TextStyle(
              fontSize: 12,
              height: 1.2,
              color: Colors.black,
            ),
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(bottom: 10, top: 10),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.lightGray,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.darkGreen,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
