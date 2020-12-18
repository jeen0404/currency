

import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref{

  /// assigning sharedPreferences
  SharedPreferences sharedPreferences;

  //get instance for getting  Instance of sharepref only once for object

   Future<SharedPreferences> get getInstance async{
    if(this.sharedPreferences ==null){
      this.sharedPreferences=await SharedPreferences.getInstance();
    }
    return this.sharedPreferences;
  }

}