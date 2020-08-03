import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Standings extends StatefulWidget {

  final String sId;
  Standings({this.sId});

  @override
  _StandingsState createState() => _StandingsState();
}

class _StandingsState extends State<Standings> {

  Map standingsData;
  fetchData() async {
    http.Response response = await http.get("http://api.football-data.org/v2/competitions/"+widget.sId+"/standings",headers: {"X-Auth-Token" : "YOUR_API_KEY"});
    setState(() {
      standingsData = jsonDecode(response.body);
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
      body: standingsData==null ? new Center(
        child: new CircularProgressIndicator(),
      ) : new ListView.builder(
          itemCount: 20,
          itemBuilder: (context , index)=>
          new Column(
            children: <Widget>[
              new Card(
                color: Color(0x000080),
                shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                child: new Row(
                  children: <Widget>[
                    new Padding(padding: const EdgeInsets.symmetric(horizontal: 10)),
                    //new Text((index+1).toString()+")",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Padding(padding: const EdgeInsets.only(top: 15)),
                        new Text(standingsData["standings"][0]["table"][index]["team"]["name"],style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                        new Padding(padding: const EdgeInsets.symmetric(horizontal: 100)),
                        new SvgPicture.network(standingsData["standings"][0]["table"][index]["team"]["crestUrl"],width: 50,height: 60),
                        new Padding(padding: const EdgeInsets.only(bottom: 10)),
                      ],
                    ),
                    new SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: new Column(
                          children: <Widget>[
                            new Padding(padding: const EdgeInsets.only(bottom: 5)),
                            new Row(children:<Widget>[
                              new Text("Points : ",style: TextStyle(fontSize: 20,color:Colors.grey[800],fontWeight: FontWeight.bold),),
                              new Text(standingsData["standings"][0]["table"][index]["points"].toString(),style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                            ]
                            ),
                            new Padding(padding: const EdgeInsets.only(bottom: 5)),
                              new Row(children:<Widget>[
                                new Text("Total Games : ",style: TextStyle(fontSize: 20,color:Colors.grey[800],fontWeight: FontWeight.bold),),
                                new Text(standingsData["standings"][0]["table"][index]["playedGames"].toString(),style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                              ]
                              ),
                            new Padding(padding: const EdgeInsets.only(bottom: 5)),
                            new Row(children:<Widget>[
                              new Text("Won : ",style: TextStyle(fontSize: 20,color:Colors.grey[800],fontWeight: FontWeight.bold),),
                              new Text(standingsData["standings"][0]["table"][index]["won"].toString(),style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                            ]
                            ),
                            new Padding(padding: const EdgeInsets.only(bottom: 5)),
                            new Row(children:<Widget>[
                              new Text("Draw : ",style: TextStyle(fontSize: 20,color:Colors.grey[800],fontWeight: FontWeight.bold),),
                              new Text(standingsData["standings"][0]["table"][index]["draw"].toString(),style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                            ]
                            ),
                            new Padding(padding: const EdgeInsets.only(bottom: 5)),
                            new Row(children:<Widget>[
                              new Text("Lost : ",style: TextStyle(fontSize: 20,color:Colors.grey[800],fontWeight: FontWeight.bold),),
                              new Text(standingsData["standings"][0]["table"][index]["lost"].toString(),style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                            ]
                            ),
                            new Padding(padding: const EdgeInsets.only(bottom: 5)),
                            new Row(children:<Widget>[
                              new Text("Goal Diff : ",style: TextStyle(fontSize: 20,color:Colors.grey[800],fontWeight: FontWeight.bold),),
                              new Text(standingsData["standings"][0]["table"][index]["goalDifference"].toString(),style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                            ]
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
