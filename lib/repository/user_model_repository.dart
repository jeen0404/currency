import 'package:currency/database/inti_sqllite.dart';
import 'package:currency/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserModelRepository extends InitSqlLite{

  Future<UserModel> get(username) async{
   List<Map<String,dynamic>> user=await  (await instance).query('users',where:"username =?",whereArgs: [username]);
   print(user);
   if(user.length==1){
     return UserModel(user[0]['username'], user[0]['password']);
   }
   return null;
  }

  Future<void> put(UserModel userModel) async{
    return (await instance).insert("users", userModel.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

}