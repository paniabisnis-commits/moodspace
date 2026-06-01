import 'package:shared_preferences/shared_preferences.dart';

class AppLockService {

  static bool _isLockScreenShowing = false;

  static DateTime? backgroundTime;

  static bool get isLockScreenShowing =>
      _isLockScreenShowing;

  static void setLockShowing(bool value) {
    _isLockScreenShowing = value;
  }

  static Future<String> getSecurityType() async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
          'security_type',
        ) ??
        'NONE';
  }

  static Future<String> getPin() async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
          'security_pin',
        ) ??
        '';
  }

  static Future<String> getPattern() async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getString(
          'security_pattern',
        ) ??
        '';
  }

  static Future<bool> hasSecurity() async {

    final type =
        await getSecurityType();

    return type != 'NONE';
  }
}