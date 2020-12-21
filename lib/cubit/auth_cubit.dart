
import 'package:bloc/bloc.dart';
import 'package:currency/cubit/app_start_cubit.dart';
import 'package:currency/model/user_model.dart';
import 'package:currency/repository/auth_repository.dart';
import 'package:currency/repository/user_model_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// sign-up, log-in will be event
abstract class AuthCubitEvent{

}

class LoginAuthCubitEvent extends AuthCubitEvent{
  final String username;
  final String password;
  LoginAuthCubitEvent(this.username, this.password);
}
class SignUpAuthCubitEvent extends AuthCubitEvent{
  final String username;
  final String password;
  SignUpAuthCubitEvent(this.username, this.password);
}



/// auth state // sign-up success // login success // error state
abstract class AuthCubitState {

}
 class InitializeAuthCubitState extends AuthCubitState {

}

class SignUpSuccessAuthCubitState extends AuthCubitState{

}
class LogInSuccessAuthCubitState extends AuthCubitState{

}
class ErrorAuthCubitState extends AuthCubitState{

}



/// cubit to map event and state
///

class AuthCubit extends Bloc<AuthCubitEvent,AuthCubitState>{
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final UserModelRepository _userModelRepository=UserModelRepository();
  final AuthRepository _authRepository=AuthRepository();
  AuthCubit(this._scaffoldKey) : super(InitializeAuthCubitState());


  @override
  Stream<AuthCubitState> mapEventToState(AuthCubitEvent event) async*{
    if(event is LoginAuthCubitEvent){
      print(event.username);
      UserModel userModel=await _userModelRepository.get(event.username);
      if(userModel==null){
       showSnackBar("User does not exist.");
      }
      else if(userModel.password==event.password){
        _authRepository..setAuthenticated..storeUsername(event.username); 
        showSnackBar("login successful");
        Future.delayed(Duration(milliseconds: 200));
        BlocProvider.of<AppStartCubit>(_scaffoldKey.currentContext).add(AppStartCubitEvent.AuthAppStartCubitEvent);
        yield LogInSuccessAuthCubitState();
      }
      yield ErrorAuthCubitState();
    }
      else if(event is SignUpAuthCubitEvent){
        print("sign up event");
        print(event.username);
        print(event.password);
        //validating username password
        if((event.username.length<5 || event.username.length>16) || (event.password.length<5 || event.password.length>16)){

        if(event.username.length<5 || event.username.length>16){
          this.showSnackBar("username length must be 6 to 15");
        }
        else if(event.password.length<5 || event.password.length>16){
          this.showSnackBar("password length must be 6 to 15");
        }
        }
        else{
          UserModel userModel=await _userModelRepository.get(event.username);
          if(userModel==null){
            await _userModelRepository.put(UserModel(event.username, event.password));
            _authRepository..setAuthenticated..storeUsername(event.username);

            print("sign-up successful");
            showSnackBar("sign-up successful");
            Future.delayed(Duration(milliseconds: 200));
            BlocProvider.of<AppStartCubit>(_scaffoldKey.currentContext).add(AppStartCubitEvent.AuthAppStartCubitEvent);
          }
          else if(userModel.password==event.password){
            showSnackBar("User already exist please login");
          }
          else{
            showSnackBar("Username not available");
          }
          yield SignUpSuccessAuthCubitState();
        }
    }
  }

  void showSnackBar(text){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text),duration: Duration(milliseconds: 200),));
  }

}