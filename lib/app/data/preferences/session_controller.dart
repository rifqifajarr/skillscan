import 'package:shared_preferences/shared_preferences.dart';

class SessionController {
  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<void> changeStartedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('getStarted', false);
  }

  Future<bool?> getStartedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('getStarted');
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('username');
    await prefs.remove('getStarted');
  }
}
