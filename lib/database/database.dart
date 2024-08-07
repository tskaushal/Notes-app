import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:notesapp/database/note.dart';
import 'package:path_provider/path_provider.dart';

class database extends ChangeNotifier {
  static late Isar isar;

  static Future<void> intialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  List<Note> notesall = [];
  //create
  Future<void> newnoter(String textfromuser) async {
    final newnote = Note()..text = textfromuser;
    await isar.writeTxn(() => isar.notes.put(newnote));
    readnote();
  }

  //read
  Future<void> readnote() async {
    List<Note> fetchednotes = await isar.notes.where().findAll();
    notesall.clear();
    notesall.addAll(fetchednotes);
    notifyListeners();
  }

  Future<void> updatenote(int id, String newtext) async {
    final existingnote = await isar.notes.get(id);
    if (existingnote != null) {
      existingnote.text = newtext;
      await isar.writeTxn(() => isar.notes.put(existingnote));
      await readnote();
    }
  }

  Future<void> deletenote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await readnote();
  }
}
