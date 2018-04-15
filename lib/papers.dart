import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constant.dart';
import 'package:flutter/foundation.dart';


Future<Papers> fetchPapers(email) async {
  Uri _uri = new Uri.http(BASE_URL, '/api/papers/', {'email': email});
  final response = await http.get(_uri);
  return new Papers.fromJson(response.body);
}

class Papers {
  var papers;

  Papers(this.papers);

  factory Papers.fromJson(jsonData) {
    return new Papers(json.decode(jsonData));
  }
}

class PapersScreen extends StatelessWidget {
  final String email;

  PapersScreen({Key key, @required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new PapersList(email),
      resizeToAvoidBottomPadding: false,
    );
  }
}

class PapersList extends StatefulWidget {
  final String email;

  PapersList(this.email);

  @override
  createState() => new PapersListState(this.email);
}

class PapersListState extends State<PapersList> {
  final _papers = <String>[];
  final String _email;

  PapersListState(this._email);

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: const EdgeInsets.all(16.0),
        child: new FutureBuilder<Papers>(
          future: fetchPapers(this._email),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildPapersList(snapshot.data.papers);
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }

            return new CircularProgressIndicator();
          },
        )
    );
  }

  Widget _buildPapersList(papers) {
    papers = json.decode(papers);

    return new ListView.builder(
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();

        final index = i ~/ 2;

        return _buildRow(papers[index]);
      },
    );
  }

  Widget _buildRow(paper) {
    return new ListTile(
      title: new Text(paper['title']),
      onTap: () {

      },
    );
  }
}
