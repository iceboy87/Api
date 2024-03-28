import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Model/Get_Employee.dart';

class empy extends StatefulWidget {
  const empy({super.key});

  @override
  State<empy> createState() => _empyState();
}

class _empyState extends State<empy> {
  Future<List<EmployeeList>> Fetch() async {
    var resp = await http.get(Uri.parse("http://catodotest.elevadosoftwares.com/Employee/GetAllEmployeeDetails"));
    var data = jsonDecode(resp.body)["employeeList"];
    return (data as List).map((e) => EmployeeList.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: Fetch(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<EmployeeList> filter = snapshot.data!;
          return ListView.builder(
              itemCount: filter!.length,
              itemBuilder: (BuildContext context, index) {
                return Column(
                  children: [
                    Text(filter[index]!.employeeId.toString()),
                    Text(filter[index]!.employeeName.toString()),
                    Text(filter[index]!.mobile.toString()),
                    Text(filter[index]!.password.toString()),
                    Text(filter[index]!.confirmPassword.toString()),
                    Text(filter[index]!.userName.toString()),
                    Text(filter[index]!.createdBy.toString()),
                  ],
                );
              });
        } else if (snapshot.hasError) return Text('${snapshot.error}');
        return CircularProgressIndicator();
      },
    ));
  }
}
