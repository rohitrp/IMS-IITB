import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String BASE_URL = "10.16.23.129:5000";

Future<http.Response> login(email, password) {
  Uri _uri  = new Uri.http(BASE_URL, '/api/login/', {"email": email, "password": password});
  return http.get(_uri);
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      _performLogin();
    }
  }

  void _performLogin() {

    final snackbar = new SnackBar(
        content: new Text('Email: $_email, password: $_password'),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);

    var _response = login(_email, _password);
    
    _response
        .then((response) => _checkLogin(response.body));
  }

  void _checkLogin(response) {
    print(response);
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            children: [
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Your email'),
                validator: (val) =>
                    !val.contains('@') ? 'Not a valid email.' : null,
                onSaved: (val) => _email = val,
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Your password'),
                validator: (val) =>
                    val.length < 6 ? 'Password too short.' : null,
                onSaved: (val) => _password = val,
                obscureText: true,
              ),
              new RaisedButton(
                onPressed: _submit,
                child: new Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}