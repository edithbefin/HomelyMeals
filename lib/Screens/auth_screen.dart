import 'package:flutter/material.dart';
import 'package:rentalapp/Screens/login_screen.dart';
import 'package:rentalapp/Screens/registerscreen.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue, Colors.green],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            title: Text(
              "Homely Meals",
              style: GoogleFonts.tangerine(
                fontSize: 48,
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  text: "Login",
                ),
                Tab(
                  icon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  text: "Register",
                ),
              ],
              indicatorColor: Color.fromARGB(255, 76, 175, 176),
              indicatorWeight: 6,
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.lightBlue, Colors.green])),
            child: const TabBarView(
              children: [LoginScreen(), RegisterScreen()],
            ),
          ),
        ));
  }
}
