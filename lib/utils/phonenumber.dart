String getNumberViewString(number) {
  List name = number
      .split('')
      .where((value) => value != '+' && value != '-' && value != ' ')
      .toList();
  if (name[0] == '2') {
    name.removeAt(0);
  }
  // name.insert(4, '-');
  // name.insert(8, '-');
  return name.join('');
}
