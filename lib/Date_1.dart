import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart'as http;

import 'Model/date.dart';

class date extends StatefulWidget {
  const date({super.key});

  @override
  State<date> createState() => _dateState();
}

class _dateState extends State<date> {
  Future<List<Items>> Fatch()async{
    var resp=await http.get(Uri.parse("https://api.github.com/search/repositories?q=created"));
    var data=jsonDecode(resp.body)["items"];
    return (data as List).map((e) => Items.fromJson(e)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Items>>(

        future: Fatch(),
        builder: (context,snapshot){
          if (snapshot.hasData){
            List<Items> list = snapshot.data!;
            DateTime now = new DateTime.now();
            DateTime last = now.subtract(Duration(days: 30));
            print(last);
            List<Items> filter = list.where((element) => element.updatedAt!.isAfter(last)).toList();
            print(filter.length);
            return ListView.builder(
                itemCount: 15,
                itemBuilder: (BuildContext context,  index){
                  return  Column(
                      children: [
                        Text(filter[index].owner!.avatarUrl.toString()),
                        Text(filter[index].name.toString()),
                        Text(filter[index].updatedAt!.toString()),
                        Text(filter[index]!.description!.toString()),
                        Text(filter[index]!.fullName!.toString()),
                        Text(filter[index]!.stargazersCount!.toString()),
                        SizedBox(height: 30,)

                      ],
                    );

                }

            );

          }
          else if (snapshot.hasError)
            return Text('${snapshot.error}');
          return CircularProgressIndicator();

        },
      ),
    );
  }
}
