import 'package:mr_chef/activity/constant.dart';
import 'package:mr_chef/activity/searchPage.dart';
import 'package:flutter/material.dart';
import 'model.dart';
class Cuisine extends StatelessWidget {
  const Cuisine({super.key});

  @override
  Widget build(BuildContext context) {

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

