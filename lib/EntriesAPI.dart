import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/OrgEbtry.dart';

class EntriesAPI extends StatefulWidget {
  const EntriesAPI({super.key});

  @override
  State<EntriesAPI> createState() => _EntriesAPIState();
}

class _EntriesAPIState extends State<EntriesAPI> {
  Future<OrgEntry>? _future;
  
  Future<List<Entries>> Fetch() async
  {
    var resp = await http.get(Uri.parse("https://api.publicapis.org/entries"));
    var data = jsonDecode(resp.body)["entries"];
    return (data as List).map((e) =>  Entries.fromJson(e)).toList();

    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: Fetch(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Entries> list  = snapshot.data!;
              List<Entries> filter = list.where((element) => element.category == "Animals").toList();
              if(filter.length > 0) {
                return ListView.builder(
                    itemCount: filter!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Text(filter![index].aPI.toString()),
                          Text("---------"),
                          Text(filter[index]!.description.toString()),
                          Text("---------"),
                          Text(filter[index].category.toString()),
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
