import 'dart:convert';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app.dart';
import 'package:flutter_app/screen/premium_page.dart';
import 'package:flutter_app/services/search_json.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ContactList extends StatefulWidget {


  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  String name;
  String phone;
  List<Contact> contacts = [];
  List<Contact> contactsFiltered = [];
  Map<String, Color> contactsColorMap = new Map();
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    authBloc.getStringValuesSF();
    getNumbers();
    getAllContacts();
    searchController.addListener(() {
      filterContacts();
    });
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getAllContacts() async {
    List colors = [Colors.green, Colors.indigo, Colors.yellow, Colors.orange];
    int colorIndex = 0;
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
    _contacts.forEach((contact) {
      Color baseColor = colors[colorIndex];
      print(contact.phones);
      contactsColorMap[contact.displayName] = baseColor;
      colorIndex++;
      if (colorIndex == colors.length) {
        colorIndex = 0;
      }
    });
    setState(() {
      contacts = _contacts;
    });
    await contacts.forEach((contact)async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(contact.displayName);
      String phoneEski = contact.phones.first.value.toString();
      String phoneEski2 = phoneEski.replaceAll(RegExp('-'),'');
      String phoneEski3 = phoneEski2.replaceAll(RegExp('[(]'),'');
      String phoneEski4 = phoneEski3.replaceAll(RegExp('[)]'),'');
      String phone = phoneEski4.replaceAll(RegExp('[ ]'),'');

      print(phone);
      String name = contact.displayName;

      print(name.toString());
      final searchAPI =
          "https://numbersearch.herokuapp.com/api/home/addToContactList";
      final http.Response response = await http.post(
        searchAPI,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
          'bearer ${prefs.get("stringValue")}'
        },
        body: jsonEncode(<String, String>{
          'name': name,
          "telephone": phone,
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
        print("fdsfsdf");
        throw Exception(response);
      }
    });
  }

  filterContacts() async {
    List<Contact> _contacts = [];

    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((contact) {
        String searchTerm = searchController.text.toLowerCase();
        String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = contact.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        if (searchTermFlatten.isEmpty) {
          return false;
        }
        var phone = contact.phones.firstWhere((phn) {
          String phnFlattened = flattenPhoneNumber(phn.value);
          return phnFlattened.contains(searchTermFlatten);
        }, orElse: () => null);

        return phone != null;
      });

      setState(() {
        contactsFiltered = _contacts;
      });
    }
  }

  var jsonMAp;
  //String text = "905392462904";
  getNumbers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String name;
    String phone;
    final searchAPI =
        "https://numbersearch.herokuapp.com/api/home/addToContactList";

    final http.Response response = await http.post(
      searchAPI,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'bearer ${prefs.get("stringValue")}'
      },
      body: jsonEncode(<String, String>{
        'name': name,
        "telephone": phone,
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
      print("fdsfsdf");
      throw Exception(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: isSearching == true
                      ? contactsFiltered.length
                      : contacts.length,
                  itemBuilder: (context, index) {
                    Contact contact = isSearching == true
                        ? contactsFiltered[index]
                        : contacts[index];
                    var baseColor =
                        contactsColorMap[contact.displayName] as dynamic;
                    Color color1 = baseColor[800];
                    Color color2 = baseColor[400];
                    return ListTile(
                      title: Text(contact.displayName),
                      subtitle: Text(contact.phones.elementAt(0).value),
                      leading: (contact.avatar != null &&
                              contact.avatar.length > 0)
                          ? CircleAvatar(
                              backgroundImage: MemoryImage(contact.avatar))
                          : Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                      colors: [color1, color2],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight)),
                              child: CircleAvatar(
                                  child: Text(contact.initials(),
                                      style: TextStyle(color: Colors.white)),
                                  backgroundColor: Colors.transparent),
                            ),
                    );
                  },
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PremiumPage()));
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
            ],
          ),
        ),
      ),
    );
  }
}
