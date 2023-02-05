import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:rentalapp/model/product_model.dart';
import 'package:rentalapp/model/userdetails_model.dart';

import '../model/review_model.dart';
import '../utils/utils.dart';
import '../widgets/simpleadsimage.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadNameAndAddressToDatabase(
      {required UserDetailsModel user}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(user.getJson());
  }

  Future<UserDetailsModel> getNameAndAddress() async {
    DocumentSnapshot snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();

    UserDetailsModel userModel = UserDetailsModel.getModelFromJson(
      (snap.data() as dynamic),
    );

    return userModel;
  }

  Future<String> uplaodProductToDatabase(
      {required Uint8List? image,
      required productname,
      required String catagory,
      required String price,
      required String rentedby,
      required String rentedbyuid,
      required String phno,
      required String description,
      required String address,
      required int rating,
      required int noOfRating}) async {
    String output = "Something went wrong";

    if (image != null &&
        productname != " " &&
        catagory != " " &&
        price != " " &&
        phno != " " &&
        description != "") {
      try {
        String uid = Utils().getUid();
        String url = await uploadImageToDatabase(image: image, uid: uid);
        ProductModel product = ProductModel(
          uid: uid,
          imgurl: url,
          productname: productname,
          catagory: catagory,
          price: price,
          rentedbyuid: rentedbyuid,
          rentedby: rentedby,
          address: address,
          description: description,
          phno: phno,
          rating: rating,
          noOfRating: noOfRating,
        );

        await firebaseFirestore
            .collection("products")
            .doc(uid)
            .set(product.getJson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "please fill all the fields";
    }
    return output;
  }

  Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageRef =
        FirebaseStorage.instance.ref().child("products").child(uid);
    UploadTask uploadToask = storageRef.putData(image);
    TaskSnapshot task = await uploadToask;
    return task.ref.getDownloadURL();
  }

  Future<List<Widget>> getProductsFromCatagory(String catagory) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("products")
        .where("catagory", isEqualTo: catagory)
        .get();

    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot docSnap = snap.docs[i];
      ProductModel model =
          ProductModel.getModelFromJson(json: (docSnap.data() as dynamic));
      children.add(
        SampleAdsImage(productModel: model),
      );
    }
    return children;
  }

  Future addProductToWishlist({required ProductModel productModel}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("wishlist")
        .doc(productModel.uid)
        .set(productModel.getJson());
  }

  Future deleteProductFromWishlist({required String uid}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("wishlist")
        .doc(uid)
        .delete();
  }

  Future uploadReviewToDatabase(
      {required String productUid, required ReviewModel model}) async {
    await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .collection("reviews")
        .add(model.getJson());
    await changeAverageRating(productUid: productUid, reviewModel: model);
  }

  Future changeAverageRating(
      {required String productUid, required ReviewModel reviewModel}) async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection("products").doc(productUid).get();
    ProductModel model =
        ProductModel.getModelFromJson(json: (snapshot.data() as dynamic));
    int currentRating = model.rating;
    int newRating = ((currentRating + reviewModel.rating) ~/ 2).toInt();
    await firebaseFirestore
        .collection("products")
        .doc(productUid)
        .update({"rating": newRating});
  }
}
