import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:web360lk/constants.dart';
import 'package:web360lk/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:web360lk/models/wp_brand.dart';
import 'package:web360lk/screens/products_page.dart';
import 'package:web360lk/screens/search_page.dart';
import 'package:web360lk/screens/wp_brands_page.dart';
import 'package:web360lk/widgets/product_view_big.dart';
import 'package:web360lk/widgets/product_view_small.dart';
import 'package:web360lk/widgets/product_view_stg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //WORD PRESS BRANDS
  Future<List<WpBrand>> wpBrandsListF;
  List<WpBrand> wpBrandsListN;

  //FEATURED PRODUCTS & BEST SELLING PRODUCTS
  Future<List<Product>> productListF;
  List<Product> productListN;
  List<Product> featuredProductList;
  List<Product> bsProductList;

  //PLUGINS
  Future<List<Product>> pluginsListF;
  List<Product> pluginListN;

  //THEMES
  Future<List<Product>> themesListF;
  List<Product> themesListN;


  //WORD PRESS BRANDS
  Future<List<WpBrand>> getWpBrands() async {
    List<WpBrand> myList = [];

    final response = await http.Client().get(
        Uri.parse("https://www.web360.lk/"));

    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);
      document.getElementsByClassName("elementor-image-carousel-wrapper").forEach((child) {
        int len = child.getElementsByTagName("img").length;
        for(int i=0; i<len; i++){
          myList.add(
              WpBrand(
                imgUrl: child.getElementsByTagName("img")[i].attributes["src"],
              )
          );
        }
      });
    } else {
      throw Exception();
    }
    return myList;
  }

  //FEATURED PRODUCTS & BEST SELLING PRODUCTS

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
              discount: child.getElementsByClassName("onsale")[0].text
            )
        );
      });
    } else {
      throw Exception();
    }
    return myList;
  }

  //PLUGINS

  Future<List<Product>> getPlugins() async {
    List<Product> myList = [];

    final response = await http.Client().get(
        Uri.parse("https://www.web360.lk/product-category/wordpress/plugins/"));

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

  //THEMES

  Future<List<Product>> getThemes() async {
    List<Product> myList = [];

    final response = await http.Client().get(
        Uri.parse("https://www.web360.lk/product-category/wordpress/themes/"));

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

  Widget _homeList(int index){
    switch(index){
      case 0:
        return
          InkWell(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WpBrandsPage()
                )
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 14.0,
                right: 10.0,
                bottom: 14.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Wordpress Brands",
                    style: Constants.drkOrange20,),
                  Text("See All",
                    style: Constants.seeAll,),
                ],
              ),
            ),
          );
            break;
      case 1:
        return
          Container(
            height: 116.0,
            width: double.infinity,
            child: FutureBuilder(
                future: wpBrandsListF,
                builder: (context, wpBrandsSnapshot){
                  if(wpBrandsSnapshot.hasError){
                    return Center(
                      child: Text("Something went wrong!\n"+"${wpBrandsSnapshot.error}",
                        style: Constants.error14,
                      textAlign: TextAlign.center,),
                    );
                  }
                  if(wpBrandsSnapshot.connectionState == ConnectionState.done){
                    wpBrandsListN = wpBrandsSnapshot.data;
                    return ListView.builder(
                        itemCount: wpBrandsSnapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          WpBrand wpBrand = wpBrandsListN[index];
                          return
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Container(
                                  color: Colors.white,
                                  height: 110.0,
                                  width: 120.0,
                                  child: Image.network(
                                    wpBrand.imgUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                        });
                  }
                  return Center(
                      child: CircularProgressIndicator()
                  );
                }),
          );
        break;
      case 2:
        return
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductsPage(productType: "ALL_PRODUCTS",
                      pageTitle: "All Products",)
                  )
              );
            },
            child: Padding(
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
          );
        break;
      case 3:
        return
          Container(
            height: 300.0,
            child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: featuredProductList.length,
                itemBuilder: (context, index){
                  Product product = featuredProductList[index];
                  return ProductViewBig(
                    productName: product.productName,
                    imageUrl: product.imageUrl,
                    price: product.price,
                    oldPrice: product.oldPrice,
                    category: product.category.trim(),
                    discount: product.discount,
                  );
                }),
          );
        break;
      case 4:
        return
          Container(
            decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0)
                )
            ),
            child: InkWell(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductsPage(
                          productType: "BEST_SELLING_PRODUCTS",
                          pageTitle: "Best Selling Products",)
                    )
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 14.0,
                  right: 10.0,
                  bottom: 14.0,
                  left: 5.0
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
            ),
          );
        break;
      case 5:
        return
          Container(
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12.0),
                  bottomLeft: Radius.circular(12.0)
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: StaggeredGridView.countBuilder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                crossAxisCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  Product product = bsProductList[index];
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
          );
        break;
      case 6:
        return
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductsPage(productType: "ALL_PLUGINS",
                      pageTitle: "Plugins",)
                  )
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 14.0,
                  right: 10.0,
                  bottom: 14.0,
                  left: 5.0
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Plugins",
                    style: Constants.drkOrange20,),
                  Text("See All",
                    style: Constants.seeAll,),
                ],
              ),
            ),
          );
        break;
      case 7:
        return
          Container(
            height: 190.0,
            width: double.infinity,
            child: FutureBuilder(
                future: pluginsListF,
                builder: (context, pluginSnapshot){
                  if(pluginSnapshot.hasError){
                    return Center(
                      child: Text("Something went wrong!\n"+"${pluginSnapshot.error}",
                        style: Constants.error14,
                        textAlign: TextAlign.center,),
                    );
                  }
                  if(pluginSnapshot.connectionState == ConnectionState.done){
                    pluginListN = pluginSnapshot.data;
                    return ListView.builder(
                        itemCount: pluginSnapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          Product plugin = pluginListN[index];
                          return ProductViewSmall(
                            productName: plugin.productName,
                            price: plugin.price,
                            oldPrice: plugin.oldPrice,
                            imageUrl: plugin.imageUrl,
                            category: plugin.category,
                            discount: plugin.discount,
                          );
                        });
                  }
                  return Center(
                      child: CircularProgressIndicator()
                  );
                }),
          );
        break;
      case 8:
        return
          InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductsPage(productType: "ALL_THEMES",
                      pageTitle: "Themes",)
                  )
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 14.0,
                  right: 10.0,
                  bottom: 14.0,
                  left: 5.0
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Themes",
                    style: Constants.drkOrange20,),
                  Text("See All",
                    style: Constants.seeAll,),
                ],
              ),
            ),
          );
        break;
      case 9:
        return
          Container(
            height: 190.0,
            width: double.infinity,
            child: FutureBuilder(
                future: themesListF,
                builder: (context, themeSnapshot){
                  if(themeSnapshot.hasError){
                    return Center(
                      child: Text("Something went wrong!\n"+"${themeSnapshot.error}",
                        style: Constants.error14,
                        textAlign: TextAlign.center,),
                    );
                  }
                  if(themeSnapshot.connectionState == ConnectionState.done){
                    themesListN = themeSnapshot.data;
                    return ListView.builder(
                        itemCount: themeSnapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index){
                          Product theme = themesListN[index];
                          return ProductViewSmall(
                            productName: theme.productName,
                            price: theme.price,
                            oldPrice: theme.oldPrice,
                            imageUrl: theme.imageUrl,
                            category: theme.category,
                            discount: theme.discount,
                          );
                        });
                  }
                  return Center(
                      child: CircularProgressIndicator()
                  );
                }),
          );
        break;
      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();

    productListF = getProducts();
    wpBrandsListF = getWpBrands();
    pluginsListF = getPlugins();
    themesListF = getThemes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFDDDDDD),
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                child: FutureBuilder(
                    future: productListF,
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
                        featuredProductList = productListN.sublist(0,10);
                        bsProductList = productListN.sublist(10,15);
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
                              child: SafeArea(
                                child: Container(
                                  child: ListView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 10,
                                    itemBuilder: (context, index){
                                      return _homeList(index);
                                    },
                                  ),
                                ),
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

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.menu,
                            color: Color(0xFF555555),),
                        ),
                      ),
                      Text("Web360.Lk",
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
      ),
    );
  }
}
