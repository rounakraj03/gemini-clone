import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecuredSharedPreference {
  final key = Key.fromBase64("dzj1DkENgmPBxA+eWKlHng==");
  final iv = IV.fromBase64("dzj1DkENgmPBxA+eWKlHng==");
  late Encrypter encrypter;

  SecuredSharedPreference() {
    print("Shared preference initalized");
    encrypter = Encrypter(AES(
      key,
      mode: AESMode.cbc,
    ));
  }

  Future<String> secureGetString(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String data = prefs.getString(key) ?? "";
      final decrypted = encrypter.decrypt16(data, iv: iv);
      return decrypted;
    } catch (e) {
      return "";
    }
  }

  Future<void> secureSetString(String key, String value) async {
    if (value != "") {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final encrypted = encrypter.encrypt(value, iv: iv).base16;
      await prefs.setString(key, encrypted);
    }
  }

  Future<String> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  Future<int> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

  Future<double> getDouble(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key) ?? 0;
  }

  Future<bool> getBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  Future<void> setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> setInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<void> setDouble(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<void> removePreference(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<bool> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
