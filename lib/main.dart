import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:npm_drinking_game/types.dart';
import 'dart:convert';

import 'bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<Package> suggestionList;

  Future<List<Objects>> getPackagesForQuery(String query) async {
    if (query.length > 2) {
      var url = "http://registry.npmjs.com/-/v1/search?text=${query}&size=5";
      //var url = 'https://www.npmjs.com/search/suggestions?q=$query';
      //var url = "https://api.npms.io/v2/search?q=$query";
      //var url= "https://www.omdbapi.com/?t=$query&apikey=e83d3bc2";
      var response = await http.get(
        url,
        // headers: {
        //   "Access-Control-Allow-Origin": "*",
        //   "Access-Control-Allow-Methods": "POST,GET,DELETE,PUT,OPTIONS"
        // }
      );
      print('Response body: ${response.body}');
      Map<String, dynamic> json = jsonDecode(response.body);
      var listJson = json["objects"] as List;
      List<Objects> list =
          listJson.map((item) => Objects.fromJson(item)).toList();
      return list;
      // return json["objects"].map((item) => Objects.fromJson(item)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Put in a random word out of a dictionary ;)!",
                style: Theme.of(context).textTheme.display1,
              ),
              TextField(
                  controller: new TextEditingController(),
                  onChanged: (query) =>
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        bloc.inputStream.add(query);
                      })),
              StreamBuilder(
                  stream: bloc.inputStream,
                  builder: (BuildContext context, AsyncSnapshot<String> snap) {
                    return FutureBuilder(
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Objects>> snap) {
                        if (snap.hasData) {
                          return Column(children: <Widget>[
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                    child: ListTile(
                                  subtitle: Text(snap
                                      .data[index].package.links.repository),
                                  title: Text(snap.data[index].package.name),
                                  isThreeLine: true,
                                  leading: Text(
                                      snap.data[index].score.finalScore != null
                                          ? snap.data[index].score.finalScore
                                              .toStringAsFixed(2)
                                          : ""),
                                  trailing: Icon(Icons.info),
                                ));
                              },
                              itemCount: snap.data.length,
                            )
                          ]);
                        } else {
                          return Text("...");
                        }
                      },
                      future: getPackagesForQuery(snap.data),
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
