import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:web360lk/constants.dart';
import 'package:web360lk/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:web360lk/widgets/product_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List<Product>> productListF;
  List<Product> productListN;
  List<Product> featuredProductList;
  List<Product> bsProductList;

  Future<List<Product>> getProducts() async {
    List<Product> myList = [];

    final response = await http.Client().get(
        Uri.parse("https://www.web360.lk/"));

    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);
      document.getElementsByClassName("col-inner").forEach((child) {
        myList.add(
            Product(
                productName: child.getElementsByTagName("p")[1].text,
                imageUrl: child.getElementsByTagName("img")[0].attributes["src"],
              category: child.getElementsByTagName("p")[0].text,
              oldPrice: child.getElementsByTagName("bdi")[0].text,
              price: child.getElementsByTagName("bdi")[1].text,
            )
        );
      });
    } else {
      throw Exception();
    }
    return myList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    productListF = getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: productListF,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text("Something went wrong!\n" + "${snapshot.error}",
                    style: Constants.error14,),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              productListN = snapshot.data;
              featuredProductList = productListN.sublist(0,10);
              bsProductList = productListN.sublist(9,14);
              return Container(
                color: Colors.blue,
                child: SafeArea(
                  child: ListView(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Web360.Lk",
                              style: Constants.whiteBold22
                      ),
                    ),
                  ),
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0)
                        ),
                        child: Container(
                          color: Color(0xFFDDDDDD),
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: ListView(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 14.0,
                                  right: 10.0,
                                  bottom: 14.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Featured Products",
                                      style: Constants.drkOrange20,),
                                    Text("See All",
                                      style: Constants.seeAll,),
                                  ],
                                ),
                              ),

                              StaggeredGridView.countBuilder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: featuredProductList.length,
                                crossAxisCount: 2,
                                itemBuilder: (BuildContext context, int index) {
                                  Product product = featuredProductList[index];
                                  return ProductView(
                                    productName: product.productName,
                                    imageUrl: product.imageUrl,
                                    price: product.price,
                                    oldPrice: product.oldPrice,
                                    category: product.category.trim(),
                                  );
                                  },
                                staggeredTileBuilder: (int index) {
                                  return new StaggeredTile.fit(1);
                                  },
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 6.0,
                              ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 14.0,
                                  right: 10.0,
                                  bottom: 14.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Best Selling Products",
                                      style: Constants.drkOrange20,),
                                    Text("See All",
                                      style: Constants.seeAll,),
                                  ],
                                ),
                              ),

                              StaggeredGridView.countBuilder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: bsProductList.length,
                                crossAxisCount: 2,
                                itemBuilder: (BuildContext context, int index) {
                                  Product product = bsProductList[index];
                                  return ProductView(
                                    productName: product.productName,
                                    imageUrl: product.imageUrl,
                                    price: product.price,
                                    oldPrice: product.oldPrice,
                                    category: product.category.trim(),
                                  );
                                },
                                staggeredTileBuilder: (int index) {
                                  return new StaggeredTile.fit(1);
                                },
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 6.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
      ),
    );
  }
}
