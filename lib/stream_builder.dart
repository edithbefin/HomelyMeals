import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rentalapp/Screens/auth_screen.dart';

import 'Layouts/screen_layouts.dart';

class StreamWidget extends StatefulWidget {
  const StreamWidget({Key? key}) : super(key: key);

  @override
  State<StreamWidget> createState() => _StreamWidgetState();
}

class _StreamWidgetState extends State<StreamWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> user) {
        if (user.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        } else if (user.hasData) {
          return const ScreenLayouts();
          //return const RentPropertyScreen();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
