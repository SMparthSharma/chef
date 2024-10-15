import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mr_chef/activity/constant.dart';

class RecipeScreen extends StatefulWidget {
  String url;
  RecipeScreen(this.url, {super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  late String finalUrl;
  @override
  void initState() {

    if(widget.url.toString().contains("http://")){
      finalUrl=widget.url.toString().replaceAll("http://", "https://");
    }
    else{
      finalUrl=widget.url;
    }
    super.initState();
  }
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          alignment: Alignment.center,
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 32.0),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0)),
              color: kOrangeColor),
          child: const Text(
            'Back',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Hellix-bold',
                fontSize: 26.0,
                color: kLightColor),
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: WebUri(finalUrl)),
                  onWebViewCreated: (InAppWebViewController controller) {
                    inAppWebViewController = controller;
                  },
                  onProgressChanged:
                      (InAppWebViewController controller, int progress) {
                    setState(() {
                      _progress = progress / 100;
                    });
                  },
                ),

              ),
            ),
            _progress<1?const LinearProgressIndicator(color: Colors.blue,):const SizedBox()
          ],
        ),
      ),
    );
  }
}

