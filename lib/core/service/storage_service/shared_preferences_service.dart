import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract final class SharedPreferencesKeys {
  static const String hasSeenOnboarding = 'hasSeenOnboarding';
}

@LazySingleton()
class SharedPreferencesService {
  const SharedPreferencesService(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  Future<void> saveBool(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  bool getBool(String key) {
    return sharedPreferences.getBool(key) ?? false;
  }
}
