


//event

import 'package:currency/repository/currency_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeCubitEvent{

}

class CalculateHomeCubitEvent extends HomeCubitEvent{
  final String fromName;
  final String toName;
  final double value;

  CalculateHomeCubitEvent(this.fromName, this.toName, this.value);
}



class HomeCubit extends Bloc<HomeCubitEvent,double>{
  CurrencyRepository _currencyRepository =CurrencyRepository();
  List<CurrencyRepository> currencys=[];

  HomeCubit() : super(0){
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
  }

}