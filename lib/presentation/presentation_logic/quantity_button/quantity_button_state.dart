part of 'quantity_button_bloc.dart';

// ignore: must_be_immutable
class QuantityButtonState extends Equatable {
  int count;
  QuantityButtonState({required this.count});

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class QuantityButtonInitial extends QuantityButtonState {
  QuantityButtonInitial() : super(count: 0);
}
