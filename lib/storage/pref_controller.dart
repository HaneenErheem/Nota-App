import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
enum PrefKeys{
id,name,email,loggedIn
}
class PrefController {
  static final PrefController _instance = PrefController._();
  late SharedPreferences _sharedPreferences;
  //singleton 
  PrefController._();
  factory PrefController() {
   return _instance;
  }

Future <void> initPref()async {
_sharedPreferences =await SharedPreferences.getInstance();
}

//سيف لبيانات اليوزر بعد ميعمل تسجيل دخول 
Future<void>save(User user) async{
  //هدول عشان نحفظ بيانات المستخدم 
  await _sharedPreferences.setBool(PrefKeys.loggedIn.toString(), true);
  await _sharedPreferences.setInt(PrefKeys.id.toString(), user.id);
  await _sharedPreferences.setString(PrefKeys.name.toString(), user.name);
  await _sharedPreferences.setString(PrefKeys.email.toString(), user.email);
}
bool get loogedIn =>_sharedPreferences.getBool(PrefKeys.loggedIn.toString())?? false;

Future<bool> clear()async=>_sharedPreferences.clear();

//smart function بدل ما امل دوال جيت لكل المتغيرات اللي عندي 
T? getValueFor<T>({required String key}){
  return  _sharedPreferences.get(key) as T?;
}

}