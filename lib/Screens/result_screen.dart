import 'package:flutter/material.dart';
import 'package:rentalapp/utils/colour_theme.dart';
import 'package:rentalapp/widgets/results_widget.dart';

import '../model/product_model.dart';
import '../widgets/appbar_widget.dart';

class ResultScreen extends StatelessWidget {
  final String query;
  const ResultScreen({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: AppBarWidget(),
          title: const Text('RENT APP'),
        ),
        body: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Showing results for ",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      TextSpan(
                        text: query,
                        style: const TextStyle(
                            fontSize: 17,
                            fontStyle: FontStyle.italic,
                            color: activeCyanColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 15,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 2 / 3),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ResultWidget(
                      productModel: ProductModel(
                          imgurl: "assets/images/sampleads/apartment1.jpg",
                          productname: "High End Apartment",
                          catagory: "Apartment",
                          price: "20000",
                          uid: "1",
                          rentedby: "user2",
                          rentedbyuid: "2",
                          description: "",
                          address: "",
                          phno: "",
                          rating: 0,
                          noOfRating: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
