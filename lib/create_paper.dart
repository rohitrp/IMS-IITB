import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'constant.dart';
import 'dart:convert';

class CreatePaperScreen extends StatefulWidget {
  final String email;

  CreatePaperScreen({Key key, @required this.email}) : super(key: key);

  @override
  createState() => new _CreatePaperScreenState(this.email);
}

class _CreatePaperScreenState extends State<CreatePaperScreen> {
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _title, _body, _email;

  _CreatePaperScreenState(this._email);

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      _savePaper(_title, _body);
    }
  }

  void _savePaper(title, body) {
    var client = new http.Client();
    var _uri = new Uri.http(BASE_URL, '/api/papers/create/');
    client.post(
      _uri,
      body: {'title': title, 'body': body, 'email': this._email})
    .then((response) => _checkResponse(response.body))
    .whenComplete(client.close);
  }

  void _checkResponse(response) {
    response = json.decode(response);
    if (response['status'] == 1) {

      final snackbar = new SnackBar(
        content: new Text('Paper successfully created'),
      );

      scaffoldKey.currentState.showSnackBar(snackbar);
      formKey.currentState.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Create Paper',
      theme: new ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.red[600],
        accentColor: Colors.grey[600],
      ),
      home: new Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          title: new Text('Create Paper'),
        ),
        resizeToAvoidBottomPadding: false,
        body: new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.all(16.0),
                child: new TextFormField(
                  decoration: new InputDecoration(
                      hintText: 'Paper title'
                  ),
                  validator: (val) => val.isEmpty ? "Required" : null,
                  onSaved: (val) => _title = val,
                ),
              ),
              new Container(
                  padding: const EdgeInsets.all(16.0),
                  child: new TextFormField(
                    decoration: new InputDecoration(
                        hintText: 'Paper body'
                    ),
                    validator: (val) => val.isEmpty ? "Required" : null,
                    maxLines: 20,
                    onSaved: (val) => _body = val,
                  )
              ),
              new Container(
                padding: const EdgeInsets.all(16.0),
                child: new RaisedButton(
                  onPressed: _submit,
                  color: Theme.of(context).accentColor,
                  elevation: 4.0,
                  splashColor: Colors.blueGrey,
                  textColor: Colors.white,
                  child: new Text('Submit'),
                ),
              )

            ],
          )
        ),
      )
    );
  }
}