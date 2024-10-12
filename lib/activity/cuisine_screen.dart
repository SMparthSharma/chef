import 'package:mr_chef/activity/constant.dart';
import 'package:mr_chef/activity/searchPage.dart';
import 'package:flutter/material.dart';
class Cuisine extends StatelessWidget {
  const Cuisine({super.key});

  @override
  Widget build(BuildContext context) {
    List picPicker = [
      {
        "impUrl":
        "https://www.tastingtable.com/img/gallery/20-delicious-indian-dishes-you-have-to-try-at-least-once/intro-1645057933.webp",
        "headline": "Indian "
      },

      {
        "impUrl":
        "https://assets.clevelandclinic.org/transform/LargeFeatureImage/9cbcc77b-93b7-472e-838d-ec0d5f2f9fbd/heart-healthy-foods-1279763992",
        "headline": "Healthy",
      },
      {
        "impUrl":
        "https://www.dumplingconnection.com/wp-content/uploads/2019/07/Chinese-cusine-e1586208090905.jpg",
        "headline": "Chinese ",
      },
      {
        "impUrl":
        "https://hips.hearstapps.com/del.h-cdn.co/assets/15/24/1600x800/landscape-1433889344-del-milkshakes-index.jpg?resize=1200:*",
        "headline": "Shakes",
      },
      {
        "impUrl":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSU4RVhklejw3LtywA2YnTflm3fuEkbUsEyyw&s",
        "headline": "Street Food",
      },
      {
        "impUrl":
        "https://www.linsfood.com/wp-content/uploads/2021/04/Red-Chilli-Paste-LinsFoodjpg.jpg",
        "headline": "Chilli Food",
      },
      {
        "impUrl":
        "https://c4.wallpaperflare.com/wallpaper/626/14/515/dessert-sweet-food-cake-wallpaper-preview.jpg",
        "headline": "Sweet",
      },
      {
        "impUrl":
        "https://nutritionrefined.com/wp-content/uploads/2023/08/garden-salad.jpg",
        "headline": "Salad",
      },
      {
        "impUrl":
        "https://assets.rbl.ms/21919567/origin.jpg",
        "headline": "Ice Cream",
      },
      {
        "impUrl":
        "https://img.freepik.com/premium-photo/food-photos_662583-2610.jpg?w=740",
        "headline": "Fast Food",
      },
    ];
    return Scaffold(
        backgroundColor: kLightColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          automaticallyImplyLeading: false,
          title: const Text(
            'Choose your own Taste',
            style: TextStyle(
                fontFamily: 'Hellix-Bold',
                fontWeight: FontWeight.bold,
                fontSize: 25.0),
          ),
          shape: const RoundedRectangleBorder(
              borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(15.0))),
        ),
        body: GridView.builder(
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: picPicker.length,
            itemBuilder:  (context, index){
              return GestureDetector(
                  onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchPage(picPicker[index]["headline"]))),
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    height: 200.0,
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

                                picPicker[index]["impUrl"],
                                height: 200.0,
                                width: 200.0,
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
                          bottom: 10,
                          left: 5,
                          child: Container(

                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white38,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Center(
                                child: Text(
                                    picPicker[index]["headline"],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'Hellix-Bold',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25.0)
                                ),
                              )
                          ),
                        )
                      ],
                    ),
                  ));
            }
        )
    );
  }
}

