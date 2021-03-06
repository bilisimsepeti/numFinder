import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app.dart';
import 'package:http/http.dart' as http;





Future<Autogenerated> createAlbum() async {
  Firestore _db = Firestore.instance;

  final userInfo = await _db.collection("users").document(authBloc.userId).get();


  final http.Response response = await http.post(
    'https://numbersearch.herokuapp.com/api/auth/authenticateUser',
    headers: <String, String>{'Content-Type':'application/json'},
    body: jsonEncode(<String, dynamic>{
      'name': await userInfo.data["name"],
      'email':await userInfo.data["email"],
      'imageUrl': await userInfo.data["imageUrl"],
      'telephone': await userInfo.data["phone"] ,
    }),
    //'grant_type=password&username=admin@course.com&password=Admin2020@',
  );

  if (response.statusCode == 200) {
    debugPrint(response.toString());
    return Autogenerated.fromJson(json.decode(response.body));
  } else {
    debugPrint(response.body.toString());
    throw Exception(response);
  }
}
class Autogenerated {
  int codeResult;
  Data data;

  Autogenerated({this.codeResult, this.data});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    codeResult = json['codeResult'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codeResult'] = this.codeResult;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String token;

  Data({this.token});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}

class DemoAPIScreen extends StatefulWidget {
  DemoAPIScreen({Key key}) : super(key: key);

  @override
  _DemoAPIScreenState createState() {
    return _DemoAPIScreenState();
  }
}

class _DemoAPIScreenState extends State<DemoAPIScreen> {
  final TextEditingController _controller = TextEditingController();
  Future<Autogenerated> _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Data Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Create Data Example'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: (_futureAlbum == null)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: 'Enter Title')),
                    RaisedButton(
                      child: Text('Create Data'),
                      onPressed: () {
                        setState(() {
                          _futureAlbum = createAlbum();
                        });
                      },
                    ),
                  ],
                )
              : FutureBuilder<Autogenerated>(
                  future: _futureAlbum,
                  builder: (context, snapshot) {
                    print(snapshot.data.data.token.toString());
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Text(snapshot.data.data.token.toString()),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                ),
        ),
      ),
    );
  }
}
