import 'package:mr_chef/activity/constant.dart';
import 'package:mr_chef/activity/searchPage.dart';
import 'package:flutter/material.dart';
class Cuisine extends StatelessWidget {
  const Cuisine({super.key});

  @override
  Widget build(BuildContext context) {
    List picPicker1=[
      {"impUrl":"https://www.tastingtable.com/img/gallery/20-delicious-indian-dishes-you-have-to-try-at-least-once/intro-1645057933.webp","headline":"Indian "},
      {"impUrl":"https://img.freepik.com/premium-photo/food-photos_662583-2610.jpg?w=740","headline":"Fast Food",},
      {"impUrl":"https://assets.clevelandclinic.org/transform/LargeFeatureImage/9cbcc77b-93b7-472e-838d-ec0d5f2f9fbd/heart-healthy-foods-1279763992","headline":"Healthy",},
      {"impUrl":"https://www.dumplingconnection.com/wp-content/uploads/2019/07/Chinese-cusine-e1586208090905.jpg","headline":"Chinese ",},
      {"impUrl":"https://hips.hearstapps.com/del.h-cdn.co/assets/15/24/1600x800/landscape-1433889344-del-milkshakes-index.jpg?resize=1200:*","headline":"Shakes",},
     ];
    List picPicker2=[
      {"impUrl":"https://c4.wallpaperflare.com/wallpaper/626/14/515/dessert-sweet-food-cake-wallpaper-preview.jpg","headline":"Sweet",},
      {"impUrl":"https://www.domex-uk.co.uk/wp-content/uploads/2020/08/Keep-ice-cream-scoopable-in-freezer.jpg","headline":"Ice Cream",},
      {"impUrl":"https://nutritionrefined.com/wp-content/uploads/2023/08/garden-salad.jpg","headline":"Salad",},
      {"impUrl":"https://www.linsfood.com/wp-content/uploads/2021/04/Red-Chilli-Paste-LinsFoodjpg.jpg","headline":"Chilli",},
      {"impUrl":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSU4RVhklejw3LtywA2YnTflm3fuEkbUsEyyw&s","headline":"Street",},

    ];
    return Scaffold(
      backgroundColor: kLightColor,
      appBar:AppBar(
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Choose your own Taste',
          style: TextStyle(
              fontFamily: 'Hellix-Bold',
              fontWeight: FontWeight.bold,
              fontSize: 25.0),
        ),
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0))) ,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: kLightColor,
          child: Row(
            children: [
              Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
                width: (MediaQuery.of(context).size.width)/2,
                child: ListView.builder(
                  itemCount: 5,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder:  (context, index) {
            return GestureDetector(
                onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchPage(picPicker1[index]["headline"]))),
            child: Container(
            margin: const EdgeInsets.all(10.0),
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

                          picPicker1[index]["impUrl"],
                          height: 200.0,
                          width: 200.0,
                          fit: BoxFit.cover,

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
                            picPicker1[index]["headline"],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: 'Hellix-Bold',
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0)
                        ),
                      )
                    ),
                  )
                ],
              ),
            ));},
                ),
              ),
              Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
                width: (MediaQuery.of(context).size.width)/2,
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder:  (context, index) {
                    return GestureDetector(
                        onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchPage(picPicker2[index]["headline"]))),
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
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

                                      picPicker2[index]["impUrl"],
                                      height: 200.0,
                                      width: 200.0,
                                      fit: BoxFit.cover,

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
                                          picPicker2[index]["headline"],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: 'Hellix-Bold',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0)
                                      ),
                                    )
                                ),
                              )
                            ],
                          ),
                        ));},
                ),
              ),
            ],
          ),

              ),
      ),
    );
  }
}

