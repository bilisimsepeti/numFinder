import 'package:flutter/material.dart';


class SyncPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: InkWell(child: Icon(Icons.arrow_back_ios,color: Colors.black),onTap: (){
            Navigator.pop(context);
          },),
          title: Center(child: Text("Kişileri Eşitle",style: TextStyle(color: Colors.black))),
            bottom: TabBar(
              tabs: [
                Tab(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Güncellemeler",style: TextStyle(color: Colors.black)),
                    SizedBox(width: 5),
                    CircleAvatar(radius: 10,
                        backgroundColor: Colors.black,
                        child: Center(child: Text("0",style: TextStyle(fontSize: 13),)))
                  ],
                )),
                Tab(child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Çalışmalar",style: TextStyle(color: Colors.black)),
                    SizedBox(width: 5),
                    CircleAvatar(radius: 10,
                        backgroundColor: Colors.black,
                        child: Center(child: Text("0",style: TextStyle(fontSize: 13),)))
                  ],
                )),
              ],
            )),
        body: TabBarView(
          children: [
            Column(children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 300,
                        width: 300,
                        child: Image(image: AssetImage("assets/telefonsync.png"))
                    ),
                    Text("Öğe Yok"),
                  ],
                ),
              )
            ]),
            Column(children: [
              Expanded(
                child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 300,
                      width: 300,
                      child: Image(image: AssetImage("assets/telefonsync.png"))
                    ),
                    Text("Öğe Yok"),
                  ],
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
