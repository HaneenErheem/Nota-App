import 'package:database19/database/controller/db_operations.dart';
import 'package:database19/database/db_controller.dart';
import 'package:database19/models/user.dart';
import 'package:database19/models/note.dart';
import 'package:database19/storage/pref_controller.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/note.dart';

class NoteDbController implements DbOperations<Note>{
  //get the instance in dbcontroller file 
  Database database =DbController().database;


  @override
  Future<int> create(Note model)async {
  int newRowId =await database.insert('notes', model.toMap());
  return newRowId;
  }

  @override
  Future<bool> delete(int id)async {
    int countOfDeletedRows =await database.delete('notes',where: 'id=?',whereArgs: [id]);
    return countOfDeletedRows==1;
  }

  @override
  Future<List<Note>> read() async{
    //هان بيصير تعديل على هاي الدالة علشان انا لما بدي اقرا رح 
    //اعرض فق طنوتس الشخص اللي مسجل دخول مش كل النوتس 
   List<Map<String,dynamic>> rows=await database.query('notes',
   where: 'user_id=?',
   whereArgs: [
    PrefController().getValueFor<int>(key: PrefKeys.id.toString())
   ]);
  return rows.map((Map<String,dynamic>rowMap) => Note.fromMap(rowMap)).toList();
 
  }

  @override
  Future<Note?> show(int id) async{
  List<Map<String,dynamic>> rows =await database.query('notes',where: 'id=?',whereArgs: [id]);
  if(rows.isNotEmpty){
 return Note.fromMap(rows.first);

  }
  }

  @override
  Future<bool> update(Note model)async {
 int countOfUpdatedRwos = await database.update('notes',model.toMap() ,where: 'id=?',whereArgs: [model.id]);
  return countOfUpdatedRwos==1;
  }

}