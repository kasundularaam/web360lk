import 'package:flutter/material.dart';

import '../constants.dart';

class ProductViewSmall extends StatelessWidget {

  final String productName;
  final String imageUrl;
  final String category;
  final String oldPrice;
  final String price;
  final String discount;

  ProductViewSmall(
      {this.productName,
        this.imageUrl,
        this.oldPrice,
        this.price,
        this.discount,
        this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      margin: const EdgeInsets.only(
          right: 10.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              color: Colors.white,
              child: Image.network(imageUrl,
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.only(
              top: 5.0,
              right: 5.0
            ),
            width: 120.0,
            child: Text(productName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Constants.drkBlue16,
              textAlign: TextAlign.start,),
          ),

          Container(
            width: 120.0,
            child: Padding(
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
            ),
          )
        ],
      ),
    );
  }
}
