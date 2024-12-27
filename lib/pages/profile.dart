import 'package:brightspot/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'settings/account_information.dart';
import 'settings/address_information.dart';
import 'settings/appearance.dart';
import 'settings/notification.dart';
import 'settings/report_issue.dart';
import 'settings/faq.dart';
import 'package:brightspot/auth/login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'Settings',
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
                  buildSettingHeader('General'),
                  const SizedBox(
                    height: 10,
                  ),
                  buildSettingChoice(context, HugeIcons.strokeRoundedUser,
                      'Account Information', AccountInformation()),
                  buildSettingChoice(context, HugeIcons.strokeRoundedLocation01,
                      'Address Information', AddressInformation()),
                  buildSettingChoice(context, HugeIcons.strokeRoundedPaintBoard,
                      'Appearance', Appearance()),
                  buildSettingChoice(
                      context,
                      HugeIcons.strokeRoundedNotification03,
                      'Notifications',
                      Notifications()),
                  const SizedBox(
                    height: 30,
                  ),
                  buildSettingHeader('Support'),
                  const SizedBox(
                    height: 10,
                  ),
                  buildSettingChoice(context, HugeIcons.strokeRoundedBug02,
                      'Report an issue', ReportIssue()),
                  buildSettingChoice(
                      context, HugeIcons.strokeRoundedHelpCircle, 'FAQ', FAQ()),
                  buildLogoutChoice(
                      context, HugeIcons.strokeRoundedLogout01, 'Logout'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLogoutChoice(
      BuildContext context, IconData choiceIcon, String choiceText) {
    return GestureDetector(
      onTap: () async {
        await FirebaseAuth.instance.signOut();
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.borderGray,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  HugeIcon(
                    icon: choiceIcon,
                    size: 20,
                    color: AppColors.black,
                  ),
                  const SizedBox(width: 10),
                  Text(choiceText,
                      style: GoogleFonts.gabarito(
                        textStyle: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w200,
                            fontSize: 14),
                      )),
                ],
              ),
              const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                color: AppColors.black,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSettingChoice(BuildContext context, IconData choiceIcon,
      String choiceText, Widget nextPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextPage),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.borderGray,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  HugeIcon(
                    icon: choiceIcon,
                    size: 20,
                    color: AppColors.black,
                  ),
                  const SizedBox(width: 10),
                  Text(choiceText,
                      style: GoogleFonts.gabarito(
                        textStyle: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w200,
                            fontSize: 14),
                      )),
                ],
              ),
              const HugeIcon(
                icon: HugeIcons.strokeRoundedArrowRight01,
                color: AppColors.black,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text buildSettingHeader(headerText) {
    return Text(headerText,
        style: GoogleFonts.gabarito(
          textStyle: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ));
  }
}
