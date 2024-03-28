
import 'package:api/EntriesAPI.dart';
import 'package:api/pop.dart';
import 'package:flutter/material.dart';

import 'Date_1.dart';
import 'Employee.dart';
import 'Model/coin2.dart';
import 'Model_Task_1.dart';
import 'Post_Api.dart';
import 'Randam_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: emply(),
    );
  }
}
