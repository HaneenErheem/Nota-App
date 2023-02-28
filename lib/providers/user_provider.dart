import 'package:database19/database/controller/user_db_controller.dart';
import 'package:flutter/material.dart';
import 'package:database19/database/db_controller.dart';

import '../models/user.dart';
//هان ما بستخدم نتيفاي ليسينر لانه ما في عندي ليست
//  وما بدي اضل احدث على اشي اللي هي الليست

class UserProvider extends ChangeNotifier{

  final UserDbController _dbController = UserDbController();
Future<bool> login({required String email,required String password})async{
  return await _dbController.login(email: email, password: password);
}

//انا هنا ما عرفت ليست علشان مش معني اعرض لليوزر كل اليوزرز لكن
// ف النوت عرفت لاني معني اعرضله كل انوتس تبعونه

Future<bool>create(User user)async{
int newRowId =await _dbController.create(user);
return newRowId !=0;//يعني عملية الانشاء اضيفت بشكل صحيح 
}

Future <bool>update(User user)async{
  return await _dbController.update(user);
}

Future<bool>delete(int id)async{
  return await _dbController.delete(id);
}
}