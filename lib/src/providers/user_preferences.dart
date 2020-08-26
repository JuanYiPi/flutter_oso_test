import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  SharedPreferences _preferences;

  initPrefs() async {
    this._preferences = await SharedPreferences.getInstance();
  }

  // get & set del genero

  get id {
    return _preferences.getInt('id') ?? 1;
  }

  set id(int value) {
    _preferences.setInt('id', value);
  }

  // get & set del nombre de usuario

  get userName {
    return _preferences.getString('name') ?? 'Sin nombre';
  }

  set userName(String value) {
    _preferences.setString('name', value);
  }

  get userEmail {
    return _preferences.getString('email') ?? 'Sin correo';
  }

  set userEmail(String value) {
    _preferences.setString('email', value);
  }

  // get & set de id categoria

  get idCategoria {
    return _preferences.getInt('idCategoria') ?? 1;
  }

  set idCategoria(int value) {
    _preferences.setInt('idCategoria', value);
  }
}