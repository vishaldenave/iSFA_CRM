import 'package:hive_flutter/hive_flutter.dart';
import 'package:isfa_crm/assigned_accounts_module/models/assigned_accounts_model.dart';
import '../login_module/models/login_model.dart';

class AppStorage {
  static final AppStorage _singleton = AppStorage._internal();

  factory AppStorage() {
    return _singleton;
  }

  AppStorage._internal();

  final String _prefrenceName = "isfa_prefrence";
  late Box _box;

  Future<AppStorage> _init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_prefrenceName);
    return this;
  }

  LoginModel? get userDetail {
    final userRawJson = _box.get("user_detail");
    if (userRawJson is String) {
      return LoginModel.fromRawJson(userRawJson);
    }
    return null;
  }

  set userDetail(LoginModel? userInfo) =>
      _box.put("user_detail", userInfo?.toRawJson());

  Future<void> logout() async {
    await _box.clear();
  }

  AssignedAccountsModel? get assignedAccountDetails {
    final accountRawJson = _box.get("assigned_account_detail");
    if (accountRawJson is String) {
      return AssignedAccountsModel.fromRawJson(accountRawJson);
    }
    return null;
  }

  set assignedAccountDetails(AssignedAccountsModel? accountsInfo) =>
      _box.put("user_detail", accountsInfo?.toRawJson());

  static Future<AppStorage> objectValue() async {
    return await AppStorage()._init();
  }

  bool get temp => _box.get("temp") ?? false;
  set temp(bool newVal) => _box.put("temp", newVal);

  CampaignList? get currentCampaign {
    final userRawJson = _box.get("currentCampaign");
    if (userRawJson is String) {
      return CampaignList.fromRawJson(userRawJson);
    }
    return null;
  }

  set currentCampaign(CampaignList? currentCampaign) =>
      _box.put("currentCampaign", currentCampaign?.toRawJson());
}
