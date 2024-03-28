import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/Post_Api_1.dart';

class success extends StatefulWidget {
  const success({super.key});

  @override
  State<success> createState() => _successState();
}

class _successState extends State<success> {

  Future<Success>? _future;
  TextEditingController textcat=TextEditingController();
  TextEditingController text=TextEditingController();


  Future<Success> AddNewCategory(String cate, String desc) async {
    var resp = await http.post(Uri.parse(
        "http://catodotest.elevadosoftwares.com/category/insertcategory"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String,dynamic>{
          "categoryId":706,
          "category":"test",
          "description":"Dress",
          "deletedOn":null,
          "removedRemarks":null,
          "createdBy":"1"
        })
    );
    var data=jsonDecode(resp.body);
    return Success.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'new Post Api',
      home: Scaffold(
        body: Container(
          child: (_future == null)? buildColumn() : buildFutureBuilder(),
        ),
      ),
    );
  }
  Column buildColumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          controller: textcat,
          decoration: const InputDecoration(hintText: "enter the catagory"),
        ),
        TextFormField(
          controller: text,
          decoration: const InputDecoration(hintText: "enter the catagory"),
        ),
        ElevatedButton(onPressed: (){
          setState(() {
            _future =AddNewCategory(textcat.text,text.text);
          });
        }, child: Text("click"))
      ],
    );
  }
  FutureBuilder<Success> buildFutureBuilder(){
    return FutureBuilder<Success>(
        future: _future, builder: (context,snapshot){
          if (snapshot.hasData){
            if(snapshot.data!.success == true){
              return Text("Added Successfully");
            }
            else{
              return Text("Not Added");
            }
          }
          else if(snapshot.hasError){
            return Text("${snapshot.error}");

          }
          return const CircularProgressIndicator();
    });

  }

}
