


//event

import 'package:currency/model/currency_model.dart';
import 'package:currency/model/history_model.dart';
import 'package:currency/repository/auth_repository.dart';
import 'package:currency/repository/currency_repository.dart';
import 'package:currency/repository/history_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeCubitEvent{

}

class CalculateHomeCubitEvent extends HomeCubitEvent{
  final String fromName;
  final String toName;
  final double value;

  CalculateHomeCubitEvent(this.fromName, this.toName, this.value);
}
class AddToHistoryHomeCubitEvent extends HomeCubitEvent{
  final String fromName;
  final String toName;
  final double value;

  AddToHistoryHomeCubitEvent(this.fromName, this.toName, this.value);

}



class HomeCubit extends Bloc<HomeCubitEvent,double>{
  final GlobalKey<ScaffoldState> _scaffoldKey;
  CurrencyRepository _currencyRepository =CurrencyRepository();
  HistoryRepository _historyRepository =HistoryRepository();
  AuthRepository _authRepository =AuthRepository();
  List<CurrencyModel> currencys=[];

  HomeCubit(this._scaffoldKey) : super(0){
   _currencyRepository.getFromDatabase;  /// update for once
  }

  @override
  Stream<double> mapEventToState(HomeCubitEvent event) async*{
    if(event is CalculateHomeCubitEvent){
      double fromName =(await _currencyRepository.get(event.fromName)).value;
      double toValue =(await _currencyRepository.get(event.toName)).value;
      double exchangeRate= toValue/fromName;
      yield event.value*exchangeRate;
    }
    else if(event is AddToHistoryHomeCubitEvent){
      double fromName =(await _currencyRepository.get(event.fromName)).value;
      double toValue =(await _currencyRepository.get(event.toName)).value;
      double exchangeRate= toValue/fromName;
      _historyRepository.put(HistoryModel(null,await _authRepository.fetchUsername, event.fromName, event.toName, event.value, event.value*exchangeRate,exchangeRate));
      showSnackBar("Saved In History");
    }
  }

    Future<List<CurrencyModel>> get getCurrencysList async{
    if(this.currencys.isEmpty){
      currencys= await this._currencyRepository.getList;
      return currencys;
    }
    return currencys;
    }

  void showSnackBar(text){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text),duration: Duration(milliseconds: 200),));
  }

}