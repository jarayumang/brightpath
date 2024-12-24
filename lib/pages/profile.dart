import 'package:brightspot/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import '../pages/home.dart';
import 'settings/account_information.dart';

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
                      'Address Information', HomePage()),
                  buildSettingChoice(context, HugeIcons.strokeRoundedPaintBoard,
                      'Appearance', HomePage()),
                  buildSettingChoice(
                      context,
                      HugeIcons.strokeRoundedNotification03,
                      'Notifications',
                      HomePage()),
                  const SizedBox(
                    height: 30,
                  ),
                  buildSettingHeader('Support'),
                  const SizedBox(
                    height: 10,
                  ),
                  buildSettingChoice(context, HugeIcons.strokeRoundedBug02,
                      'Report an issue', HomePage()),
                  buildSettingChoice(context, HugeIcons.strokeRoundedHelpCircle,
                      'FAQ', HomePage()),
                  buildSettingChoice(context, HugeIcons.strokeRoundedLogout01,
                      'Logout', HomePage()),
                ],
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
