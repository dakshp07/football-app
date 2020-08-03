import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Scorers extends StatefulWidget {

  final String id;
  Scorers({this.id});

  @override
  _ScorersState createState() => _ScorersState();
}

class _ScorersState extends State<Scorers> {

  Map scorersData;
  fetchData() async {
    http.Response response = await http.get("http://api.football-data.org/v2/competitions/"+widget.id+"/scorers",headers: {"X-Auth-Token" : "YOUR_API_KEY"});
    setState(() {
      scorersData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scorersData == null ? new Center(
        child: new CircularProgressIndicator(),
      ) : new ListView.builder(
          itemCount: scorersData["count"],
          itemBuilder: (context , index)=>
          new Card(
            color: Color(0x00080),
            shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            child: new ListTile(
              title: new Text(scorersData["scorers"][index]["player"]["name"],style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              subtitle: new Text(scorersData["scorers"][index]["team"]["name"],style: TextStyle(fontSize: 15,color: Colors.grey[600],fontWeight: FontWeight.bold),),
              trailing: new Text(scorersData["scorers"][index]["numberOfGoals"].toString()+" Goals",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
            ),
          )
      )
    );
  }
}
