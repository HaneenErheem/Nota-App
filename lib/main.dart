import 'package:database19/database/db_controller.dart';
import 'package:database19/providers/note_provider.dart';
import 'package:database19/providers/user_provider.dart';
import 'package:database19/screens/app/note_screen.dart';
import 'package:database19/screens/auth/login_screen.dart';
import 'package:database19/screens/auth/register_screen.dart';
import 'package:database19/screens/launch_screen.dart';
import 'package:database19/storage/pref_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void  main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefController().initPref();
  await DbController().initDatabase();
 
  runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //خطوة 3 بالربط اني اعرف البروفايدرز هنا 
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (context)=>UserProvider()),
        ChangeNotifierProvider<NoteProvider>(create: (context)=>NoteProvider()),
      ],
      child: MaterialApp(
      initialRoute: '/launch_screen',
      routes: {
      '/launch_screen':(context)=>const LaunchScreen(),
      '/login_screen':(context)=>const LoginScreen(),
      '/register_screen':(context)=>const RegisterScreen(),
      '/notes_screen':(context)=>const NoteScreen(),
    
      }
      ,
      ),
    );
  }
}