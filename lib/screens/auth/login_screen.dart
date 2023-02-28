

import 'package:database19/providers/user_provider.dart';
import 'package:database19/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers{

 late TextEditingController _emailTextController;
 late TextEditingController _passwordTextController;
 

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController=TextEditingController();
    _passwordTextController=TextEditingController();
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const Text(
              'welcome back..',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),),
           const  Text(
              'Enter Email & Password',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 16,
              ),),
            const  SizedBox(height: 20,),

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
            onPressed: ()async => await performLogin(), 
            child: const Text('LOGIN'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50),
            ),
            ),
              const SizedBox(height: 10,),
             
              Center(
                child: TextButton(onPressed: (){
                  Navigator.pushNamed(context, '/register_screen');
                }, child: Text('Create account')),
              )


          ],
        ),
      ),
    );
  }

//خطوة2 بنعرف دوال اللوجين الخاصة بال ui


 Future<void> performLogin() async{
  if(checkdata()){
    await login();
  }
 }

  
  bool checkdata(){
    if(  _emailTextController.text.isNotEmpty&&
      _passwordTextController.text.isNotEmpty){
        return true;
  
    }
    showSnackBar(context, message: 'Ente Requierd Data',error: true);
    return false;
  }

   Future<void> login()async{
    bool loggedIn= await Provider.of<UserProvider>(context).login(email: _emailTextController.text, password: _passwordTextController.text);
   if (loggedIn){
    Navigator.pushReplacementNamed(context, '/notes_screen');
   }else{
    showSnackBar(context, message: "failed login , try again later ",error:true );
   }
   }
}