import 'dart:math';

import 'package:database19/providers/note_provider.dart';
import 'package:database19/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'note_screen.dart';
class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> with Helpers{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NoteProvider>(context ,listen: false).read(); 
     }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        title: const Text('Notes',style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actionsIconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const NoteScreen()));
          }, 
          icon: const Icon(Icons.note_add))
        ],
      ),

      //المستقبل عبارة عن مستهلك لبروفايدر واحد اللي هو نوت برفايدر بدي اسمع منه فقط 
      body: Consumer<NoteProvider>(
        builder: (context, NoteProvider value,child){
          if(value.loading){
            return Center(child: CircularProgressIndicator(),);
          }else if(value.notes.isNotEmpty){
          return ListView.builder(
        itemCount: value.notes.length,
        itemBuilder:(context,index) {
          return ListTile(
            onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>NoteScreen(note: value.notes[index],)));
            },
          leading: const Icon(Icons.note),
          title:  Text(value.notes[index].title),
          subtitle:  Text(value.notes[index].detailes),
          trailing: IconButton(
            onPressed: ()=> deleteNote(index),
             icon: const Icon(Icons.delete)
             ),
          );
        });

         }
         return Center(
           child: Column(
            mainAxisSize: MainAxisSize.min,
           children: const[
            Icon(Icons.warning),
            Text('NO DATA',style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black45
            ),)
            ]
           ),
         );
        })
    );
  }

  void deleteNote(int id)async{
    bool _deleted =await Provider.of<NoteProvider>(context,listen: false).delete(id); 
     String message = _deleted ?'Note deleted successfully':'Note delete failed';
    showSnackBar(context, message: message,error:  !_deleted);
     }
   
}

