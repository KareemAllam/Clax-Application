/// **Convert a Phone Number into String**
///
/// The function removes +, - symbols
/// and starting country code
/// returning a clean 11 char phone number
///
/// You can also get a clean user view by setting ` clean = true `
String phoneNumber(String uglyNumber, {bool userView = false}) {
  List cleanPhoneNumber = uglyNumber
      .split('')
      .where((value) => value != '+' && value != '-' && value != ' ')
      .toList();
  if (cleanPhoneNumber[0] == '2') {
    cleanPhoneNumber.removeAt(0);
  }
  if (userView == true) {
    cleanPhoneNumber.insert(4, '-');
    cleanPhoneNumber.insert(8, '-');
  }
  return cleanPhoneNumber.join('');
}

/// **Brand name from credit-card number**
///
/// a regex is used to accurately identify the patterns below
/// - _Mastercard_
/// - _Visa_
/// - _Miza_, otherwise
String brandName(value) {
  RegExp visa = RegExp(
    r"^4[0-9]{12}(?:[0-9]{3})?$",
  );
  RegExp mastercard = RegExp(
    r"^(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}$",
  );
  if (mastercard.hasMatch(value))
    return 'MasterCard';
  else if (visa.hasMatch(value))
    return 'Visa';
  else
    return "ميزا";
}
