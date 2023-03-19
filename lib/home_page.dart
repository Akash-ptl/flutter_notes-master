import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/browse.dart';
import 'package:flutter_notes/newnote.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FirebaseMessaging messaging;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffDDDBC7),
        elevation: 0,
      ),
      body: Stack(children: [
        // Image.network(
        //     'https://images.unsplash.com/photo-1566041510394-cf7c8fe21800?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8d2hpdGUlMjB0ZXh0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60'),
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Zen\nNote',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 30,
                  )
                ],
              ),
              const Spacer(
                flex: 14,
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
                  height: h / 20,
                  width: w / 2.5,
                  decoration: BoxDecoration(border: Border.all(width: 2)),
                  child: const Text(
                    'New Note',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                'or',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              const Spacer(
                flex: 1,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BrowsePage(),
                      ));
                },
                child: const Text(
                  'Browse Notes',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ]),
      backgroundColor: const Color(0xffDDDBC7),
    );
  }
}
