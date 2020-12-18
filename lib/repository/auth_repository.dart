
import 'package:currency/database/shared_prefences.dart';

class AuthRepository extends MySharedPref{

  /// isAuthenticated flag
  Future<bool> get isAuthenticated async{
    sharedPreferences=await getInstance;
    bool isAuth= sharedPreferences.getBool("isAuthenticated");
    if(isAuth==null){
      return false;
    }
    return isAuth;
  }
  Future<void> get setAuthenticated async{
    return (await getInstance).setBool("isAuthenticated", true);
  }

  Future<void> get setUnAuthenticated async{
    return (await getInstance).setBool("isAuthenticated", false);
  }

  /// storing username in cache
  Future<void>  storeUsername(username) async{
    return (await getInstance).setString("username", username);
  }
  Future<String>  fetchUsername(username) async{
    return (await getInstance).getString("username");
  }




}


