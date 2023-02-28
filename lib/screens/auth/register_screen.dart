import 'package:database19/models/user.dart';
import 'package:database19/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helpers {

 late TextEditingController _nameTextController;
 late TextEditingController _emailTextController;
 late TextEditingController _passwordTextController;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController=TextEditingController();
    _passwordTextController=TextEditingController();
    _nameTextController=TextEditingController();
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _nameTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REGISTER'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          children: [
          const Text(
              'create account..',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),),
           const  Text(
              'Enter new account info',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 16,
              ),),
            const  SizedBox(height: 20,),

            TextField(
                controller: _nameTextController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1
                    )
                  )
                ),
              ),

             const SizedBox(height: 10,),

              TextField(
                controller: _emailTextController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1
                    )
                  )
                ),
              ),

             const SizedBox(height: 10,),

               TextField(
                controller: _passwordTextController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:const BorderSide(
                      color: Colors.blue,
                      width: 1
                    )
                  )
                ),
              ),

              const SizedBox(height: 20,),

            ElevatedButton(
            onPressed: ()async=>await performRegister(), 
            child: const Text('REGISTER'),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> performRegister() async{
    if(checkdata()){
      await register();
    }
  }

  
  bool checkdata(){
    if(  _nameTextController.text.isNotEmpty&&
      _emailTextController.text.isNotEmpty&&
      _passwordTextController.text.isNotEmpty){
        return true;
  
    }
    showSnackBar(context, message: 'Ente Requierd Data',error: true);
    return false;
  }

   Future<void> register()async{
    bool loggedIn= await Provider.of<UserProvider>(context,listen: false).create(user);
   if (loggedIn){
    Navigator.pop(context);//حيرجعني عالكونتكس اللي اجيت منه وهو اللوجين بعد ما يعمل انشاء مستخدم 
   }
   }

   User get user {
    User user =User();
    user.name=_nameTextController.text;
    user.email=_emailTextController.text;
    user.password=_passwordTextController.text;
    return user;

    }
}