import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  String title;
  DetailPage({
    super.key,
    required this.title,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isBold = false;
  bool isItalic = false;
  bool isUnderlined = false;
  bool isHighlite = false;
  @override
  Widget build(BuildContext context) {
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
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                const Text('Edit',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
              ],
            ),
          ),
          Expanded(
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
                      if (document['title'] == widget.title) {
                        isBold = document['bold'];
                        isItalic = document['italic'];
                        isUnderlined = document['underline'];
                        isHighlite = document['highlite'];

                        return Column(
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
                                    widget.title,
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
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                children: [
                                  Text(
                                    document['description'],
                                    style: TextStyle(
                                      height: 1.6,
                                      fontSize: 20,
                                      fontWeight: isBold
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      fontStyle: isItalic
                                          ? FontStyle.italic
                                          : FontStyle.normal,
                                      backgroundColor: isHighlite
                                          ? const Color(0xfffafa00)
                                          : Colors.transparent,
                                      decoration: isUnderlined
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }).toList(),
                  );
                }),
          ),
        ],
      ),
      backgroundColor: const Color(0xffDDDBC7),
    );
  }
}
