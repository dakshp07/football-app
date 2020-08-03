import 'package:flutter/material.dart';
import 'scorers.dart';
import 'standings.dart';

class ResultPage extends StatefulWidget {

  final String title;
  final String leagueName;
  ResultPage({this.title,this.leagueName});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        brightness: Brightness.dark,
      ),
      home: DefaultTabController(
          length: 3,
          child: new Scaffold(
            appBar: new AppBar(
              title: new Text(widget.leagueName,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              bottom: new TabBar(
                tabs: [
                  Tab(text: "MATCHES",),
                  Tab(text: "STANDINGS",),
                  Tab(text: "SCORERS",),
                ],
              ),
            ),
            body: new TabBarView(
                children: [
                  new Text("Working"),
                  Standings(sId: widget.title,),
                  Scorers(id: widget.title,),
                ],
            ),
          )
      ),
    );
  }
}
