import 'package:flutter/material.dart';
import 'package:google_scholar_api/paper.dart';
import 'package:google_scholar_api/widgets/paper_card.dart';
import 'package:google_scholar_api/main.dart';

class Resultpage extends StatelessWidget {
  const Resultpage({super.key, required this.paper_result});
  final List<Paper> paper_result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 左側のアイコン
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(
                          title: 'GDG TCU Scholoar',
                        )));
          },
          icon: Icon(Icons.arrow_back),
        ),
        // タイトルテキスト
        title: Text('Result'),
      ),
      body: Center(
        child: ListView(
            //scrollDirection: Axis.horizontal, // 横
            padding: EdgeInsets.all(36.0),
            shrinkWrap: true,
            children: [
              for (int i = 0; i < 6; i++)
                PaperCard(
                    title: paper_result[i].title,
                    link: paper_result[i].link,
                    citedByCount: paper_result[i].citedByCount),
            ]),
      ),
    );
  }
}
