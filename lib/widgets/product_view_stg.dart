import 'package:flutter/material.dart';

import '../constants.dart';

class ProductViewStg extends StatelessWidget {

  final String productName;
  final String imageUrl;
  final String category;
  final String oldPrice;
  final String price;
  final String discount;

  ProductViewStg(
      {this.productName,
      this.imageUrl,
      this.oldPrice,
      this.price,
      this.discount,
      this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(imageUrl,
                fit: BoxFit.cover
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(category,
                    style: Constants.lightBlue14Thin),
              ),
            ),
          ),

          Text(productName,
            style: Constants.drkBlue16,
            textAlign: TextAlign.start,),

          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5.0
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(oldPrice,
                  style: Constants.oldPrice,
                ),
                Text(price,
                style: Constants.price,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
