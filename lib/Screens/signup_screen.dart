import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rentalapp/Screens/signin_screen.dart';
import 'package:rentalapp/resources/authentication_methods.dart';
import 'package:rentalapp/utils/utils.dart';

import 'package:rentalapp/widgets/custombutton_widget.dart';

import '../widgets/akhiloos.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/customlongbutton_widget.dart';

class SignUpScreeen extends StatefulWidget {
  const SignUpScreeen({Key? key}) : super(key: key);

  @override
  State<SignUpScreeen> createState() => _SignUpScreeenState();
}

class _SignUpScreeenState extends State<SignUpScreeen> {
  var locationMsg = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  bool isloading = false;

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    var address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      locationMsg = address;
    });
  }

  @override
  dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    //  addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    locationController.text = locationMsg;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          flexibleSpace: AppBarWidget(),
          title: const Text('Sign UP Page'),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: (screenSize.height) + 100,
            width: screenSize.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/userinfo/seller.png',
                      height: screenSize.height * .2),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: (screenSize.height * .8),
                      width: screenSize.width * .8,
                      child: FittedBox(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          height: (screenSize.height),
                          width: screenSize.width * .98,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              CustomTextField(
                                data: Icons.person,
                                controller: nameController,
                                hintText: "Name",
                                isObsecre: false,
                              ),
                              CustomTextField(
                                data: Icons.email,
                                controller: emailController,
                                hintText: "Email",
                                isObsecre: false,
                              ),
                              CustomTextField(
                                data: Icons.lock,
                                controller: passwordController,
                                hintText: "Password",
                                isObsecre: true,
                              ),
                              CustomTextField(
                                data: Icons.my_location,
                                controller: locationController,
                                hintText: "Location",
                                isObsecre: false,
                                enabled: true,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    getLocation();
                                  },
                                  child: const Text("Get My Location")),
                              Align(
                                alignment: Alignment.center,
                                child: CustomMainButtonWidget(
                                  color: const Color.fromARGB(255, 54, 82, 244),
                                  isLoading: isloading,
                                  onPressed: () async {
                                    setState(() {
                                      isloading = true;
                                    });
                                    String output =
                                        await authenticationMethods.signUpUser(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            location: locationController.text);
                                    setState(() {
                                      isloading = false;
                                    });
                                    if (output == "success") {
                                      // ignore: use_build_context_synchronously
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  const SignInScreeen()));
                                    } else {
                                      Utils().showSnackBar(
                                          context: context, content: output);
                                    }
                                  },
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(
                                        color: Colors.black, letterSpacing: 2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: CustomLongButtonWidget(
                      color: Colors.grey,
                      isLoading: false,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: ((context) => const SignInScreeen()),
                          ),
                        );
                      },
                      child: const Text(
                        'Back',
                        style: TextStyle(
                            color: Colors.black,
                            wordSpacing: 5,
                            letterSpacing: 2),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
