abstract class LocalDbService {
  Future<void> insert({required String key, required String value});
  String? get({required String key});
  List<String>? getListString({required String key});
  Future<void> insertListString(
      {required String key, required List<String> value});
}
