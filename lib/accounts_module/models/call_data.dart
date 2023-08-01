import 'package:isfa_crm/accounts_module/models/contact_list_model.dart';

class CallData {
  final String path;
  final String duration;
  final ContactList contactList;
  CallData(this.path, this.duration, this.contactList);
}
