import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'Model/OrgEbtry.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {

  Future<List<dynamic>>Fatch()async{
    var resp =await http.get(Uri.parse("https://www.boredapi.com/api/activity"));
    var data =jsonDecode(resp.body)["board"];
    return (data as List).map((e) =>  Entries.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Fatch(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Text((snapshot.data!).toString()),
                // Text(snapshot.data!.chartName.toString()),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Text("Loading");
        },
      ),
    );
  }
}
