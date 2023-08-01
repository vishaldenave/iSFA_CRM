part of 'call_bloc.dart';

@immutable
abstract class CallEvent {}

class ShowCallStatusListEvent extends CallEvent {}

class OnChangeCallStatusEvent extends CallEvent {}

class ShowContactStatusListEvent extends CallEvent {}

class OnChangeContactStatusEvent extends CallEvent {
  final int id;
  OnChangeContactStatusEvent(this.id);
}

class ShowCallSubStatusListEvent extends CallEvent {
  final int id;
  ShowCallSubStatusListEvent(this.id);
}

class OnChangeCallSubStatusEvent extends CallEvent {}
