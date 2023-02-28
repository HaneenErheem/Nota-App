import 'dart:async';
import 'dart:core';

import 'package:database19/database/controller/note_db_controller.dart';
import 'package:flutter/material.dart';

import '../models/note.dart';

class NoteProvider extends ChangeNotifier{
  //عمنا الاكستند عشان قابل على عرض البيانات والتنبيه بالاحداث التي تحصل عليه عشان استخدم notify listener 
List<Note> notes =<Note>[];

//loading 
bool loading=false;

//بدي اعمل خمس دوال كل دالة بما يقابلها من دوال الكونترولر 
final NoteDbController _dbController =NoteDbController();

void read() async{
  loading=true;
   notes= await _dbController.read();
   loading=false;
  notifyListeners();
}


Future<bool>create({required Note note})async{
int newRowId =await _dbController.create(note);
if(newRowId!=0){
  note.id=newRowId;
  notes.add(note);
  notifyListeners();
}
return newRowId!=0;
}


Future<bool> delete(int id )async{
bool deleted =await _dbController.delete(id);
if(deleted){
int index =notes.indexWhere((element) => element.id==id);//جيب موقعه من الليست اللي عندي 
if (index !=-1){//يعني لقى العنصر 
  notes.removeAt(index);
  notifyListeners();
//******طريقة مختصرة  */
// notes.removeWhere((element) => element.id==id);
// notifyListeners();

}
}
return deleted;
}


Future<bool>update(Note updatedNote)async{
bool updated = await _dbController.update(updatedNote);
if(updated){
  int index =notes.indexWhere((element) => element.id==updatedNote.id);
  if(index !=-1){
  notes[index]=updatedNote;
  notifyListeners();
  }
}
return updated;
}


// void show()async{
//   notes =await _dbController.show(id);
// }
}