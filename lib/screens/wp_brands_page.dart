import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:web360lk/models/wp_brand.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:web360lk/screens/search_page.dart';

import '../constants.dart';

class WpBrandsPage extends StatefulWidget {

  @override
  _WpBrandsPageState createState() => _WpBrandsPageState();
}

class _WpBrandsPageState extends State<WpBrandsPage> {

  Future<List<WpBrand>> wpBrandsListF;
  List<WpBrand> wpBrandsListN;

  Future<List<WpBrand>> getWpBrands() async {
    List<WpBrand> myList = [];

    final response = await http.Client().get(
        Uri.parse("https://www.web360.lk/brands/"));

    if (response.statusCode == 200) {
      dom.Document document = parser.parse(response.body);
      document.getElementsByClassName("elementor-section-wrap").forEach((child) {
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

  @override
  void initState() {
    super.initState();

    wpBrandsListF = getWpBrands();

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
                        return
                          ListView(
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
                                  itemCount: wpBrandsListN.length,
                                  crossAxisCount: 2,
                                  itemBuilder: (BuildContext context, int index) {
                                    WpBrand wpBrand = wpBrandsListN[index];
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Container(
                                        child: Image.network(wpBrand.imgUrl,
                                        fit: BoxFit.cover,),
                                      ),
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
                          )
                      );
                    }),
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
