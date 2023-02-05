import 'package:firebase_auth/firebase_auth.dart';

import 'package:rentalapp/model/userdetails_model.dart';
import 'package:rentalapp/resources/cloudfirestore_methods.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFirestoreClass cloudFirestoreClass = CloudFirestoreClass();

  Future<String> signUpUser({
    required String name,
    required String email,
    required String password,
    required String location,
  }) async {
    name.trim();

    email.trim();
    password.trim();
    location.trim();
    String output = "Something went wrong";
    if (name != "" && email != "" && password != "" && location != "") {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        UserDetailsModel user = UserDetailsModel(name: name, location: location);
        await cloudFirestoreClass.uploadNameAndAddressToDatabase(user: user);
        output = 'success';
      } on FirebaseAuthException catch (e) {
        output = output = e.message.toString();
      }
    } else {
      output = 'Please fill up all the fields';
    }
    return output;
  }

  Future<String> signInUser(
      {required String email, required String password}) async {
    email.trim();
    password.trim();
    String output = "Something went wrong";
    if (email != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = 'success';
      } on FirebaseAuthException catch (e) {
        output = output = e.message.toString();
      }
    } else {
      output = 'Please fill up all the fields';
    }
    return output;
  }
}
