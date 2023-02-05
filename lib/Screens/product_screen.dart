import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rentalapp/model/product_model.dart';
import 'package:rentalapp/resources/cloudfirestore_methods.dart';

import 'package:rentalapp/utils/colour_theme.dart';
import 'package:rentalapp/utils/utils.dart';
import 'package:rentalapp/widgets/appbar_widget.dart';
import 'package:rentalapp/widgets/custombutton_widget.dart';
import 'package:rentalapp/widgets/price_widget.dart';
import 'package:rentalapp/widgets/rating_widget.dart';
import 'package:rentalapp/widgets/simplebutton.dart';

import '../model/review_model.dart';
import '../widgets/review_vidget.dart';
import '../widgets/reviewdialog_widget.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({Key? key, required this.productModel}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: AppBarWidget(),
          title: const Text('Homely Meals'),
        ),
        body: Stack(children: [
          SingleChildScrollView(
            child: SizedBox(
              height: (screenSize.height) + 1042,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: screenSize.height / 7,
                          width: screenSize.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Text(
                                      widget.productModel.productname,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        color: activeCyanColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        letterSpacing: 0.9,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      widget.productModel.catagory,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ),
                                ],
                              ),
                              //rating
                              RatingStatWidget(
                                  rating: widget.productModel.rating)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height / 3,
                          child: Image.network(widget.productModel.imgurl),
                        ),
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: PriceWidget(
                                color: Colors.black,
                                price: widget.productModel.price),
                          ),
                        ),
                        Align(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Sold by  ",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 14),
                                      ),
                                      TextSpan(
                                        text: widget.productModel.rentedby,
                                        style: const TextStyle(
                                            color: activeCyanColor,
                                            fontSize: 17),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: CustomMainButtonWidget(
                            color: const Color.fromARGB(255, 229, 94, 85),
                            isLoading: false,
                            onPressed: () {},
                            child: const Text('Buy Now'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: CustomMainButtonWidget(
                            color: const Color.fromARGB(255, 250, 117, 108),
                            isLoading: false,
                            onPressed: () async {
                              //add to wishlist
                              await CloudFirestoreClass().addProductToWishlist(
                                  productModel: widget.productModel);
                              Utils().showSnackBar(
                                  context: context, content: "Added To Cart");
                            },
                            child: const Text('Add to Cart'),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(7),
                            child: CustomSimpleRoundedButton(
                                onPressed: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) => ReviewDialog(
                                            productUid: widget.productModel.uid,
                                          ));
                                },
                                text: "Add a review for this food")),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Address",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width,
                              child: Text(
                                widget.productModel.address,
                                maxLines: 2,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  letterSpacing: 0.2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Description",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width,
                              child: Text(
                                widget.productModel.description,
                                maxLines: 2,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  letterSpacing: 0.2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Contact Details",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width,
                              child: Text(
                                widget.productModel.phno,
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Reviews",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: 0.9,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: screenSize.height,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("products")
                                  .doc(widget.productModel.uid)
                                  .collection("reviews")
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                } else {
                                  return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      itemBuilder: (context, index) {
                                        ReviewModel model =
                                            ReviewModel.getModelFromJson(
                                                json: snapshot.data!.docs[index]
                                                    .data());
                                        return ReviewWidget(review: model);
                                      });
                                }
                              },
                            ))
                        //rating dialog
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
