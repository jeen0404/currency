import 'package:bloc/bloc.dart';
import 'package:currency/database/inti_sqllite.dart';
import 'package:currency/repository/auth_repository.dart';

/// app start event
enum AppStartCubitEvent {
  AppStartedAppStartCubitEvent ,// event when app is start
  AuthAppStartCubitEvent ,// event when user enter and proceed
}

// app start states
enum AppStartCubitState {
  InitlizingAppStartCubitState, //   show splash screen to user and load databases

  AuthenticatedAppStartCubitState,

  /// user is authenticated and show main_screen

  UnAuthenticatedAppStartCubitState // user not authenticated so ask for name // send user to ask_name_screen

}

class AppStartCubit extends Bloc<AppStartCubitEvent, AppStartCubitState> {
  AppStartCubit() : super(AppStartCubitState.InitlizingAppStartCubitState);
  AuthRepository authRepository=AuthRepository();

  @override
  Stream<AppStartCubitState> mapEventToState(AppStartCubitEvent event) async* {

    if(event==AppStartCubitEvent.AppStartedAppStartCubitEvent){
      // load database
      //authRepository.setUnAuthenticated;
      InitSqlLite().instance;
      await Future.delayed(Duration(seconds: 2));
      // all the database loading will go here while showing splash screen

      if (await authRepository.isAuthenticated) {
        yield AppStartCubitState.AuthenticatedAppStartCubitState;
      } else {
        yield AppStartCubitState.UnAuthenticatedAppStartCubitState;
      }
    }

    else{
      if (await authRepository.isAuthenticated) {
        yield AppStartCubitState.AuthenticatedAppStartCubitState;
      } else {
        yield AppStartCubitState.UnAuthenticatedAppStartCubitState;
      }
    }

  }
}
