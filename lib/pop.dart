import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart 'as http;
import 'Model/api.dart';

class pop extends StatefulWidget {
  const pop({super.key});

  @override
  State<pop> createState() => _popState();
}

class _popState extends State<pop> {
  Future<List<Source>> Fetch() async
  {
    var resp = await http.get(Uri.parse("https://datausa.io/api/data?drilldowns=Nation&measures=Population"));
    var data = jsonDecode(resp.body)["source"];
    return (data as List).map((e) =>  Source.fromJson(e)).toList();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: Fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Source> filter  = snapshot.data!;
              // List<Source> filter = list.where((element) => element. == "Animals").toList();
              if(filter.length > 0) {
                return ListView.builder(
                    itemCount: filter!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Text(filter[index]!.measures.toString()),
                          Text(filter[index]!.annotations.toString()),
                          Text("---------"),
                          Text(filter[index]!.name.toString()),
                        ],
                      );
                    });
              }
              else
              {
                return Text("No data Found");
              }

            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return Text("Loading");
          },
        ));
  }
}
