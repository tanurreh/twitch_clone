import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:twitch_clone/app/data/constants.dart';
import 'package:twitch_clone/app/data/theme.dart';
import 'package:twitch_clone/app/modules/home/controllers/auth_controller.dart';
import 'package:twitch_clone/app/modules/home/views/auth.dart/login_screen.dart';
import 'package:twitch_clone/app/modules/home/views/on_boarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAiOUJMw5wOygFuz8zBH_-OUkq9saBmPBA",
  authDomain: "twitch-clone-4566e.firebaseapp.com",
  projectId: "twitch-clone-4566e",
  storageBucket: "twitch-clone-4566e.appspot.com",
  messagingSenderId: "790263726321",
  appId: "1:790263726321:web:3fff5268af0975cbdb2950"
      ),
    ).then((value) => Get.put(AuthController()));
  } else {
    await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  }
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(GetMaterialApp(
    defaultTransition: Transition.rightToLeft,
    debugShowCheckedModeBanner: false,
    title: "Twitch Clone",
    theme: ThemeData.light().copyWith(
      scaffoldBackgroundColor: CustomColor.backgroundColor,
      // appBarTheme: AppBarTheme.of().copyWith(
      //   backgroundColor: CustomColor.backgroundColor,
      //   elevation: 0,
      //   titleTextStyle: TextStyle(
      //     color: CustomColor.primaryColor,
      //     fontSize: 20,
      //     fontWeight: FontWeight.w600,
      //   ),
      iconTheme: IconThemeData(
        color: CustomColor.primaryColor,
      ),
    ),
    home: OnboardingScreen(),
  ));
}
