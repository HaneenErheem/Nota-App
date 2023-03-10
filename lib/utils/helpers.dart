import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

mixin Helpers{
void showSnackBar(BuildContext context, {required String message,  bool error =false}){
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
content: Text(message),
backgroundColor: error ? Colors.red: Colors.green,
behavior: SnackBarBehavior.floating,
dismissDirection: DismissDirection.horizontal,
));
  
}
}