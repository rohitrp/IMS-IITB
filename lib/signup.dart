import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'constant.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => new _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  String _email, _name, _password;

  void _submit() {
    final form = formKey.currentState;
    print("HERE");
    if (form.validate()) {
      form.save();

      _performSignup();
    }
  }

  void _performSignup() {
    var client = new http.Client();
    var _uri = new Uri.http(BASE_URL, '/api/signup/');
    print(_uri.toString());
    client.post(
      _uri,
      body: {"email": _email, "name": _name, "password": _password})
    .then((response) => client.get(response.body))
    .then((response) => print(response.body))
    .whenComplete(client.close);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('Signup'),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: [
              new TextFormField(
                decoration: new InputDecoration(labelText: "Full Name"),
                validator: (val) => val.isEmpty ? 'Cannot be blank' : null,
                onSaved: (val) => _name = val,
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: "Email"),
                validator: (val) =>
                    !val.contains('@') ? 'Not a valid email.' : null,
                onSaved: (val) => _email = val,
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: "Password"),
                validator: (val) =>
                    val.length < 6 ? 'Password too short' : null,
                onSaved: (val) => _password = val,
                obscureText: true,
              ),
              new RaisedButton(
                onPressed: _submit,
                child: new Text('Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}