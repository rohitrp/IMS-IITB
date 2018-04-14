import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:iitb_ims/constant.dart';
import 'package:http/http.dart' as http;
import 'package:iitb_ims/create_paper.dart';

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
                new Tab(text: 'Profile'),
                new Tab(text: 'Papers'),
              ]
            ),
            title: new Text(this.name)
          ),
          body: new TabBarView(
            children: [
              new Scaffold(
                resizeToAvoidBottomPadding: false,
                body: new Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: new Column(
                    children: [
                      new Text(this.name),
                      new Text(this.email),
                      new Container(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: new RaisedButton(
                          onPressed: _createPaper,
                          color: Theme.of(context).accentColor,
                          elevation: 4.0,
                          splashColor: Colors.blueGrey,
                          textColor: Colors.white,
                          child: new Text('Create Paper'),
                        ),
                      ),                    ]
                  )
                )
              ),
              new Text("Papers"),
            ],
          )
        )
      )
    );
  }

  void _createPaper() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new CreatePaperScreen(email: this.email);
        }
      )
    );
  }
}