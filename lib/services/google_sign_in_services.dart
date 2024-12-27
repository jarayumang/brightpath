import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignInServices {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method for Google Sign-In
  static Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User canceled the sign-in
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      print('Error during Google sign-in: $e');
      return null;
    }
  }

  // Method for Email and Password Sign-In
  static Future<User?> signInWithEmailPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Error during email sign-in: ${e.message}');
      return null;
    }
  }

  // Method for Sign-Up with Email, Password, and Full Name
  static Future<User?> signUpWithEmailPassword(
      String email, String password, String fullName) async {
    try {
      // Create user in Firebase Authentication
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Get the user
      final User? user = userCredential.user;

      if (user != null) {
        // Create user document in Firestore with the same UID as the user
        await _firestore.collection('users').doc(user.uid).set({
          'fullName': fullName,
          'email': email,
          'city': null,
          'country': null,
          'darkMode': false,
          'otherAddress': null,
          'phoneNumber': null,
          'province': null,
          'zip': null,
          'marketingNotifications': {
            'push': true,
            'sms': true,
            'email': true,
          },
          'reminders': {
            'push': true,
            'sms': true,
            'email': true,
          },
          'systemNotifications': {
            'push': true,
            'sms': true,
            'email': true,
          },
          'createdAt': FieldValue.serverTimestamp(),
        });

        return user;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      print('Error during sign-up: ${e.message}');
      return null;
    }
  }

  // Method for Sign-Out
  static Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
