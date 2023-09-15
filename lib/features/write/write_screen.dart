import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time/features/write/picture_screen.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../common/view_model/dark_mode_vm.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';

class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({super.key});

  @override
  WriteScreenState createState() => WriteScreenState();
}

class WriteScreenState extends ConsumerState<WriteScreen> {
  String _postContent = '';
  String? _imagePath = '';

  void _onPickPicturePressed() async {
    String? imagePath = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PictureScreen(),
      ),
    );

    setState(() {
      _imagePath = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.75,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'New thread',
            style: TextStyle(
              fontSize: Sizes.size20,
              fontWeight: FontWeight.w600,
            ),
          ),
          leadingWidth: Sizes.size80,
          leading: Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: ref.watch(darkModeProvider).darkMode
                      ? Colors.white
                      : Colors.black,
                  fontSize: Sizes.size18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size10,
                    vertical: Sizes.size14,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          CircleAvatar(
                            radius: Sizes.size20,
                            child: RandomAvatar('aaa'),
                          ),
                          Gaps.v8,
                          SizedBox(
                            height: Sizes.size72,
                            child: VerticalDivider(
                              thickness: Sizes.size3,
                              color: ref.watch(darkModeProvider).darkMode
                                  ? Colors.grey.shade400
                                  : Colors.black12,
                            ),
                          ),
                          Gaps.v8,
                          Opacity(
                            opacity: 0.5,
                            child: CircleAvatar(
                              radius: Sizes.size10,
                              child: RandomAvatar('aaa'),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: Sizes.size10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'jane_mobbin',
                              style: TextStyle(
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    _postContent = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: Sizes.size10,
                                  ),
                                  hintText: 'Start a thread...',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            Gaps.v16,
                            _imagePath != null && _imagePath != ''
                                ? Stack(
                                    children: [
                                      Container(
                                        width: 250,
                                        height: 250,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            Sizes.size12,
                                          ),
                                        ),
                                        child: Image.file(
                                          File(_imagePath!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: Sizes.size10,
                                        right: Sizes.size10,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _imagePath = '';
                                            });
                                          },
                                          child: const FaIcon(
                                            FontAwesomeIcons.solidCircleXmark,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : GestureDetector(
                                    onTap: _onPickPicturePressed,
                                    child: const FaIcon(
                                      FontAwesomeIcons.paperclip,
                                      color: Colors.grey,
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: Sizes.size40,
                color: ref.watch(darkModeProvider).darkMode
                    ? Colors.grey.shade800
                    : Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Anyone can reply',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_postContent.isNotEmpty) {
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Post',
                        style: TextStyle(
                          color: _postContent.isEmpty
                              ? Colors.blue.withOpacity(0.5)
                              : Colors.blue,
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //       vertical: Sizes.size10,
            //       horizontal: Sizes.size12,
            //     ),
            // child: ,
            // )
          ],
        ),
      ),
    );
  }
}
