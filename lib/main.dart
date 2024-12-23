import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_scholar_api/paper.dart';

import 'package:http/http.dart' as http;

import 'dart:convert' show json;

import 'paper.dart';
import 'dart:convert';
import 'ResultPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'GDG TCU Scholoar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textEditingController = TextEditingController();

  Future<String> getUPapers_python(String query) async {
    try {
      final response = await http.get(
        Uri.parse("http://127.0.0.1:8888/query?q=$query"),
      );

      if (response.statusCode == 200) {
        String data = response.body;
        return data;
      } else {
        throw Exception(
            'Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Error: $e');
    }
  }

  List<Paper> extractPaperInfo(String jsonText) {
    final decodedJson = json.decode(jsonText);
    List<Paper> result = [];
    for (final organicResult in decodedJson) {
      result.add(Paper(
          title: organicResult["bib"]["title"],
          link: organicResult["pub_url"],
          citedByCount: organicResult["num_citations"]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo.png'),
            Form(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: _textEditingController,
                  )),
                  ElevatedButton.icon(
                      onPressed: () async {
                        String jsonapi = await getUPapers_python(
                            _textEditingController.text);
                        List<Paper> papers = extractPaperInfo(jsonapi);
                        papers.sort(
                            (a, b) => b.citedByCount.compareTo(a.citedByCount));
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Resultpage(
                                  paper_result: papers,
                                )));
                      },
                      label: Text('search'),
                      icon: Icon(Icons.search)),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
