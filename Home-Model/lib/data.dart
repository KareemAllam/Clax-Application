import 'models/trip.dart';

List<Trip> trips = [
  Trip(
      location: 'المحطة < الجملة',
      date: DateTime.utc(2020, 2, 1),
      price: 35,
      rate: 50,
      favorite: true),
  Trip(
      location: 'كفر الشيخ < المعرض',
      date: DateTime.utc(2020, 2, 2),
      price: 40,
      rate: 50,
      favorite: true),
  Trip(
      location: 'محلة مرحوم < المعرض',
      date: DateTime.utc(2020, 1, 27),
      price: 50,
      rate: 50,
      favorite: true),
  Trip(
      location: 'المحافظة < الشيخه صباح',
      date: DateTime.utc(2020, 1, 5),
      price: 50,
      rate: 50,
      favorite: false),
  Trip(
      location: 'الجامه < الجلاء',
      date: DateTime.utc(2020, 1, 8),
      price: 50,
      rate: 50,
      favorite: false),
  Trip(
      location: 'سبرباي < الجملة',
      date: DateTime.utc(2020, 2, 27),
      price: 50,
      rate: 50,
      favorite: false),
  Trip(
      location: 'كفر عصام < سبرباى',
      date: DateTime.utc(2020, 2, 27),
      price: 50,
      rate: 50,
      favorite: false),
  Trip(
      location: 'الجلاء < سبرباى',
      date: DateTime.utc(2020, 2, 27),
      price: 50,
      rate: 50,
      favorite: false),
];
