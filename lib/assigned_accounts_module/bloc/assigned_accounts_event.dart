part of 'assigned_accounts_bloc.dart';

@immutable
abstract class AssignedAccountsEvent {}

class AssignedAccountShowCurrentEvent extends AssignedAccountsEvent {}

class AssignedAccountShowAllEvent extends AssignedAccountsEvent {}

class AssignedAccountUpdateCurrentEvent extends AssignedAccountsEvent {
  final int caimpaignId;
  AssignedAccountUpdateCurrentEvent(this.caimpaignId);
}

class ChangeCurrentEvent extends AssignedAccountsEvent {
  final int caimpaignId;
  ChangeCurrentEvent(this.caimpaignId);
}
