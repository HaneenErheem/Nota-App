 abstract class DbOperations<Model>{
/**Future<void> create(Note note)async{
  
}
Future<List<Note>>read()async{}
Future<bool>update(Note note)async{}
Future<bool>delete(int id )async{} */

Future<int> create(Model model);

Future<List<Model>> read();

Future<Model?> show(int id);

Future<bool> update(Model model);

Future<bool> delete(int id);
 }