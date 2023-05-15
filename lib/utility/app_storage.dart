import 'package:hive_flutter/hive_flutter.dart';

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

  static Future<AppStorage> objectValue() async {
    return await AppStorage()._init();
  }

  bool get temp => _box.get("temp") ?? false;
  set temp(bool newVal) => _box.put("temp", newVal);
}
