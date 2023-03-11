import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diaryapp/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class NoteEdit extends StatefulWidget {
  const NoteEdit({super.key});

  @override
  State<NoteEdit> createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteEdit> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController maincontroller = TextEditingController();
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date = DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0,
        title: Text(
          "Add a New Note",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titlecontroller,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Note Title'),
                style: AppStyle.mainTitle,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                date,
                style: AppStyle.dateTitle,
              ),
              SizedBox(
                height: 28.0,
              ),
              TextField(
                controller: maincontroller,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Enter Note Here'),
                style: AppStyle.mainContent,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentcolor,
        child: Icon(Icons.add),
        onPressed: () async {
          FirebaseFirestore.instance.collection("Notes").add({
            "note_title": titlecontroller.text,
            "creation_date": date,
            "note_content": maincontroller.text,
            "color_id": color_id,
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError(
              (error) => print("Faild to add new note due to $error"));
        },
      ),
    );
  }
}
