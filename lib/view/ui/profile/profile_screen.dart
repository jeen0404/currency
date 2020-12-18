
import 'package:currency/cubit/app_start_cubit.dart';
import 'package:currency/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: FlatButton(child: Text("Log-out"),onPressed: (){
        ///
        AuthRepository().setUnAuthenticated;
        BlocProvider.of<AppStartCubit>(context).add(AppStartCubitEvent.AuthAppStartCubitEvent);
      },),),
    );
  }
}
