import 'dart:convert';

import 'package:mr_chef/activity/recipe_screen.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'model.dart';
import 'package:http/http.dart';

class SearchPage extends StatefulWidget {
  String query;
  SearchPage(this.query);


  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  bool isLoading=true;

  TextEditingController searchController = TextEditingController();
  List<RecipeModel> recipeList= <RecipeModel>[];

  getRecipe(String query) async {
    String url ="https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=bacff06d&app_key=21d7a5e6d035e180d6276ca7544554e9%09";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    // log(data["hits"].toString());


    setState(() {
      data["hits"].forEach((element){
        RecipeModel recipeModel=RecipeModel();
        recipeModel=RecipeModel.fromMap(element["recipe"]);
        recipeList.add(recipeModel);
        //log(recipeList.toString());

        setState(() {
          isLoading=false;
        });
      });
    });

  }

  @override
  void initState() {
    super.initState();
    getRecipe(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightColor,
      body: Column(
        children: [
          SizedBox(height: 30.0,),
      Container(
      margin: const EdgeInsets.symmetric(
          vertical: 10.0, horizontal: 10.0),

      decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(12.0)),
      child: TextField(
        controller: searchController,
        cursorColor: kDarkColor,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: IconButton(
              onPressed: () {
                if ((searchController.text)
                    .replaceAll(" ", "") ==
                    "") {
                  print("Blank search");
                } else {
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>SearchPage(searchController.text)));
                }
              },
              icon: const Icon(
                Icons.search,
                size: 34.0,
                color: kOrangeColor,
              ),
            ),
            hintText: 'Search for recipes',
            hintStyle: const TextStyle(
                color: Colors.grey, fontSize: 20.0)),
      ),
    ),
          Padding(padding: EdgeInsets.only(right: 90),
            child: Container(height: 30.0,width: 250,
              alignment: Alignment.topLeft,
              child: const Text(
                'Make your own meal',
                style: TextStyle(
                    fontFamily: 'Hellix-Bold',
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0),
              ),
            ),
          ),

          Expanded(
            child: Container(

              padding:const EdgeInsets.symmetric(horizontal:9),

              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),

              height:MediaQuery.of(context).size.height ,
              width: MediaQuery.of(context).size.width,

              child: isLoading ? Container(height: 50,child: Center(child: CircularProgressIndicator() ,),): ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: recipeList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>RecipeScreen(recipeList[index].recipe))),
                    child: Container(

                      margin: const EdgeInsets.only(bottom: 10),
                      height: 180.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Stack(
                        children: [

                          Positioned(

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(

                                  recipeList[index].image,
                                  height: 230.0,
                                  width: double.infinity,
                                  fit: BoxFit.cover,

                                ),
                              )),
                          Positioned(
                            top:0,
                            right: 0,


                            child: Container(
                                alignment:Alignment.center ,
                                decoration: BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.circular(10.0)
                                ),
                                width: 80.0,

                                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.local_fire_department,color: Colors.red,),
                                    Text(recipeList[index].calories.toStringAsFixed(0),
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'Hellix-bold',
                                            fontSize: 20.0,
                                            color: kDarkColor,
                                            fontWeight:
                                            FontWeight.bold)),
                                  ],
                                )),
                          ),

                          Positioned(
                            bottom: 10.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  width: 315.0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8,left: 8),
                                    child: Center(
                                      child: Text(recipeList[index].foodLabel,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'Hellix-bold',
                                              fontSize: 20.0,
                                              color: kDarkColor,
                                              fontWeight:
                                              FontWeight.bold)),
                                    ),
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

        ],
      ),

        );
  }
}
