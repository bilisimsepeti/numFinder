import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/styles/base.dart';
import 'package:flutter_app/styles/buttons.dart';
import 'package:flutter_app/widgets%20/button.dart';

class PremiumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Container())
,          Expanded(
            flex: 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Pro Olun",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("30 gün boyunca ücretsiz olarak deneyin")],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: ButtonStyles.buttonHeight,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.circular(BaseStyles.borderRadius),
                            boxShadow: BaseStyles.boxShadow),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Premium",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 100,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                backgroundImage: AssetImage("assets/sosyal.png")),
                            ),
                            SizedBox(height: 5),
                            Expanded(child: Text("Sosyal Profilleri Açın",textAlign: TextAlign.center))
                          ],
                        ),
                      )),
                      Expanded
                        (
                          child: Container(
                        height: 100,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                  backgroundImage: AssetImage("assets/yedek.png")),
                            ),
                            SizedBox(height: 5),
                            Expanded(child: Text("Kişilerin Yedeği",textAlign: TextAlign.center))
                          ],
                        ),
                      )),
                      Expanded
                        (
                          child: Container(
                            height: 100,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CircleAvatar(
                                      backgroundImage: AssetImage("assets/kimlik.png")),
                                ),
                                SizedBox(height: 5),
                                Expanded(child: Text("Arayan Kimliği Temaları",textAlign: TextAlign.center))
                              ],
                            ),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            height: 100,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CircleAvatar(
                                      backgroundImage: AssetImage("assets/kopya.png")),
                                ),
                                SizedBox(height: 5),
                                Expanded(child: Text("Kopya Kişileri Birlşetirin",textAlign: TextAlign.center))
                              ],
                            ),
                          )),
                      Expanded
                        (
                          child: Container(
                            height: 100,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CircleAvatar(
                                      backgroundImage: AssetImage("assets/reklam.png")),
                                ),
                                SizedBox(height: 5),
                                Expanded(child: Text("Rekamları Kaldırın",textAlign: TextAlign.center))
                              ],
                            ),
                          )),
                      Expanded
                        (
                          child: Container(
                            height: 100,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: CircleAvatar(
                                      backgroundImage: AssetImage("assets/rapor.png")),
                                ),
                                SizedBox(height: 5),
                                Expanded(child: Text("Tam Rapor",textAlign: TextAlign.center))
                              ],
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Flexible(
                    child: Container(
                      height: 100,
                      child: CarouselSlider(
                        options: CarouselOptions(height: 100, autoPlay: true),
                        items: [
                          Container(
                            child: Text("Yorum"),
                          )
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        onPressed: ()=> Navigator.pushNamedAndRemoveUntil(context, "/premiumHome", (route) => false),
                          buttonText: "Devam Et", buttonType: ButtonType.Google),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              child: Text(
                                  "30 günlük ücretsiz denemeye başlayın\nsonrasında aylık 19.90 TL",
                                  textAlign: TextAlign.center)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class FeatureWidgets extends StatelessWidget {

  final Color color;
  final String name;
  final String png;

  const FeatureWidgets({this.color, this.name, this.png});

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
          height: 100,
          color: color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                  child: Icon(
                    Icons.person,
                  )),
              SizedBox(height: 5),
              Text(name)
            ],
          ),
        ));
  }
}
