import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_scholar_api/paper.dart';

import 'package:http/http.dart' as http;

import 'dart:convert' show json;

import 'paper.dart';

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
  int _counter = 0;

  final _textEditingController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<String> getContent(String url) async {
    final response = await http.get(Uri.parse(url));

    return response.body;
  }

  Future<String> loadAsset() async {
    return rootBundle.loadString('text/json_scholoar.json');
  }

  Future<String> getUPapers(String query) async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://serpapi.com/search.json?engine=google_scholar&q=$query&api_key="),
      );

      if (response.statusCode == 200) {
        final data = response.body;
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
    final organicResults = decodedJson["organic_results"];
    List<Paper> result = [];
    for (final organicResult in organicResults) {
      result.add(Paper(
          title: organicResult["title"],
          link: organicResult["link"],
          citedByCount: organicResult["inline_links"]["cited_by"]["total"]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo.png'),
            ElevatedButton(
                onPressed: () async {
                  final content = await loadAsset();
                  final decodedJson = json.decode(content);
                  // final content = await getContent(
                  //     "https://raw.githubusercontent.com/Yu-HaruWolf/qiita-contents/refs/heads/main/package.json");
                  print(content);
                },
                child: Text('json file')),
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
                        String jsonapi =
                            await getUPapers(_textEditingController.text);
                      },
                      label: Text('api'),
                      icon: Icon(Icons.send)),
                ],
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
