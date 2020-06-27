String getName(String fullname) {
  List name = fullname.split(' ');
  if (name.length == 1)
    return fullname;
  else
    return name.getRange(0, 2).join(" ");
}

String getNumberViewString(number) {
  List name =
      number.split('').where((value) => value != '+' && value != '-').toList();
  if (name[0] == '2') {
    name.removeAt(0);
  }
  name.insert(4, '-');
  name.insert(8, '-');
  return name.join('');
}

String getNumber(String number) {
  List name =
      number.split('').where((value) => value != '+' && value != '-').toList();
  if (name[0] == '2') {
    name.removeAt(0);
  }
  return name.join('');
}

String brandName(value) {
  RegExp visa = RegExp(
    r"^4[0-9]{12}(?:[0-9]{3})?$",
  );
  RegExp mastercard = RegExp(
    r"^(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}$",
  );
  if (mastercard.hasMatch(value))
    return 'Mastercard';
  else if (visa.hasMatch(value))
    return 'Visa';
  else
    return "ميزا";
}
