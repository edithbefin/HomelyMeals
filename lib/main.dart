import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:rentalapp/Screens/splash_screen.dart';
import 'package:rentalapp/provider/userdetail_provider.dart';

import 'package:rentalapp/utils/colour_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyA-1AhyXVBe9K-yrp6c96FMeWZ45jsNbD8",
            authDomain: "homelymealsakanaraj.firebaseapp.com",
            projectId: "homelymealsakanaraj",
            storageBucket: "homelymealsakanaraj.appspot.com",
            messagingSenderId: "299991525761",
            appId: "1:299991525761:web:00120d5f13c117624ea080",
            measurementId: "G-9SCRPTXGC4"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const RentalApp());
}

class RentalApp extends StatelessWidget {
  const RentalApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserDetailsProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Homely_Meals',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: backgroundColor,
          ),
          debugShowCheckedModeBanner: false,
          home: const Mysplashscreen()),
    );
  }
}
