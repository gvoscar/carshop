import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = new UserPreferences._();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._();

  /// Preferencias compartidas.
  SharedPreferences _preferences;

  initUserPreferences() async {
    this._preferences = await SharedPreferences.getInstance();
  }

  /// SET y GET de email.
  set email(String email) => _preferences.setString('email', email);
  String get email => _preferences.getString('email' ?? '');
}
