import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url = 'https://swapi.co/api/people/';
  List data;

  @override
  void initState() {
    super.initState();
    this.getJsondata();
  }

  Future<String> getJsondata() async {
    var response = await http.get(
        //*ENCODING THE URL
        Uri.encodeFull(url),
        //*ONLY ACCEPTING THE JSON DATA
        headers: {
          'Accept': 'application/json',
        });
        print(response.body);

        setState(() {
          var convertDataToJson = json.decode(response.body);
          data=convertDataToJson['result'];
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP Requests Demo"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: data==null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  child: Container(
                    child: Text("Name : "+ data[index]['name']),
                    padding: const EdgeInsets.all(15),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
