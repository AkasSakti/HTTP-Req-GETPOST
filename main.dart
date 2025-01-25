import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('HTTP Request Example'),
        ),
        body: HttpExample(),
      ),
    );
  }
}

class HttpExample extends StatefulWidget {
  @override
  _HttpExampleState createState() => _HttpExampleState();
}

class _HttpExampleState extends State<HttpExample> {
  String _getResponse = '';
  String _postResponse = '';

  // Fungsi untuk melakukan GET request
  Future<void> _makeGetRequest() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _getResponse = response.body;
      });
    } else {
      setState(() {
        _getResponse = 'Failed to load data';
      });
    }
  }

  // Fungsi untuk melakukan POST request
  Future<void> _makePostRequest() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': 'foo',
        'body': 'bar',
        'userId': '1',
      }),
    );

    if (response.statusCode == 201) {
      setState(() {
        _postResponse = response.body;
      });
    } else {
      setState(() {
        _postResponse = 'Failed to post data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: _makeGetRequest,
            child: Text('Make GET Request'),
          ),
          Text('GET Response: $_getResponse'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _makePostRequest,
            child: Text('Make POST Request'),
          ),
          Text('POST Response: $_postResponse'),
        ],
      ),
    );
  }
}
