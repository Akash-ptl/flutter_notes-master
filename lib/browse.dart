import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/details.dart';
import 'package:flutter_notes/global.dart';
import 'package:flutter_notes/newnote.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  DateTime now = DateTime.now();
  late String formattedDate = DateFormat.yMMMd().format(now);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(noteList);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffDDDBC7),
        elevation: 0,
        leading: Container(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 5,
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('Notes').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((document) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  title: document['title'],
                                ),
                              ));
                        },
                        child: SizedBox(
                          child: Column(
                            children: [
                              const Divider(thickness: 2, color: Colors.black),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 20, left: 20, top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      document['title'],
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      'Aug 18,2018',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(thickness: 2, color: Colors.black),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewNote(),
                  ));
            },
            child: Container(
              alignment: Alignment.center,
              height: h / 22,
              width: w / 3,
              decoration: BoxDecoration(border: Border.all(width: 2)),
              child: Text(
                'New Note',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Spacer()
        ],
      ),
      backgroundColor: const Color(0xffDDDBC7),
    );
  }
}
