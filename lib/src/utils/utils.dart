/// Utilidades.

/// Validar si la [cadena] es un número valido.
/// Devuelve true si es un número, false en caso contrario.
bool isNumeric(String cadena) {
  if (cadena.isEmpty) return false;
  final n = num.tryParse(cadena);
  return (n == null) ? false : true;
}

/// Contiene numeros. (Devuelve true si es valido, false en caso contrario)
bool isValidNumber(String cadena) {
  Pattern pattern = r'^[0-9]+$';
  RegExp regExp = new RegExp(pattern);
  if (regExp.hasMatch(cadena)) return true;
  return false;
}

/// Contiene letras. (Devuelve true si es valido, false en caso contrario)
bool isValidText(String cadena) {
  // Pattern pattern = r'^[A-Za-z\\u00f1\\u00d1]+$';
  Pattern pattern =
      r'^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$';
  RegExp regExp = new RegExp(pattern);
  if (regExp.hasMatch(cadena)) return true;
  return false;
}

/// Contiene letras y numeros. (Devuelve true si es valido, false en caso contrario)
bool isValidLettersAndNumbers(String cadena) {
  Pattern pattern = r'^[A-Za-z\\u00f1\\u00d10-9]+$';
  RegExp regExp = new RegExp(pattern);
  if (regExp.hasMatch(cadena)) return true;
  return false;
}

/// Validar si la [cadena] es un correo electronico valido.
/// Devuelve true si es un correo valido, false en caso contrario.
bool isValidEmail(String cadena) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (regExp.hasMatch(cadena)) return true;
  return false;
}

/// Validar si la [cadena] es una contraseña valida.
/// Devuelve true si es una contraseña valida, false en caso contrario.
bool isValidPassword(String cadena) {
  if (cadena.length >= 8 && cadena.length <= 30) {
    return true;
  } else {
    return false;
  }
}
