import 'package:flutter/material.dart';
import 'package:rentalapp/model/product_model.dart';
import 'package:rentalapp/widgets/price_widget.dart';

import '../Screens/product_screen.dart';

class ResultWidget extends StatelessWidget {
  final ProductModel productModel;
  const ResultWidget({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProductScreen(productModel: productModel);
            },
          ),
        );
      }),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              //height: (screenSize.height / 4),
              width: screenSize.width / 3,
    
              child: Image.asset(productModel.imgurl),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                productModel.productname,
                style: const TextStyle(fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
                height: 20,
                child: FittedBox(
                    child: PriceWidget(
                        color: Colors.black, price: productModel.price),),),
          ],
        ),
      ),
    );
  }
}
