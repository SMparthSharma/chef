import 'package:flutter/material.dart';
import 'package:mr_chef/activity/constant.dart';



class RecipeScreen extends StatefulWidget {
    String url;
    RecipeScreen(this.url,{super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  late String finalUrl=widget.url;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: ()=>Navigator.pop(context),
        child: Container(
          alignment: Alignment.center,
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 32.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20.0),topLeft: Radius.circular(20.0)),
            color: kOrangeColor
          ),
          child: const Text('Back',style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Hellix-bold',fontSize: 26.0,color: kLightColor),),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child:Container(
            margin: const EdgeInsets.only(
                left: 16.0,
                right: 16.0
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: kOrangeColor,
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: const Icon(Icons.star,color: kLightColor,size: 30.0,),
                  ),
                ),

                const SizedBox(height: 15.0,),


              ],
            ),
          ) ,

        ),
      ),
    );
  }
}
