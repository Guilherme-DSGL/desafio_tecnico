import 'package:desafio_tecnico/core/services/local_db_service/local_db_service.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService implements LocalDbService {
  SharedPreferencesService._();
  late SharedPreferences prefs;

  static SharedPreferencesService? _instance;

  static Future<SharedPreferencesService> initialize() async {
    _instance ??= SharedPreferencesService._();
    await _instance!._init();
    return _instance!;
  }

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  String? get({required String key}) {
    return prefs.getString(key);
  }

  @override
  List<String>? getListString({required String key}) {
    return prefs.getStringList(key);
  }

  @override
  Future<void> insert({required String key, required String value}) async {
    await prefs.setString(key, value);
  }

  @override
  Future<void> insertListString(
      {required String key, required List<String> value}) async {
    await prefs.setStringList(key, value);
  }
}
