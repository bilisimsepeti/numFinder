import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app.dart';
import 'package:flutter_app/screen/number_search.dart';
import 'package:flutter_app/screen/premium_page.dart';
import 'package:flutter_app/services/search_json.dart';
import 'package:flutter_app/styles/text.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchContact extends StatefulWidget {
  @override
  _SearchContactState createState() => _SearchContactState();
}

class _SearchContactState extends State<SearchContact> {
  final controller = TextEditingController();

  String text = "905392462904";
  var jsonMapSearch;
  //905392462904
  getNumbers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final searchAPI =
        "https://numbersearch.herokuapp.com/api/home/retrieveNumber?telephone=${text}";
    final http.Response response =
        await http.get(searchAPI, headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'bearer ${prefs.get("stringValue")}'
    });
    print(authBloc.getStringValuesSF().toString());
    if (response.statusCode == 200) {
      print(response.body);
      final Map mapUserNumber = json.decode(response.body);
      jsonMapSearch = mapUserNumber['data'];
      print(jsonMapSearch[0]["name"].toString());
      return UserNumber.fromJson(json.decode(response.body));
    } else {
      debugPrint(response.body.toString());
      print("Exeption = search contact");
      throw Exception(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("NumFinder", style: TextStyles.head)]),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NumberSearch(text: text)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 50,
                          child: TextFormField(
                            controller: controller,
                            onChanged: (value) {
                              setState(() {
                                value = controller.text;
                              });
                            },
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: "1 milyar insan ara",
                                hintStyle: TextStyle(color: Colors.white54),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        text = controller.text;
                                        getNumbers();
                                      });
                                    },
                                    child: Icon(Icons.search,
                                        color: Colors.white))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PremiumPage()));
                    },
                    leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://w7.pngwing.com/pngs/220/215/png-transparent-diamond-illustration-gemstone-diamond-icon-diamond-blue-angle-ring.png"),
                        radius: 25,
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.blue),
                    title: Text(
                      "Premium'a yükseltin",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Tüm özellikleri aç. Ücretsiz Dene!",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Divider(color: Colors.black),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Son Aramalar",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  FutureBuilder<dynamic>(
                    future: getNumbers(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Expanded(
                            child: ListView.builder(
                                itemCount: jsonMapSearch.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                    leading: CircleAvatar(backgroundImage: AssetImage("assets/diamond.jpg")),
                                        title: Text(jsonMapSearch[index]["name"]),
                                        subtitle: Text(jsonMapSearch[index]
                                            ["telephone"].toString()),
                                      ),
                                    ],
                                  );
                                }),
                          );
                        }
                        return Container();
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
