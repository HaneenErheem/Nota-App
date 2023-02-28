import 'package:database19/storage/pref_controller.dart';
import 'package:flutter/material.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed( const Duration(seconds: 3),(){
      //اول خطوة بالربط
      String route =PrefController().loogedIn ? '/notes_screen' :'/login_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Notes App',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),),
      ),
    );
  }
}