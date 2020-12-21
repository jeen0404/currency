



//event
import 'package:currency/model/history_model.dart';
import 'package:currency/repository/auth_repository.dart';
import 'package:currency/repository/history_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HistoryCubitEvent{}
// load data
class LoadHistoryCubitEvent extends HistoryCubitEvent{}

// refresh
class RefreshHistoryCubitEvent extends HistoryCubitEvent{}

//delete
class DeleteHistoryCubitEvent extends HistoryCubitEvent{
  final int id;
  DeleteHistoryCubitEvent(this.id);
}

class HistoryCubit extends Bloc<HistoryCubitEvent,List<HistoryModel>>{
  HistoryRepository _historyRepository = HistoryRepository();
  AuthRepository _authRepository =AuthRepository();
  List<HistoryModel> historyList =[];
  HistoryCubit() : super([]){
    this.add(LoadHistoryCubitEvent());
  }
  @override
  Stream<List<HistoryModel>> mapEventToState(HistoryCubitEvent event) async*{
    if(event is LoadHistoryCubitEvent){
      historyList =await _historyRepository.getForUsername(await _authRepository.fetchUsername);
      yield historyList.reversed.toList();
    }
    else if(event is DeleteHistoryCubitEvent){
      await _historyRepository.delete(event.id);
      this.add(LoadHistoryCubitEvent());
    }

  }

}
