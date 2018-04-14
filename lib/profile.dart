import 'package:flutter/material.dart';
import 'package:iitb_ims/constant.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Rohit',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Rohit Prasad'),
        ),
        body: new Center(
          child: new Text('Hello')
        )
      )
    );
  }
}