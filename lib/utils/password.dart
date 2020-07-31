import 'package:dbcrypt/dbcrypt.dart';

/// generate a text containing `passwordLenght` of `*`
///
/// e.g., for a `passwordLenght = 3`,
/// the function will return `'***'`
///
String password(int passwordLenght) {
  String pass = '';
  for (int i = 0; i < passwordLenght; i++) {
    pass += '*';
  }
  return pass;
}

/// Hash a password using the OpenBSD bcrypt scheme.
///
/// Returns the hashed password
///
String hashedPassword(String password) {
  DBCrypt dBCrypt = DBCrypt();
  return dBCrypt.hashpw(password, dBCrypt.gensaltWithRounds(10));
}

/// Check that a plaintext password matches a previously hashed one.
///
/// Returns true if the passwords match, false otherwise
///
bool verifyPassword(String password, String hashed) {
  DBCrypt dBCrypt = DBCrypt();
  return dBCrypt.checkpw(password, hashed);
}
