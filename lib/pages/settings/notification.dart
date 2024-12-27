import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:brightspot/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late String userId; // Holds the user ID

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    userId = user!.uid; // Fetch the current user ID
  }

  Future<void> _updateNotificationPreference(String key, bool value) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'system_notifications.$key': value,
    });
  }

  Future<void> _updateMarketingPreference(String key, bool value) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'marketing_notifications.$key': value,
    });
  }

  Future<void> _updateReminders(String key, bool value) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'reminders.$key': value,
    });
  }

  @override
  Widget build(BuildContext context) {
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
          bool isSystemPushEnabled =
              userData['system_notifications']?['push'] ?? false;
          bool isSystemSMSEnabled =
              userData['system_notifications']?['sms'] ?? false;
          bool isSystemEmailEnabled =
              userData['system_notifications']?['email'] ?? false;
          bool isMarketingPushEnabled =
              userData['marketing_notifications']?['push'] ?? false;
          bool isMarketingSMSEnabled =
              userData['marketing_notifications']?['sms'] ?? false;
          bool isMarketingEmailEnabled =
              userData['marketing_notifications']?['email'] ?? false;
          bool isReminderPushEnabled = userData['reminders']?['push'] ?? false;
          bool isReminderSMSEnabled = userData['reminders']?['sms'] ?? false;
          bool isReminderEmailEnabled =
              userData['reminders']?['email'] ?? false;

          return Column(
            children: [
              // Sticky header
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: AppColors.lightGreen,
                child: Text(
                  'Notifications',
                  style: GoogleFonts.gabarito(
                    textStyle: const TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        letterSpacing: 0.5),
                  ),
                ),
              ),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildPrimaryText('System notifications'),
                      buildSecondaryText(
                          'Receive notifications about the latest news & system updates from us.'),
                      buildNotificationSwitch(
                          isSystemPushEnabled, 'Push', 'push'),
                      buildNotificationSwitch(isSystemSMSEnabled, 'SMS', 'sms'),
                      buildNotificationSwitch(
                          isSystemEmailEnabled, 'Email', 'email'),
                      buildPrimaryText('Marketing notifications'),
                      buildSecondaryText(
                          'Receive notifications with personalized offers and information about promotions.'),
                      buildNotificationSwitch(
                          isMarketingPushEnabled, 'Push', 'push'),
                      buildNotificationSwitch(
                          isMarketingSMSEnabled, 'SMS', 'sms'),
                      buildNotificationSwitch(
                          isMarketingEmailEnabled, 'Email', 'email'),
                      buildPrimaryText('Reminders'),
                      buildSecondaryText(
                          'Receive notifications about the events and other reminders from us.'),
                      buildNotificationSwitch(
                          isReminderPushEnabled, 'Push', 'push'),
                      buildNotificationSwitch(
                          isReminderSMSEnabled, 'SMS', 'sms'),
                      buildNotificationSwitch(
                          isReminderEmailEnabled, 'Email', 'email'),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Padding buildPrimaryText(String value) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
      child: Text(
        value,
        style: GoogleFonts.gabarito(
          textStyle: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              fontSize: 15),
        ),
      ),
    );
  }

  Padding buildSecondaryText(String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 50),
      child: Text(
        value,
        style: GoogleFonts.gabarito(
          textStyle: const TextStyle(
              color: AppColors.lightGray,
              fontWeight: FontWeight.w600,
              fontSize: 12),
        ),
      ),
    );
  }

  Padding buildNotificationSwitch(
      bool isValueEnabled, String label, String userDataValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey, // Color of the bottom border
              width: 1.0, // Thickness of the bottom border
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.gabarito(
                textStyle: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
            ),
            Transform.scale(
              scale: 0.7,
              // Adjust the scale factor (smaller than 1 for reducing size)
              child: Switch(
                value: isValueEnabled,
                onChanged: (bool value) async {
                  await _updateNotificationPreference(userDataValue, value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
