int dateInt(DateTime value) {
  return DateTime.now().difference(value).inDays;
}

String dateString(DateTime value) {
  return DateTime.now().difference(value).inDays.toString();
}

String adjustDateString(DateTime value) {
  int days = DateTime.now().difference(value).inDays;
  int weeks = 0;
  int months = 0;
  int years = 0;
  while (days > 7) {
    weeks += 1;
    days -= 7;
  }
  while (weeks > 4) {
    months += 1;
    weeks -= 4;
  }
  while (months > 12) {
    years += 1;
    months -= 12;
  }
  if (years != 0)
    return '$years' + 'y';
  else if (months != 0)
    return '$months' + 'm';
  else if (weeks != 0)
    return '$weeks' + 'w';
  else
    return '$days' + 'd';
}
