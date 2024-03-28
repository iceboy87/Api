import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Employee_2.dart';
import 'Model/Employee_1.dart';

class emply extends StatefulWidget {
  const emply({super.key});

  @override
  State<emply> createState() => _emplyState();
}

class _emplyState extends State<emply> {

  //email validationrereg
  // final emailRegEx= RegExp( r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  //password hide&show

  Future<employee>? _future;
  // TextEditingController empId=TextEditingController();
  // TextEditingController empname=TextEditingController();
  // TextEditingController mobile=TextEditingController();
  // TextEditingController userName=TextEditingController();
  // TextEditingController password=TextEditingController();
  // TextEditingController conpassword=TextEditingController();
  // TextEditingController createdBy=TextEditingController();

  Future<employee> AddNewCategory(int id, String name, String mobile, String userName, String pass, String conpass, int createdby) async {
    var resp = await http.post(
        Uri.parse(
            "http://catodotest.elevadosoftwares.com/Employee/InsertEmployee"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "employeeId": id,
          "employeeName": name,
          "mobile": mobile,
          "userName": userName,
          "password": pass,
          "confirmPassword": conpass,
          "createdBy": createdby
        }));
    var data = jsonDecode(resp.body);
    return employee.fromJson(data);
  }


  // Column buildColumn() {
  //
  //
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'new Post Api',
      home: Scaffold(
        body: Container(
          child: (_future == null) ? asd() : buildFutureBuilder(),
        ),
      ),
    );
  }



  FutureBuilder<employee> buildFutureBuilder() {
    return FutureBuilder<employee>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("AddedNew");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => empy()),
            );
            if (snapshot.data!.success == true) {
              return Text("Added Successfully");
            } else {
              return Text("Not Added");
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        });
  }
}


class asd extends StatefulWidget {
  const asd({super.key});

  @override
  State<asd> createState() => _asdState();
}

class _asdState extends State<asd> {

  final formkey = GlobalKey<FormState>();Future<employee>? _future;
  TextEditingController empId=TextEditingController();
  TextEditingController empname=TextEditingController();
  TextEditingController mobile=TextEditingController();
  TextEditingController userName=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController conpassword=TextEditingController();
  TextEditingController createdBy=TextEditingController();
  Future<employee> AddNewCategory(int id, String name, String mobile, String userName, String pass, String conpass, int createdby) async {
    var resp = await http.post(
        Uri.parse(
            "http://catodotest.elevadosoftwares.com/Employee/InsertEmployee"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "employeeId": id,
          "employeeName": name,
          "mobile": mobile,
          "userName": userName,
          "password": pass,
          "confirmPassword": conpass,
          "createdBy": createdby
        }));
    var data = jsonDecode(resp.body);
    return employee.fromJson(data);
  }


  @override
  Widget build(BuildContext context) {
     return Form(
      key: formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: empId,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter the Id"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: empname,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "enter the Name",),
              onFieldSubmitted: (value){},
              validator: (name) =>
              name!.length <3 ? "Name should be at least 3 characters " :null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextFormField(
                controller: mobile,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "enter the phone"),
                validator: (value){
                  if (value==null||value.isEmpty){
                    return "please enter valid number";
                  }
                  if (value.length > 10 || value.length < 10){
                    return "Please enter 10 Digite Number";
                  }

                }
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: userName,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter the UserName"),
              onFieldSubmitted: (value){},
              validator: (name) =>
              name!.length <3 ? "Name should be at least 3 characters " :null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: password,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter the Password"),
              validator: (value){
                if(value ==null ||value.isEmpty)
                {
                  return" minimum 8 chatracters" ;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: conpassword,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter the Confirm Password"),
              validator: (value){
                if(value ==null ||value.isEmpty)
                {
                  return" minimum 8 chatracters" ;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextFormField(
              controller: createdBy,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter the int"),
            ),
          ),

          ElevatedButton(
              onPressed: () {

                // if(formkey.currentState!.validate())
                //   {
                //     setState(() {
                //       _future = AddNewCategory(
                //         // employee obj
                //           int.parse(empId.text),
                //           empname.text,
                //           mobile.text,
                //           userName.text,
                //           password.text,
                //           conpassword.text,
                //           int.parse(createdBy.text)
                //       );
                //
                //
                //     });
                //   }

                // setState(() {
                //   if(formkey.currentState!.validate())
                //   {
                //     _future = AddNewCategory(
                //       // employee obj
                //         int.parse(empId.text),
                //         empname.text,
                //         mobile.text,
                //         userName.text,
                //         password.text,
                //         conpassword.text,
                //         int.parse(createdBy.text)
                //     );
                //   }
                // });
                 _future =  AddNewCategory(
                     // employee obj
                      int.parse(empId.text),
                     empname.text,mobile.text,userName.text,password.text,conpassword.text,int.parse(createdBy.text)
                  );


                // });
              },
              child: Text("click"))
        ],
      ),
    );
  }
}
