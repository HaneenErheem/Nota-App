import 'package:database19/providers/note_provider.dart';
import 'package:database19/storage/pref_controller.dart';
import 'package:database19/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:screens/storage/pref_controller';

import '../../models/note.dart';
import '../../providers/user_provider.dart';
class NoteScreen extends StatefulWidget {
  const NoteScreen(  {super.key,this.note});
  //عملت هيك لاني بدي استخدم ماتريال بي راوت ما بدي استخدم نامد راوت 
 final Note? note;
  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> with Helpers{

late TextEditingController _titleTextController;
 late TextEditingController _infoTextController;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleTextController=TextEditingController(text: widget.note?.title);
    _infoTextController=TextEditingController(text: widget.note?.detailes);
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleTextController.dispose();
    _infoTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NOTE'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),

      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          children: [
          const Text(
              'New Note..',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),),
           const  Text(
              'Enter Note Details',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 16,
              ),),
            const  SizedBox(height: 20,),

              TextField(
                controller: _titleTextController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Note Name',
                  prefixIcon: const Icon(Icons.title),
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
                controller: _infoTextController,
                keyboardType: TextInputType.text,
                
                decoration: InputDecoration(
                  hintText: 'Details',
                  prefixIcon: const Icon(Icons.title),
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
            onPressed: ()async=>performsave(), 
            child: const Text('SAVE'),
            ),

          ],
        ),
      ),
    );
  }

 Future<void> performsave() async{
  if(checkdata()){
    await save();
  }
 }

  
  bool checkdata(){
    if(  _titleTextController.text.isNotEmpty&&
      _infoTextController.text.isNotEmpty){
        return true;
  
    }
    showSnackBar(context, message: 'Ente Requierd Data',error: true);
    return false;
  }

   Future<void> save()async{
   bool saved = isCreate()
   ?await Provider.of<NoteProvider>(context,listen: false).create(note: note)
   :await Provider.of<NoteProvider>(context,listen: false).update(note);

   String message = saved? 'saved successfully':'saves failed';
   showSnackBar(context, message: message,error: !saved);
   isCreate()?clear(): Navigator.pop(context); 
   } 

  bool isCreate()=>widget.note ==null;

   Note get note{
    Note note =Note();
    if(!isCreate()){
     note.id=widget.note!.id;
    }
    note.title=_titleTextController.text;
    note.detailes=_infoTextController.text;
    note.userId=PrefController().getValueFor<int>(key: PrefKeys.id.toString())!;
    //بدي اكون متاكد انها ما بترجع نل لانه الريي بكون عامل لوجين ف بحط علامة الاتعجب 

    return note;
   }

   void clear(){
    _titleTextController.text='';
    _infoTextController.text='';
   }
}