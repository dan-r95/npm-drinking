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

  List<Package> list;

  Future<List<Package>> getPackagesForQuery(String query) async {
    //var url = "http://registry.npmjs.com/-/v1/search?text=${query}&size=20";
    //var url = 'https://www.npmjs.com/search/suggestions?q=$query';
    var url = "https://api.npms.io/v2/search?q=$query";
    var response = await http.get(url, headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "POST,GET,DELETE,PUT,OPTIONS"
    });
    print('Response body: ${response.body}');
    List dynamic = jsonDecode(response.body);
    list = dynamic.map((item) => Package.fromJson(item)).toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Put in a random word!"),
            TextField(
                controller: new TextEditingController(),
                onChanged: (query) =>
                    Future.delayed(const Duration(milliseconds: 500), () {
                      bloc.inputStream.add(query);
                    })),
            StreamBuilder(
                stream: bloc.inputStream,
                builder: (BuildContext context, AsyncSnapshot<String> snap) {
                  return FutureBuilder(
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Package>> snap) {
                      if (snap.hasData) {
                        return ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Text(list[index].name);
                          },
                          itemCount: list.length,
                        );
                      } else {
                        return Text("...");
                      }
                    },
                    future: getPackagesForQuery(snap.data),
                  );
                }),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
