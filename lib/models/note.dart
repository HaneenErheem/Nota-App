class Note {
  late int  userId;
  late int  id;
  late String title;
  late String detailes;
  Note();
  
  //read from databse 
Note.fromMap(Map <String,dynamic> rowMap){
  id=rowMap['id'];
  title=rowMap['title'];
  detailes=rowMap['details'];
  userId=rowMap['user_id'];
  
}

//store on database
Map<String,dynamic>toMap(){
Map<String,dynamic> map =<String ,dynamic>{};
map['title']=title;
map['details']=detailes;
map['user_id']=userId;
return map;
}
}
