import 'package:dbcrypt/dbcrypt.dart';

String password(passwordLenght) {
  String pass = '';
  for (int i = 0; i < passwordLenght; i++) {
    pass += '*';
  }
  return pass;
}

String hashedPassword(String password) {
  DBCrypt dBCrypt = DBCrypt();
  return dBCrypt.hashpw(password, dBCrypt.gensaltWithRounds(10));
}

bool verifyPassword(String password, String hashed) {
  DBCrypt dBCrypt = DBCrypt();
  return dBCrypt.checkpw(password, hashed);
}
