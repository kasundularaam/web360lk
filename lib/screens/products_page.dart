import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:web360lk/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:web360lk/screens/search_page.dart';
import 'package:web360lk/widgets/product_view_stg.dart';

import '../constants.dart';

class ProductsPage extends StatefulWidget {

  final String productType;
  final String pageTitle;

  ProductsPage({this.productType,this.pageTitle});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  Future<List<Product>> productListF;
  List<Product> productListN;
  String url;
  List<Product> bsProductList;
  Product product;

  Future<List<Product>> getProducts() async {
    List<Product> myList = [];

    final response = await http.Client().get(
        Uri.parse(url));

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
                discount: child.getElementsByClassName("onsale")[0].text
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
    super.initState();

    loadProducts();

  }

  Future<List<Product>> loadProducts(){

    switch(widget.productType){
      case "ALL_PRODUCTS":
        setState(() {
          url = "https://www.web360.lk/shop/";
        });
        productListF = getProducts();
        return productListF;
        break;
      case "BEST_SELLING_PRODUCTS":
        setState(() {
          url = "https://www.web360.lk/";
        });
        productListF = getProducts();
        return productListF;
        break;
      case "ALL_PLUGINS":
        setState(() {
          url = "https://www.web360.lk/product-category/wordpress/plugins/";
        });
        productListF = getProducts();
        return productListF;
        break;
      case "ALL_THEMES":
        setState(() {
          url = "https://www.web360.lk/product-category/wordpress/themes/";
        });
        productListF = getProducts();
        return productListF;
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Container(
          color: Color(0xFFDDDDDD),
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  child: FutureBuilder(
                      future: loadProducts(),
                      builder: (context, productsSnapshot) {
                        if (productsSnapshot.hasError) {
                          return Container(
                            child: Center(
                              child: Text("Something went wrong!\n" + "${productsSnapshot.error}",
                                style: Constants.error14,
                                textAlign: TextAlign.center,),
                            ),
                          );
                        }
                        if (productsSnapshot.connectionState == ConnectionState.done) {
                          productListN = productsSnapshot.data;
                          if(widget.productType == "BEST_SELLING_PRODUCTS"){
                            bsProductList = productListN.sublist(10);
                          }
                          return ListView(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 65.0,
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 5.0,
                                    right: 5.0,
                                ),
                                child: StaggeredGridView.countBuilder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: widget.productType ==  "BEST_SELLING_PRODUCTS" ? bsProductList.length : productListN.length,
                                  crossAxisCount: 2,
                                  itemBuilder: (BuildContext context, int index) {
                                    if(widget.productType == "BEST_SELLING_PRODUCTS"){
                                      product = bsProductList[index];
                                    }else{
                                      product = productListN[index];
                                    }
                                    return ProductViewStg(
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
                              ),
                            ],
                          );
                        }

                        return Container(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      }
                  ),
                ),

                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 60.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 2,
                              spreadRadius: 1,
                              offset: Offset(0,1)
                          )
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_back,
                            color: Color(0xFF555555),),
                          ),
                        ),
                        Text(widget.pageTitle,
                            style: Constants.gray22Bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.search,
                              color: Color(0xFF555555),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        )
    );
  }
}
