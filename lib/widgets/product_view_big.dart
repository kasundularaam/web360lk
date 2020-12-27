import 'package:flutter/material.dart';

import '../constants.dart';

class ProductViewBig extends StatelessWidget {

  final String productName;
  final String imageUrl;
  final String category;
  final String oldPrice;
  final String price;
  final String discount;

  ProductViewBig(
      {this.productName,
        this.imageUrl,
        this.oldPrice,
        this.price,
        this.discount,
        this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.0,
      margin: const EdgeInsets.only(
        right: 15.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: Image.network(imageUrl,
                      width: 220.0,
                      height: 180.0,
                      fit: BoxFit.cover
                  ),
                ),
                Positioned(
                  top: -55.0,
                  right: -55.0,
                  child: Container(
                    width: 110.0,
                    height: 110.0,
                    decoration: BoxDecoration(
                      color: Colors.yellowAccent,
                      borderRadius: BorderRadius.circular(55.0),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 16.0,
                          left: 16.0
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            Text(discount,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),),
                            Text("OFF",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                              ),)
                          ],
                        )
                      ),
                    ),
                  ),
                )
              ],
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

          Container(
            padding: const EdgeInsets.only(
                right: 5.0
            ),
            width: 220.0,
            child: Text(productName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Constants.drkBlue16,
              textAlign: TextAlign.start,),
          ),

          Container(
            width: 220.0,
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
