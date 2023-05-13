import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jon/model/jsonmodel_screen.dart';
import 'package:jon/second_screen.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<JsonModelClass> _items = [];

// Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final List<dynamic> jsonData = json.decode(response);

    setState(() {
      _items = jsonData.map((item) => JsonModelClass.fromJson(item)).toList();
    });
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'image':
        return Icons.image;
      case 'file':
        return Icons.insert_drive_file;
      case 'video':
        return Icons.video_library;
      case 'paper':
        return Icons.description;
      case 'chat':
        return Icons.chat;
      default:
        return Icons.error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Column(
      //   children: [
      //     _items.isNotEmpty
      //         ? Expanded(
      //       child: ListView.builder(
      //         itemCount: _items.length,
      //         itemBuilder: (context, index) {
      //           return Column(
      //             children: [
      //               ListTile(
      //                   leading: Container(
      //                     height: 100,
      //                     width: 57,
      //                     alignment: Alignment.center,
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(90),
      //                         color: Colors.blueGrey),
      //                     child: Text(
      //                       _items[index].name![0].toString(),
      //                       style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
      //                     ),
      //                   ),
      //                   title: Text(
      //                     _items[index].name.toString(),
      //                     style: const TextStyle(
      //                         fontWeight: FontWeight.bold, fontSize: 18),
      //                   ),
      //                   subtitle: Column(
      //                     children: [
      //                       const SizedBox(height: 5.0,),
      //                       Align(
      //                         alignment: Alignment.topLeft,
      //                           child: Text(_items[index].message.toString(), style: TextStyle(fontSize: 16),)),
      //                       const SizedBox(height: 5.0,),
      //                       Row(
      //                         children: _items[index]
      //                             .footerIcons!
      //                             .map((icon) => Padding(
      //                               padding: const EdgeInsets.symmetric(horizontal: 5.0),
      //                               child: Align(
      //                                   alignment: Alignment.topLeft,
      //                                   child: Icon(_getIconData(icon), color: Colors.black,)),
      //                             ))
      //                             .toList(),
      //                       ),
      //                     ],
      //                   ),
      //                   trailing: Text(_items[index].time.toString())
      //               ),
      //               const Padding(
      //                 padding:  EdgeInsets.only(left: 85.0),
      //                 child: Divider(thickness: 1.0, color: Colors.grey,),
      //               ), // Add a divider after each ListTile
      //               const SizedBox(height: 12),
      //             ],
      //           );
      //         },
      //       ),
      //     )
      //         : Container(),
      //
      //   ],
      // )
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: Colors.white,
            expandedHeight: 160,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Edit",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.blue,
                              fontSize: 19),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SecondScreen()));
                            },
                            icon: const Icon(
                              Icons.edit_note_rounded,
                              color: Colors.blue,
                              size: 30,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Messages",
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      height: 40, // Set the desired height
                      width: 350, // Set the desired width
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          // Remove the default padding
                          hintText: 'Search',
                          hintStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87,
                          ),
                          fillColor: Colors.blueGrey.shade100,
                          filled: true,
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.black87),
                          suffixIcon:
                              const Icon(Icons.mic, color: Colors.black87),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Padding(
                      padding: EdgeInsets.only(left: 85.0),
                      child: Divider(
                        thickness: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Column(
                  children: [
                    ListTile(
                        leading: Container(
                          height: 100,
                          width: 57,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              color: Colors.blueGrey),
                          child: Text(
                            _items[index].name![0].toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                        ),
                        title: Text(
                          _items[index].name.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Column(
                          children: [
                            const SizedBox(
                              height: 5.0,
                            ),
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  _items[index].message.toString(),
                                  style: TextStyle(fontSize: 16),
                                )),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: _items[index]
                                  .footerIcons!
                                  .map((icon) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Icon(
                                              _getIconData(icon),
                                              color: Colors.black,
                                            )),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                        trailing: Text(_items[index].time.toString())),
                    const Padding(
                      padding: EdgeInsets.only(left: 85.0),
                      child: Divider(
                        thickness: 1.0,
                        color: Colors.grey,
                      ),
                    ), // Add a divider after each ListTile
                    const SizedBox(height: 12),
                  ],
                );
              },
              childCount: _items.length,
            ),
          ),
        ],
      ),
    );
  }
}
