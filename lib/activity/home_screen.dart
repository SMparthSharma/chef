import 'dart:convert';
import 'package:mr_chef/activity/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:mr_chef/activity/constant.dart';
import 'package:mr_chef/activity/recipe_screen.dart';
import 'package:http/http.dart';

import 'cuisine_screen.dart';
import 'model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isLoading=true;

  TextEditingController searchController = TextEditingController();
  List<RecipeModel> recipeList= <RecipeModel>[];
  List picPicker=[
    {"impUrl":"https://www.tastingtable.com/img/gallery/20-delicious-indian-dishes-you-have-to-try-at-least-once/intro-1645057933.webp","headline":"Indian "},
    {"impUrl":"https://img.freepik.com/premium-photo/food-photos_662583-2610.jpg?w=740","headline":"Fast Food",},
    {"impUrl":"https://assets.clevelandclinic.org/transform/LargeFeatureImage/9cbcc77b-93b7-472e-838d-ec0d5f2f9fbd/heart-healthy-foods-1279763992","headline":"Healthy Food",},
    {"impUrl":"https://www.dumplingconnection.com/wp-content/uploads/2019/07/Chinese-cusine-e1586208090905.jpg","headline":"Chinese ",},
    {"impUrl":"https://hips.hearstapps.com/del.h-cdn.co/assets/15/24/1600x800/landscape-1433889344-del-milkshakes-index.jpg?resize=1200:*","headline":"Shakes",},
    {"impUrl":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSU4RVhklejw3LtywA2YnTflm3fuEkbUsEyyw&s","headline":"Street Food",},
    {"impUrl":"https://www.linsfood.com/wp-content/uploads/2021/04/Red-Chilli-Paste-LinsFoodjpg.jpg","headline":"Chilli Food",},
    {"impUrl":"https://c4.wallpaperflare.com/wallpaper/626/14/515/dessert-sweet-food-cake-wallpaper-preview.jpg","headline":"Sweet",},
    {"impUrl":"https://nutritionrefined.com/wp-content/uploads/2023/08/garden-salad.jpg","headline":"Salad",},
    {"impUrl":"https://www.domex-uk.co.uk/wp-content/uploads/2020/08/Keep-ice-cream-scoopable-in-freezer.jpg","headline":"Ice Cream",},
  ];

  getRecipe(String query) async {
    String url ="https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=bacff06d&app_key=21d7a5e6d035e180d6276ca7544554e9%09";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

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
    getRecipe("healthy");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kLightColor,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 35.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 6.0),
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
                                    Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchPage(searchController.text)));
                                  }
                                },
                                icon: const Icon(
                                  Icons.search,
                                  size: 34.0,
                                  color: kBlueColor,
                                ),
                              ),
                              hintText: 'Search for recipes',
                              hintStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 20.0)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 18.0),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          'assets/images/settings.png',
                          height: 22.0,
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'What would you like to cook today?',
                  style: TextStyle(
                      fontFamily: 'Hellix-Bold',
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Today's Fresh Recipes",
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Hellix-Bold'),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchPage('healthy')));
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Hellix-Bold',
                            color: kOrangeColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Container(
                  // width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),

                  height: 230.0,
                  child: isLoading ? Container(height: 50,child: Center(child: CircularProgressIndicator() ,),): ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>RecipeScreen(recipeList[index].recipe))),
                        child: Container(
                          margin: const EdgeInsets.only(right: 32.0),
                          height: 230.0,
                          width: 200.0,
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
                                      width: 200.0,
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

                                      child: Row(
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
                                      horizontal: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [

                                      Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white54,
                                            borderRadius: BorderRadius.circular(10.0)
                                          ),
                                          width: 180.0,
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 8,left: 8),
                                            child: Text(recipeList[index].foodLabel,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'Hellix-bold',
                                                    fontSize: 20.0,
                                                    color: kDarkColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          )),

                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Your Taste",
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Hellix-Bold'),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>Cuisine())),
                      child: const Text(
                        "See All",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Hellix-Bold',
                            color: kOrangeColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchPage(picPicker[index]["headline"]))),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(20.0)),
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        child: Stack(
                          children: [

                            Positioned(

                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    picPicker[index]["impUrl"],
                                    //'assets/images/mm.png',
                                    height: 120.0,
                                    width: double.infinity,
                                    fit: BoxFit.cover,

                                  ),
                                )),
                            Positioned(child: Container(
                              margin: EdgeInsets.only(top: 67,left: 15.0),
                              alignment: Alignment.center,
                              height: 40,
                              width: 300,
                              decoration: BoxDecoration(color: Colors.white54, borderRadius: BorderRadius.circular(10.0)),
                              child: Text(
                                picPicker[index]["headline"],
                                style: TextStyle(
                                    fontFamily: 'Hellix-Bold',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25.0),
                              ),
                            ))
                          ],
                        )
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
