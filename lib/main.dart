import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'resultpage.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map footballData;

  fetchData() async {
    http.Response response = await http.get("http://api.football-data.org/v2/competitions/",headers: {"X-Auth-Token" : "YOUR_API_KEY"});
    setState(() {
      footballData = jsonDecode(response.body);
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
      appBar: new AppBar(
        title: new Text("Football App",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(icon: new Icon(Icons.search,color: Colors.white,size: 25,), onPressed: (){},)
        ],
      ),
      body: footballData==null ? new Center(
        child: new CircularProgressIndicator(),
      ) : new ListView.builder(
          itemBuilder: (context , index)=>
          new Column(
            children: <Widget>[
              new RaisedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>ResultPage(title: footballData["competitions"][index]["id"].toString(),leagueName:footballData["competitions"][index]["name"] ,)));
                },
                color: Color(0x00080),
                shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                child: new ListTile(
                  title: new Text(footballData["competitions"][index]["name"],style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                  subtitle: new Text(footballData["competitions"][index]["plan"],style: TextStyle(fontSize: 15,color: Colors.grey[600],fontWeight: FontWeight.bold),),
                ),
              ),
              new Padding(padding: const EdgeInsets.only(bottom: 10)),
            ],
          )
      ),
    );
  }
}

