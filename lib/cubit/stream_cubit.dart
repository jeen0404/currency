import 'package:bloc/bloc.dart';

/// for streaming same data back
class BaseStream<T> extends Bloc<T,T>{
  BaseStream(T init): super(init);
  @override
  Stream<T> mapEventToState(T event)async* {

   yield event;
  }

}

class IntStreamCubit extends BaseStream<int> {
  IntStreamCubit() : super(0);
}
