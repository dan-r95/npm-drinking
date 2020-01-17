import 'package:rxdart/rxdart.dart';

class SingletonBloc {
  static final SingletonBloc _singletonBloc = new SingletonBloc._internal();

  // stream controllin which command was send out last
  BehaviorSubject<String> inputStream = BehaviorSubject<String>();

  factory SingletonBloc() {
    return _singletonBloc;
  }
  SingletonBloc._internal();

  dispose() {
    inputStream.close();
  }
}

final bloc = SingletonBloc();
