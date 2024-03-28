import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
// import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'Model/Model_Task.dart';
// import 'model/git_api.dart';

class dud extends StatefulWidget {
  const dud({super.key});

  @override
  State<dud> createState() => _dudState();
}

class _dudState extends State<dud> {
  var size,height,width;
  Future<List<Items>> fetch() async{
    var a = await http.get(Uri.parse("https://api.github.com/search/repositories?q=created"));
    var data = jsonDecode(a.body)["items"];
    // print(a.body);
    return (data as List).map((e) => Items.fromJson(e)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: fetch(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    List<Items> getting = snapshot.data!;
                    DateTime now = new DateTime.now();
                    DateTime last = now.subtract(Duration(days:30));
                    print(last);
                    List<Items> filtered = getting.where((element) => element.updatedAt!.isAfter(last)).toList();
                    print(filtered.length);
                    return Container(
                      height: 900,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: filtered.length,
                          itemBuilder: (BuildContext context, int index){
                            return Card(
                              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              // color: Colors.blueAccent,
                              child: Column(
                                children: [
                                  Container(
                                    height:MediaQuery.of(context).size.height * 0.20,
                                    width:MediaQuery.of(context).size.width * 0.30,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage("${filtered[index].owner!.avatarUrl.toString()}")
                                        )
                                    ),
                                  ),
                                  Text(filtered[index].name.toString(),style: TextStyle(color: Colors.blue,fontSize: 20,fontFamily: "ARLRDBD",fontWeight: FontWeight.w500)),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(filtered[index].updatedAt.toString(),style: TextStyle(color: Colors.pink,fontWeight: FontWeight.w500,fontSize: 19),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(filtered[index].description.toString(),style: TextStyle(color: Colors.green,fontSize: 18,fontFamily: "ARLRDBD",fontWeight: FontWeight.w500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(filtered[index].fullName.toString(),style: TextStyle(color: Colors.purple,fontSize: 20,fontFamily: "BRLNS",fontWeight: FontWeight.w300)),
                                  ),
                                  Text(filtered[index].stargazersCount.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,fontFamily: "ARLRDBD"),)





                                ],
                              ),
                            );
                          }
                      ),
                    );
                  }else if(snapshot.hasError){
                    return Text("${snapshot.error}");
                  }return CircularProgressIndicator();
                }
            ),
          ],
        ),
      ),

    );
  }
}