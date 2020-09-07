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

  // get & set del idUsuario

  get idUsuario {
    return _preferences.getInt('id') ?? 1;
  }

  set idUsuario(int value) {
    _preferences.setInt('id', value);
  }

  // get & set del nombre de usuario

  get userName {
    return _preferences.getString('name') ?? 'Sin nombre';
  }

  set userName(String value) {
    _preferences.setString('name', value);
  }

  // get & set del nombre del correo del usuario

  get userEmail {
    return _preferences.getString('email') ?? 'Sin correo';
  }

  set userEmail(String value) {
    _preferences.setString('email', value);
  }

  // get & set rememberMe

  get rememberMe{
    return _preferences.getBool('rememberMe') ?? false;
  }

  set rememberMe(bool value) {
    _preferences.setBool('rememberMe', value);
  }

  // get & set de id categoria

  get idCategoria {
    return _preferences.getInt('idCategoria') ?? 1;
  }

  set idCategoria(int value) {
    _preferences.setInt('idCategoria', value);
  }

  // get & set de id categoria

  get idActiveCart {
    return _preferences.getInt('idActiveCart') ?? 1;
  }

  set idActiveCart(int value) {
    _preferences.setInt('idActiveCart', value);
  }

}