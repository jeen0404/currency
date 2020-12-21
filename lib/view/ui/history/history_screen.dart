
import 'package:currency/cubit/history_cubit.dart';
import 'package:currency/model/history_model.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {

  HistoryCubit _historyCubit = HistoryCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text("History"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          _historyCubit.add(RefreshHistoryCubitEvent());
          await Future.delayed(Duration(seconds: 2));
          return;
        },
        child: StreamBuilder<List<HistoryModel>>(
          stream: _historyCubit,
          builder: (context,state){
            if(!state.hasData || state.data.isEmpty){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Text("No history is available")),
                  Center(child: FlatButton(child: Text("Refresh"),onPressed: ()=>_historyCubit.add(LoadHistoryCubitEvent()),),)
                ],
              );
            }
            return ListView.builder(
              addAutomaticKeepAlives: true,
              itemCount: state.data.length,
              itemBuilder: (context,index){
                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(state.data[index].fromValue.toStringAsFixed(2),style:  TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2),),
                                Text(state.data[index].fromCurrency,style:  TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 2),),
                              ],
                            ),
                          ),
                          Icon(Icons.double_arrow),
                          Expanded(
                            child: Column(
                              children: [
                                Text(state.data[index].toValue.toStringAsFixed(2),style:  TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2),),
                                Text(state.data[index].toCurrency,style:  TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 2),),
                              ],
                            ),
                          ),
                          IconButton(icon: Icon(Icons.delete),
                          onPressed: ()=>_historyCubit.add(DeleteHistoryCubitEvent(state.data[index].id)),
                          )
                        ],
                      ),
                    ),
                    Divider(height: 1,)
                  ],
                );
              },
            );

          },
        ),
      ),
    );
  }
}
