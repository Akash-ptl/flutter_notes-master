import 'package:flutter/material.dart';
import 'package:flutter_notes/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NewNote extends StatefulWidget {
  const NewNote({super.key});

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController textFieldController = TextEditingController();
  final List<Map<String, dynamic>> checkboxList = [];
  final List<List<String>> textFormFieldList = [];
  void addNoteToList() {
    String title = titlecontroller.text;
    String description = descriptioncontroller.text;

    noteList.add('$title: $description');
    print(noteList);
    titlecontroller.clear();
    descriptioncontroller.clear();
  }

  late TextEditingController _textEditingController;
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  bool isBold = false;
  bool isItalic = false;
  bool isUnderlined = false;
  bool isHighlite = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color(0xffDDDBC7),
        elevation: 0,
        leading: Container(),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text('Save',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600)),
                  TextButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('Notes').add({
                        'title': titlecontroller.text,
                        'description': descriptioncontroller.text,
                        'bold': isBold,
                        'italic': isItalic,
                        'underline': isUnderlined,
                        'highlite': isHighlite
                      });
                    },
                    child: const Text('Add',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  )
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            const Divider(thickness: 2, color: Colors.black),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextFormField(
                controller: titlecontroller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'The Title',
                    hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            const Divider(thickness: 2, color: Colors.black),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: descriptioncontroller,
                maxLines: null,
                style: TextStyle(
                  height: 1.6,
                  fontSize: 20,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
                  backgroundColor:
                      isHighlite ? const Color(0xfffafa00) : Colors.transparent,
                  decoration: isUnderlined
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Your Note',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 20,
                    )),
              ),
            ),
            SizedBox(
              height: h / 4,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  height: h / 2.5,
                  child: ListView.builder(
                    itemCount: checkboxList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final textController = TextEditingController(
                        text: textFormFieldList.length > index &&
                                textFormFieldList[index].isNotEmpty
                            ? textFormFieldList[index][0]
                            : '',
                      );
                      return CheckboxListTile(
                        value: checkboxList[index]['value'],
                        onChanged: (bool? newValue) {
                          setState(() {
                            checkboxList[index]['value'] = newValue;
                          });
                        },
                        title: checkboxList[index]['text'].isEmpty
                            ? TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter text',
                                ),
                                controller: textController,
                                onSaved: (String? value) {
                                  if (value != null) {
                                    setState(() {
                                      textFormFieldList[index] = [value];
                                      checkboxList[index]['text'] = value;
                                    });
                                  }
                                },
                              )
                            : Text(checkboxList[index]['text']),
                        controlAffinity: ListTileControlAffinity.leading,
                        secondary: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              checkboxList.removeAt(index);
                              textFormFieldList.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 6,
            ),
            const Divider(
              thickness: 2,
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        checkboxList.add({'value': false, 'text': ''});
                        textFormFieldList.add([]);
                      });
                    },
                    icon: const Icon(Icons.check_box_outlined)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(MdiIcons.formatListBulleted)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(MdiIcons.formatListBulletedSquare)),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isBold = !isBold;
                      });
                    },
                    child: const Text(
                      'B',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          fontFamily: 'noto',
                          color: Colors.black),
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isItalic = !isItalic;
                      });
                    },
                    child: Text(
                      'I',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'noto',
                          fontStyle:
                              isItalic ? FontStyle.italic : FontStyle.normal,
                          fontSize: 25,
                          color: Colors.black),
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isUnderlined = !isUnderlined;
                      });
                    },
                    child: const Text(
                      'U',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'noto',
                          decoration: TextDecoration.underline,
                          fontSize: 25,
                          color: Colors.black),
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isHighlite = !isHighlite;
                      });
                    },
                    child: Container(
                      color: const Color(0xfffafa00),
                      child: const Text(
                        ' T ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'noto',
                            fontSize: 25,
                            color: Colors.black),
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: h / 40,
            )
          ],
        ),
      ),
      backgroundColor: const Color(0xffDDDBC7),
    );
  }
}
