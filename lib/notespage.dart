import 'dart:math';

import 'package:flutter/material.dart';
import 'package:notesapp/database/database.dart';
import 'package:provider/provider.dart';

class Notespage extends StatefulWidget {
  const Notespage({super.key});

  @override
  State<Notespage> createState() => _NotespageState();
}

class _NotespageState extends State<Notespage> {
  final textconrtoller = TextEditingController();

  void createnotes() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textconrtoller,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context.read<database>().newnoter(textconrtoller.text);
                    textconrtoller.clear();
                    Navigator.pop(context);
                  },
                  child: Text("create"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<database>(
      builder: (context, value, index) => Scaffold(
        appBar: AppBar(
          title: Text("NOTES"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content: TextField(
                        controller: textconrtoller,
                      ),
                      actions: [
                        MaterialButton(
                          onPressed: () {
                            value.newnoter(textconrtoller.text);
                            textconrtoller.clear();
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text("create"),
                          ),
                        )
                      ],
                    ));
          },
          child: Icon(Icons.add),
        ),
        body: ListView.builder(
            itemCount: value.notesall.length,
            itemBuilder: (context, index) {
              final note = value.notesall[index];
              return ListTile(
                title: Text(note.text),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  IconButton(
                      onPressed: () {
                        textconrtoller.text = note.text;
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: TextField(
                                    controller: textconrtoller,
                                  ),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () {
                                        value.updatenote(
                                            note.id, textconrtoller.text);
                                        textconrtoller.clear();
                                        Navigator.pop(context);
                                      },
                                      child: Text("update"),
                                    )
                                  ],
                                ));
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        value.deletenote(note.id);
                      },
                      icon: const Icon(Icons.delete))
                ]),
              );
            }),
      ),
    );
  }
}
