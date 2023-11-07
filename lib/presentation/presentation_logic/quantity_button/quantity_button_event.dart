part of 'quantity_button_bloc.dart';

class QuantityButtonEvent extends Equatable {
  const QuantityButtonEvent();

  @override
  List<Object> get props => [];
}

class Increment extends QuantityButtonEvent {}

class Decrement extends QuantityButtonEvent {}
