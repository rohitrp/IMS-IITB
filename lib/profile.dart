import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:iitb_ims/constant.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  final String email, name;

  ProfilePage({Key key, @required this.email, @required this.name}) : super(key: key);

  @override
  _ProfilePageState createState() => new _ProfilePageState(this.email, this.name);
}

class _ProfilePageState extends State<ProfilePage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final String email, name;

  _ProfilePageState(this.email, this.name);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red[600],
        accentColor: Colors.grey[600],
      ),
      home: new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new AppBar(
            bottom: new TabBar(
              tabs: [
                new Tab(text: 'Papers'),
                new Tab(text: 'Profile'),
              ]
            ),
            title: new Text(this.name)
          ),
          body: new TabBarView(
            children: [
              new Text("Papers"),
              new Text("Profile")
            ],
          )
        )
      )
    );
  }
}