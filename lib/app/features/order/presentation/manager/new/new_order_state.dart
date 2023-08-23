part of 'new_order_bloc.dart';

abstract class NewOrderState extends Equatable {
  const NewOrderState();
}

class NewOrderInitial extends NewOrderState {
  @override
  List<Object> get props => [];
}
