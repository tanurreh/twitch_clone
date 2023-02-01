import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitch_clone/app/modules/home/views/auth.dart/login_screen.dart';
import 'package:twitch_clone/app/modules/home/views/auth.dart/sign_up_screen.dart';
import 'package:twitch_clone/app/modules/home/widgets.dart/custom_buttons.dart';
import 'package:twitch_clone/app/responsive/responsive.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to \n Twitch',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomButton(
                  onTap: () {
                    Get.to(() => LoginScreen());
                  },
                  text: 'Log in',
                ),
              ),
              CustomButton(
                  onTap: () {
                    Get.to(() => SignupScreen());
                  },
                  text: 'Sign Up'),
            ],
          ),
        ),
      ),
    );
  }
}
