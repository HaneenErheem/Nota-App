class User {

  late int id ;
  late String name ;
  late String email ;
  late String password;
  User();

  //البيانات تخزن في الداتابيز نتاد تحويل المودل الى ماب 
  //named constructor 
  //read from database
  User.fromMap(Map<String,dynamic> rowMap){
  id=rowMap['id'];
  name=rowMap['name'];
  email=rowMap['email'];
  password=rowMap['password'];
  }
  //دالة 
  //store on database 
  Map<String ,dynamic> toMap(){
   Map<String ,dynamic> map =<String ,dynamic>{};
   //لما بخزن ما بعطيه الاي دي لأانه اوتوانكرمنت 
   map['name']=name;
   map['email']=email;
   map['password']=password;
   return map;
  }

}