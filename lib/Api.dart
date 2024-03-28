import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/CatFactClass.dart';
class CatAPI extends StatefulWidget {
  const CatAPI({super.key});

  @override
  State<CatAPI> createState() => _CatAPIState();
}

class _CatAPIState extends State<CatAPI> {

  String fact = "gfd";
  int length = 0;
  Future<coinDesk>? _future;
  Future GetDetails() async{
    var resp = await http.get(Uri.parse("https://catfact.ninja/fact"));
    print(resp.body);
    print(resp.statusCode);

    var data = jsonDecode(resp.body);
    setState(() {
      fact = data["fact"];
      length = data["length"];
    });

    print(fact);
    print(length);

  }

  Future<coinDesk> Fetch() async{
    var resp = await http.get(Uri.parse("https://catfact.ninja/fact"));
    var data = jsonDecode(resp.body);
    return coinDesk.fromJson(data);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //GetDetails();
    _future = Fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<coinDesk>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Text(snapshot.data!.fact.toString()),
                Text(snapshot.data!.length.toString()),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return Text("Loading");
        },
      ));

  }
}
