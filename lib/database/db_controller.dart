import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbController {
  
   late Database _database;
   static final DbController _instance =DbController._();
   factory DbController(){
     return _instance ;
   }
   //singleton 
  //نسكر مداخل الكلاس
   DbController._();
   
   Database get database=> _database;


   //1- init database
   Future <void> initDatabase() async{
   //بتجيبلي وين الملفات التابعة لبيئة العمل اندرويد واي او اس بتتخزن 
   Directory directory = await getApplicationDocumentsDirectory();//هادا دور الباث بروفايدر 

   //بدي اعرف مسار تخزين الداتابيز 
   String path = join(directory.path,'db.sql');
   _database=await openDatabase(
    path,
    version: 1,
    onOpen: (Database db) {},
    onCreate: (Database db , int version)async{
      //هلا هنا بنشئ الداتا 
      await db.execute('CREATE TABLE users ('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'name TEXT,'
      'email TEXT,'
      'password TEXT'
      ') ');

      await db.execute('CREATE TABLE notes('
      'id INTEGER PRIMARY KEY AUTOINCREMENT,'
      'title TEXT,'
      'detailes TEXT,'
      'user_id INTEGER,'
      ' FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE RESTRICT ON UPDATE CASCADE'
      ' ) ');
    },
    onUpgrade: (Database db ,int oldVersion , int newVersion){},
    onDowngrade: (Database db ,int oldVersion , int newVersion){},
    );
   }

}