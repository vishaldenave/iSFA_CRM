part of 'call_bloc.dart';

@immutable
abstract class CallEvent {}

class ShowCallStatusListEvent extends CallEvent {}

class OnChangeCallStatusEvent extends CallEvent {
  final String? selectedCallStatus;
  OnChangeCallStatusEvent(this.selectedCallStatus);
}

class ShowContactStatusListEvent extends CallEvent {}

class OnChangeContactStatusEvent extends CallEvent {
  final ContactStatusList? selectedContactStatus;
  OnChangeContactStatusEvent(this.selectedContactStatus);
}

class ShowCallSubStatusListEvent extends CallEvent {
  final int id;
  ShowCallSubStatusListEvent(this.id);
}

class OnChangeCallSubStatusEvent extends CallEvent {
  final String? selectedCallSubStatus;
  OnChangeCallSubStatusEvent(this.selectedCallSubStatus);
}

class OnSubmitFeedbackEvent extends CallEvent {}
