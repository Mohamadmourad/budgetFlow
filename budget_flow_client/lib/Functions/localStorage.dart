import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToLocal(int id)async{
final SharedPreferences prefs = await SharedPreferences.getInstance();

await prefs.setInt('user', id);
}

Future<int?> getFromLocal()async{
final SharedPreferences prefs = await SharedPreferences.getInstance();
final int? result = prefs.getInt('user');
if(result != null){
  return result;
}
return null;
}

Future<void> removeFromLocal()async{
final SharedPreferences prefs = await SharedPreferences.getInstance();

await prefs.remove('user');
}