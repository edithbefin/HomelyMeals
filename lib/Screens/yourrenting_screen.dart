import 'package:flutter/material.dart';

class YourRentingScreen extends StatefulWidget {
  final List<Widget>? children;
  const YourRentingScreen({Key? key, required this.children}) : super(key: key);

  @override
  State<YourRentingScreen> createState() => _YourRentingScreen();
}

class _YourRentingScreen extends State<YourRentingScreen> {
  @override
  Widget build(BuildContext context) {
    // return Expanded(
    //   child: ListView.builder(
    //       itemCount: 5,
    //       itemBuilder: (context, index) {
    //         return YourRentingWidget(
    //           productModel: ProductModel(
    //             imgurl: "assets/images/sampleads/apartment1.jpg",
    //             productname: "High End Apartment",
    //             catagory: "Apartment",
    //             price: "20000",
    //             uid: "1",
    //             rentedby: "user2",
    //             rentedbyuid: "2",
    //             description: "",
    //             address: "",
    //             phno: "",
    //           ),
    //         );
    //       }),
    // );

    return Expanded(
      child: ListView(
        scrollDirection: Axis.vertical,
        //children: [],
      ),
    );
  }
}
