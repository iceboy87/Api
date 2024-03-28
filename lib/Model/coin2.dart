import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../coin.dart';




class cointask extends StatefulWidget {
  const cointask({super.key});

  @override
  State<cointask> createState() => _cointaskState();
}

class _cointaskState extends State<cointask> {
  Future<coinDesk>? _future;
  Future<coinDesk> Fetch() async{
    var resp = await http.get(Uri.parse("https://api.coindesk.com/v1/bpi/currentprice.json"));
    var data = jsonDecode(resp.body);
    return coinDesk.A(data);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                  Text(jsonEncode(snapshot.data!).toString()),
                 // Text(snapshot.data!.chartName.toString()),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return Text("Loading");
          },
        )
    );
  }
}
