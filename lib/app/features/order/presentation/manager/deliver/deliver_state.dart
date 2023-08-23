part of 'deliver_bloc.dart';

abstract class DeliverState extends Equatable {
  const DeliverState();
}

class DeliverInitial extends DeliverState {
  @override
  List<Object> get props => [];
}
