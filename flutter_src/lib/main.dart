import 'package:codeit_kss_git_client/screens/exports.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Codeit KSS',
      theme: ThemeData(primaryColor: Colors.lightGreen),
      home: QueryPage(),
    );
  }
}
