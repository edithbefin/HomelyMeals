// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:rentalapp/model/product_model.dart';
import 'package:rentalapp/resources/cloudfirestore_methods.dart';
import 'package:rentalapp/widgets/custombutton_widget.dart';
import 'package:rentalapp/widgets/productinformation_wiget.dart';
import '../Screens/product_screen.dart';
import '../utils/colour_theme.dart';
import 'costomsquarebutton_widget.dart';

class WishlistWidget extends StatelessWidget {
  final ProductModel productModel;
  const WishlistWidget({Key? key, required this.productModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductScreen(productModel: productModel);
            },
          ),
        );
      },
      child: Container(
        // padding: const EdgeInsets.all(8),
        height: screenSize.height / 3,
        width: screenSize.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenSize.width / 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.network(productModel.imgurl),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: ProductInfoWidget(
                        productname: productModel.productname,
                        catogory: productModel.catagory,
                        rentedby: productModel.rentedby,
                        price: productModel.price,
                        description: productModel.description,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  CustomSquareButton(
                      child: const Icon(Icons.remove),
                      onPressed: () {},
                      color: backgroundColor,
                      dimension: 40),
                  CustomSquareButton(
                      child: const Text(
                        "0",
                        style: TextStyle(
                          color: activeCyanColor,
                        ),
                      ),
                      onPressed: () {},
                      color: Colors.white,
                      dimension: 40),
                  CustomSquareButton(
                      child: const Icon(Icons.add),
                      onPressed: () async {
                        await CloudFirestoreClass().addProductToWishlist(
                            productModel: ProductModel(
                                uid: productModel.uid,
                                imgurl: productModel.imgurl,
                                productname: productModel.productname,
                                catagory: productModel.catagory,
                                price: productModel.price,
                                rentedbyuid: productModel.rentedbyuid,
                                rentedby: productModel.rentedby,
                                address: productModel.address,
                                description: productModel.description,
                                phno: productModel.phno,
                                rating: 0,
                                noOfRating: 0));
                      },
                      color: backgroundColor,
                      dimension: 40),
                ],
              ),
              flex: 1,
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomMainButtonWidget(
                    onPressed: () async {
                      //delete from wishlist
                      CloudFirestoreClass()
                          .deleteProductFromWishlist(uid: productModel.uid);
                    },
                    isLoading: false,
                    color: Colors.grey,
                    child: const Text(
                      'Remove',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
