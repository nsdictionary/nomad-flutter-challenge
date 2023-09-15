import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time/constants/gaps.dart';

import '../../../constants/sizes.dart';

final titleList = [
  "I just don't like it",
  "It's unlawful content under NetzDG",
  "It's spam",
  "Hate speech or symbols",
  "Nudity or sexual activity",
  "It's full of bugs.",
  "The app is not working.",
];

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.7,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 1,
          automaticallyImplyLeading: false, // disable default back button
          toolbarHeight: Sizes.size56,
          title: Column(
            children: [
              Gaps.v10,
              Center(
                child: Container(
                  width: Sizes.size48,
                  height: Sizes.size6,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(Sizes.size10),
                  ),
                ),
              ),
              Gaps.v10,
              const Text(
                'Report',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v10,
            ],
          ),
        ),
        body: ListView(
          children: [
            const ListTile(
              title: Padding(
                padding: EdgeInsets.only(
                  bottom: Sizes.size7,
                ),
                child: Text(
                  'Why are you reporting this thread?',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Sizes.size18,
                  ),
                ),
              ),
              subtitle: Text(
                "Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don't wait.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: Sizes.size14,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: Sizes.size10,
                horizontal: Sizes.size10,
              ),
            ),
            for (String titleStr in titleList)
              Column(
                children: [
                  Container(
                    height: Sizes.size1,
                    color: Colors.grey.shade200,
                  ),
                  ListTile(
                    title: Text(
                      titleStr,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.size18,
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: Sizes.size14,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    height: Sizes.size1,
                    color: Colors.grey.shade200,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
