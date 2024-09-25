import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_scholar_api/widgets/text_with_icon.dart';

class PaperCard extends StatelessWidget {
  const PaperCard(
      {super.key,
      required this.title,
      required this.link,
      required this.citedByCount});
  final String title;
  final String link;
  final int citedByCount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWithIcon(iconData: Icons.description, text: title),
                TextWithIcon(iconData: Icons.link, text: link),
                TextWithIcon(
                    iconData: Icons.done, text: citedByCount.toString())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
