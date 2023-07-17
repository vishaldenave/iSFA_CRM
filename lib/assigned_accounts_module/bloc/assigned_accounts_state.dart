part of 'assigned_accounts_bloc.dart';

@immutable
abstract class AssignedAccountsState {}

class AssignedAccountsInitial extends AssignedAccountsState {}

class AssignedAccountsCurrentState extends AssignedAccountsState {}

class AssignedAccountsAllState extends AssignedAccountsState {}

class AssignedAccountUpdateCurrentState extends AssignedAccountsState {}

class SearchState extends AssignedAccountsState {}
