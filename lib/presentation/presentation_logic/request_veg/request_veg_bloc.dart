import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'request_veg_event.dart';
part 'request_veg_state.dart';

class RequestVegBloc extends Bloc<RequestVegEvent, RequestVegState> {
  RequestVegBloc() : super(RequestVegInitial()) {
    on<RequestVegEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
