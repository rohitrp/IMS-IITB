import 'package:flutter/material.dart';
import 'package:iitb_ims/login.dart';
import 'package:iitb_ims/signup.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red[600],
          accentColor: Colors.grey[600],
        ),      home: new DefaultTabController(
        length: 2,
        child: new Scaffold(
          appBar: new AppBar(
            bottom: new TabBar(
              tabs: [
                new Tab(text: 'Login'),
                new Tab(text: 'Signup'),
              ],
            ),
            title: new Text('IMS IIT Bomby')
          ),
          body: new TabBarView(
            children: [
              new LoginPage(),
              new SignupPage(),
            ],
          )
        )
      )
    );
  }
}
