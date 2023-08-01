part of 'call_bloc.dart';

@immutable
abstract class CallState {}

class CallInitial extends CallState {}

class ShowCallStatusListState extends CallState {}

class OnChangeCallStatusState extends CallState {}

class ShowCallSubStatusListState extends CallState {}

class OnChangeCallSubStatusState extends CallState {}

class ShowContactStatusListState extends CallState {}

class OnChangeContactStatusState extends CallState {}

class OnSubmitFeedbackState extends CallState {}
