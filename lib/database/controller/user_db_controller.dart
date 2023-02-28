import 'package:database19/database/controller/db_operations.dart';
import 'package:database19/models/user.dart';
import 'package:database19/storage/pref_controller.dart';
import 'package:sqflite/sqflite.dart';

import '../db_controller.dart';

class UserDbController implements DbOperations<User>{
  Database database =DbController().database;


  Future<bool> login({required String email ,required String password})async{
   List<Map<String ,dynamic>> maps = await database.query('users',where: 'email=? AND password=?',whereArgs: [email,password]);
  if(maps.isNotEmpty){
    //طالما المستخدم عمل لوجين اذا في عندي يوزر واحد متاكد منه 
    User user =User.fromMap(maps.first);
    await PrefController().save(user);
  }
  return maps.isNotEmpty;
  }

  @override
  Future<int> create(User model)async {
   int newRowId= await database.insert('users', model.toMap());
   return newRowId;
  }

  @override
  Future<bool> delete(int id)async {
  int countOfDeletedRows =await database.delete('users',where: 'id=?',whereArgs: [id]);
  return countOfDeletedRows==1;
  }

  @override
  Future<List<User>> read()async {
  List<Map<String,dynamic>> rows =await database.query('users');
  List<User> users= rows.map((Map<String,dynamic>rowMap) => User.fromMap(rowMap)).toList();
  return users;
  }

  @override
  Future<User?> show(int id)async {
  List<Map<String,dynamic>> rows=await database.query('users',where: 'id=?',whereArgs: [id]);
 if(rows.isNotEmpty){
 return User.fromMap(rows.first);
 }
  }

  @override
  Future<bool> update(User model)async {
  int countOfUpdatedRwos=await database.update('users',model.toMap(), where: 'id=?',whereArgs: [model.id]);
  return countOfUpdatedRwos==1; // the maximum number of updated id's is 1 or zero
  
  }
  //CRUD -> Create ,Read, Update ,Delete

}