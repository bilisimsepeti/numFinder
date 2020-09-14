import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/screen/premium_page.dart';
import 'package:flutter_app/services/search_json.dart';
import 'package:http/http.dart' as http;

class PremiumSpam extends StatefulWidget {
  @override
  _PremiumSpamState createState() => _PremiumSpamState();
}

class _PremiumSpamState extends State<PremiumSpam> {

  @override
  void initState() {
    super.initState();
    getAllSpam();
  }


  addToSpam() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(phone);
    print(name);
    var jsonMAp;
    final searchAPI =
        "https://numbersearch.herokuapp.com/api/home/addToSpam";
    final http.Response response = await http.post(
      searchAPI,

      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'bearer ${prefs.get("stringValue")}'
      },
      body: jsonEncode(<String, String>{
        'name': name,
        "number": phone,
      }),

    );

    if (response.statusCode == 200) {
      print(response.body);
      final Map mapUserNumber = json.decode(response.body);
      jsonMAp = mapUserNumber['data'];
      print(jsonMAp[0]["name"].toString());
      return UserNumber.fromJson(json.decode(response.body));
    } else {
      debugPrint(response.body.toString());
      print("Add to Spam Exeption");
      throw Exception(response);
    }
  }

  getAllSpam() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(phone);
    print(name.toString());
    final searchAPI =
        "https://numbersearch.herokuapp.com/api/home/getSpamList";
    final http.Response response = await http.get(
      searchAPI,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
        'bearer ${prefs.get("stringValue")}'
      },
    );
    if (response.statusCode == 200) {
      print(searchAPI);
      print(response.body);
      final Map mapUserNumber = json.decode(response.body);
      jsonMapSpam = mapUserNumber['result'];
      print("Json içindeki number" + jsonMapSpam[0]["number"].toString());
      return UserNumber.fromJson(json.decode(response.body));
    } else {
      debugPrint(response.body.toString());
      print("spam exception");
      throw Exception(response);
    }

  }

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String name;
  String phone;
  var jsonMapSpam;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _showDialog(context),
        ),
        appBar: AppBar(
            title: Text("NumFinder"),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(child: Text("Spam List")),
                Tab(child: Text("Spam Ekle")),
              ],
            )),
        body: TabBarView(
          children: [
            Column(children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                "Türkcell Müşteri Hizmetleri",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "442 0 532",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              )
            ]),
            Column(children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: FutureBuilder<dynamic>(
                        future: getAllSpam(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return ListView.builder(
                                  itemCount: jsonMapSpam.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(backgroundImage: AssetImage("assets/diamond.jpg")),
                                          title: Text(jsonMapSpam[index]["name"]),
                                          subtitle: Text(jsonMapSpam[index]["number"].toString()),
                                        ),
                                      ],
                                    );
                                  });
                            }
                            return Container();
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),

                  ],
                ),
              ),

            ]),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: Column(
                        children: [
                          TextField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                setState(() {
                                  name = nameController.text;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "Name",
                                enabledBorder: OutlineInputBorder(),
                              )),
                          SizedBox(height: 10),
                          TextField(
                              keyboardType: TextInputType.number,
                              controller: phoneController,
                              onChanged: (value) {
                                setState(() {
                                  phone = phoneController.text;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "Number",
                                enabledBorder: OutlineInputBorder(),
                              )),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        child: Text("Vazgeç"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 10),
                      RaisedButton(
                        child: Text("Ekle"),
                        onPressed: () {
                          setState(() {
                            //name = nameController.text;
                            //phone = phoneController.text;
                            addToSpam();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
