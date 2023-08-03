import 'dart:io';

import 'package:isfa_crm/accounts_module/models/contact_list_model.dart';

class CallData {
  final File path;
  final String duration;
  final ContactList contactList;
  CallData(this.path, this.duration, this.contactList);
}
