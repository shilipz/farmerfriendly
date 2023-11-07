part of 'request_veg_bloc.dart';

sealed class RequestVegState extends Equatable {
  const RequestVegState();
  
  @override
  List<Object> get props => [];
}

final class RequestVegInitial extends RequestVegState {}
