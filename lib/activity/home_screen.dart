import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  bool isLoading = true;
  bool click=true;

  TextEditingController searchController = TextEditingController();
  List<RecipeModel> recipeList = <RecipeModel>[];


  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/api/recipes/v2?type=public&q=$query&app_id=${dotenv.env['App_id']}&app_key=${dotenv.env['App_key']}%09";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    setState(() {
      data["hits"].forEach((element) {
        RecipeModel recipeModel = RecipeModel();
        recipeModel = RecipeModel.fromMap(element["recipe"]);
        recipeList.add(recipeModel);

        setState(() {
          isLoading = false;
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
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value){
                            if ((searchController.text)
                                .replaceAll(" ", "") ==
                                "") {
                              print("Blank search");
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchPage(
                                          searchController.text)));
                            }

                          },
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SearchPage(
                                                searchController.text)));
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
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(12.0)),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            click=!click;
                          });
                        },
                        child:  Icon(Icons.star,color:click? kLightColor:kOrangeColor,size: 30.0,),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage('healthy')));
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

                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),

                  height: 230.0,
                  child: isLoading
                      ? const SizedBox(
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RecipeScreen(
                                          recipeList[index].recipe))),
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
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: Colors.white54,
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          width: 80.0,
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.local_fire_department,
                                                color: Colors.red,
                                              ),
                                              Text(
                                                  recipeList[index]
                                                      .calories
                                                      .toStringAsFixed(0),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                width: 180.0,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8, left: 8),
                                                  child: Text(
                                                      recipeList[index]
                                                          .foodLabel,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'Hellix-bold',
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
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Cuisine())),
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
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchPage(picPicker[index]["headline"]))),
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
                                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child; // If loading is complete, show the image
                                    }
                                    return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                              : null,
                                        )
                                    );
                                  },
                                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                    return const Text('Error loading image'); // Handle errors
                                  },
                                ),
                              )),
                              Positioned(
                                  child: Container(
                                margin: const EdgeInsets.only(top: 67, left: 15.0),
                                alignment: Alignment.center,
                                height: 40,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Text(
                                  picPicker[index]["headline"],
                                  style: const TextStyle(
                                      fontFamily: 'Hellix-Bold',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0),
                                ),
                              ))
                            ],
                          )),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
