import 'package:flutter/material.dart';
import 'package:google_scholar_api/paper.dart';
import 'package:google_scholar_api/widgets/paper_card.dart';

class Resultpage extends StatelessWidget {
  const Resultpage({super.key, required this.paper_result});
  final List<Paper> paper_result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
            //scrollDirection: Axis.horizontal, // 横
            padding: EdgeInsets.all(36.0),
            shrinkWrap: true,
            children: [
              PaperCard(
                  title: paper_result[0].title,
                  link: paper_result[0].link,
                  citedByCount: paper_result[0].citedByCount),
              PaperCard(
                  title: paper_result[1].title,
                  link: paper_result[1].link,
                  citedByCount: paper_result[1].citedByCount),
              PaperCard(
                  title: paper_result[2].title,
                  link: paper_result[2].link,
                  citedByCount: paper_result[2].citedByCount),
              PaperCard(
                  title: paper_result[3].title,
                  link: paper_result[3].link,
                  citedByCount: paper_result[3].citedByCount),
              PaperCard(
                  title: paper_result[4].title,
                  link: paper_result[4].link,
                  citedByCount: paper_result[4].citedByCount),
              PaperCard(
                  title: paper_result[5].title,
                  link: paper_result[5].link,
                  citedByCount: paper_result[5].citedByCount),
              PaperCard(
                  title: paper_result[6].title,
                  link: paper_result[6].link,
                  citedByCount: paper_result[6].citedByCount),
            ]),
      ),
    );
  }
}
