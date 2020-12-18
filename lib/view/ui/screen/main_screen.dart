

import 'package:currency/cubit/stream_cubit.dart';
import 'package:currency/view/ui/component/bottom_navigation_bar.dart';
import 'package:currency/view/ui/history/history_screen.dart';
import 'package:currency/view/ui/home/home_screen.dart';
import 'package:currency/view/ui/profile/profile_screen.dart';
import 'package:currency/view/ui/realtime/real_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  IntStreamCubit _intStreamCubit=IntStreamCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        child: BlocProvider(
          create: (context)=>_intStreamCubit,
          child: BlocBuilder<IntStreamCubit,int>(
            cubit: _intStreamCubit,
            builder: (BuildContext context, i) {
              return BottomBar(
                selectedIndex: i,
              );
            },
          ),
        ),
      ),
      body:BlocBuilder<IntStreamCubit, int>(
        cubit: _intStreamCubit,
        builder: (BuildContext context, i) {
          return IndexedStack(
            children: <Widget>[
              HomeScreen(),
              RealTimeScreen(),
              HistoryScreen(),
              ProfileScreen(),
            ],
            index: i,
          );
        },
      ),

    );
  }
}
