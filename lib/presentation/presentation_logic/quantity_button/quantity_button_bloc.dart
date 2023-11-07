import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'quantity_button_event.dart';
part 'quantity_button_state.dart';

class QuantityButtonBloc
    extends Bloc<QuantityButtonEvent, QuantityButtonState> {
  QuantityButtonBloc() : super(QuantityButtonInitial()) {
    on<Increment>((event, emit) {
      emit(QuantityButtonState(count: state.count + 1));
    });
    on<Decrement>((event, emit) {
      emit(QuantityButtonState(count: state.count - 1));
    });
  }
}
