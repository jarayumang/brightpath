import 'package:brightspot/auth/forgot_password.dart';
import 'package:brightspot/auth/signup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brightspot/constants/colors.dart';
import 'package:brightspot/services/google_sign_in_services.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final user = await SignInServices.signInWithEmailPassword(
      _emailController.text,
      _passwordController.text,
    );

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavigationExample()),
      );
    } else {
      IconSnackBar.show(
        context,
        snackBarType: SnackBarType.fail,
        label: 'Error: Invalid email or password.',
      );
    }
  }

  Future<void> _googleLogin() async {
    final user = await SignInServices.signInWithGoogle();

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavigationExample()),
      );
    } else {
      IconSnackBar.show(
        context,
        snackBarType: SnackBarType.fail,
        label: 'Error: Google Sign-in Failed',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 30),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/login.svg',
                      width: 250,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    'Login',
                    style: GoogleFonts.gabarito(
                      textStyle: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          letterSpacing: 0.5),
                    ),
                  ),
                ),
                buildLoginTextField('Email', _emailController),
                buildLoginTextField('Password', _passwordController),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    // Aligns the text to the right
                    child: RichText(
                      text: TextSpan(
                        text: 'Forgot Password',
                        style: GoogleFonts.gabarito(
                          textStyle: const TextStyle(
                            color: AppColors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to the registration page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen()),
                            );
                          },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _login,
                      child: Text(
                        'Login',
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.googleBackground,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _googleLogin,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Image.asset(
                                'assets/google.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Login with Google',
                              style: GoogleFonts.gabarito(
                                textStyle: const TextStyle(
                                  color: AppColors.googleText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.gabarito(
                          textStyle: const TextStyle(
                            color: AppColors.darkGray,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                        children: [
                          TextSpan(text: 'New to Brightspot? '),
                          TextSpan(
                            text: 'Register',
                            style: GoogleFonts.gabarito(
                              textStyle: const TextStyle(
                                color: AppColors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to the registration page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupScreen()),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildLoginTextField(
      String label, TextEditingController controller) {
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
            keyboardType: label == 'Email'
                ? TextInputType.emailAddress
                : TextInputType.text,
            controller: controller,
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
