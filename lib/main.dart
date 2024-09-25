import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_scholar_api/paper.dart';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

  Future<String> getUsers() async {
    try {
      final response = await http.get(
        Uri.parse("https://randomuser.me/api?results=50&seed=galaxies"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

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
          citedBy: organicResult["inline_links"]["cited_by"]["total"]));
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
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
                onPressed: () async {
                  final content = await loadAsset();
                  final decodedJson = json.decode(content);
                  // final content = await getContent(
                  //     "https://raw.githubusercontent.com/Yu-HaruWolf/qiita-contents/refs/heads/main/package.json");
                  print(content);
                },
                child: Text('Test')),
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
                      onPressed: () {
                        print(_textEditingController.text);
                      },
                      label: Text('Send'),
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
