// import 'package:clax/models/Station.dart';
import 'dart:convert';

import 'package:clax/models/Station.dart';
// Station tanta = Station(governement: "سبرباى",stations: [Station]);

//  json.decode(_prefs.getString("complains")).forEach(
//           (complain) => _complains.add(ComplainModel.fromJson(complain)));

List<Station> getStaticData() {
  String stations =
      '[    {        "_stations": [            {                "coordinates": [                    31.010541915893555,                    30.8202946836524                ],                "_id": "5e7164c94b168835e419a6d1",                "name": "موقف سبرباي - طنطا"            },            {                "coordinates": [                    31.041398048400875,                    30.772224037597958                ],                "_id": "5e7164c94b168835e419a6d2",                "name": "كفر سبطاس"            },            {                "coordinates": [                    31.070194244384762,                    30.74139309869392                ],                "_id": "5e7164c94b168835e419a6d3",                "name": "شبرا قاص"            },            {                "coordinates": [                    31.12074851989746,                    30.728556257472835                ],                "_id": "5e7164c94b168835e419a6d4",                "name": "السنطة"            },            {                "coordinates": [                    31.15568161010742,                    30.725236106447074                ],                "_id": "5e7164c94b168835e419a6d5",                "name": "المنشأة الكبري"            },            {                "coordinates": [                    31.24340057373047,                    30.714315692146215                ],                "_id": "5e7164c94b168835e419a6d6",                "name": "زفتي"            }        ],        "_id": "5e7164c94b168835e419a6d7",        "from": "طنطا",        "to": "زفتى",        "cost": 9    },    {        "_stations": [            {                "coordinates": [                    31.010541915893555,                    30.820700085308367                ],                "_id": "5e71650f4b168835e419a6d8",                "name": "موقف سبرباي - طنطا"            },            {                "coordinates": [                    31.04985237121582,                    30.834814366656346                ],                "_id": "5e71650f4b168835e419a6d9",                "name": "الرجدية"            },            {                "coordinates": [                    31.069421768188477,                    30.858652837954484                ],                "_id": "5e71650f4b168835e419a6da",                "name": "شبشير الحصة"            },            {                "coordinates": [                    31.084699630737305,                    30.878949554194303                ],                "_id": "5e71650f4b168835e419a6db",                "name": "محلة روح"            },            {                "coordinates": [                    31.11461162567139,                    30.893865452260783                ],                "_id": "5e71650f4b168835e419a6dc",                "name": "صفت تراب"            },            {                "coordinates": [                    31.13690614700317,                    30.92987500453099                ],                "_id": "5e71650f4b168835e419a6dd",                "name": "منية شنتنا عياش"            },            {                "coordinates": [                    31.168127059936523,                    30.972126590449996                ],                "_id": "5e71650f4b168835e419a6de",                "name": "المحلة الكبري"            }        ],        "_id": "5e71650f4b168835e419a6df",        "from": "طنطا",        "to": "سمنود",        "cost": 9    },    {        "_stations": [            {                "coordinates": [                    31.000456809997555,                    30.809242222493257                ],                "_id": "5e716d465797b823582277e4",                "name": "كوبرى قحافة"            },            {                "coordinates": [                    30.995178222656246,                    30.804514937592057                ],                "_id": "5e716d465797b823582277e5",                "name": "المعرض"            },            {                "coordinates": [                    30.989854037761692,                    30.800031634819312                ],                "_id": "5e716d465797b823582277e6",                "name": "كفر عصام"            },            {                "coordinates": [                    30.984299182891846,                    30.7953269370548                ],                "_id": "5e716d465797b823582277e7",                "name": "طنطا سكان"            },            {                "coordinates": [                    30.9811931848526,                    30.793635770041387                ],                "_id": "5e716d465797b823582277e8",                "name": "الجملة"            },            {                "coordinates": [                    30.96221923828125,                    30.791792502356863                ],                "_id": "5e716d465797b823582277e9",                "name": "شركة البترول"            },            {                "coordinates": [                    30.95649003982544,                    30.792797087626607                ],                "_id": "5e716d465797b823582277ea",                "name": "محلة مرحوم"            },            {                "coordinates": [                    30.94844341278076,                    30.79431316203529                ],                "_id": "5e716d465797b823582277eb",                "name": "قاعة الولاء"            },            {                "coordinates": [                    30.947520732879635,                    30.794529742141993                ],                "_id": "5e716d465797b823582277ec",                "name": "قاعة سمرمون"            },            {                "coordinates": [                    30.94050407409668,                    30.795893724792677                ],                "_id": "5e716d465797b823582277ed",                "name": "نادى المهندسين"            },            {                "coordinates": [                    30.936083793640137,                    30.79674159614557                ],                "_id": "5e716d465797b823582277ee",                "name": "نادي ايزي سبورتس العبد"            },            {                "coordinates": [                    30.931035876274112,                    30.797713874198465                ],                "_id": "5e716d465797b823582277ef",                "name": "بيت الجياد"            },            {                "coordinates": [                    30.92821955680847,                    30.798317511074558                ],                "_id": "5e716d465797b823582277f0",                "name": "المعهد العالى للهندسة والتكنولوجيا بطنطا"            },            {                "coordinates": [                    30.92094004154205,                    30.7995823714713                ],                "_id": "5e716d465797b823582277f1",                "name": "شبرا النملة"            },            {                "coordinates": [                    30.91860920190811,                    30.800043154364744                ],                "_id": "5e716d465797b823582277f2",                "name": "الوحدة الصحية بشبرا النملة"            },            {                "coordinates": [                    30.916787981987,                    30.80041869078904                ],                "_id": "5e716d465797b823582277f3",                "name": "الحصري"            },            {                "coordinates": [                    30.915409326553345,                    30.800662903872716                ],                "_id": "5e716d465797b823582277f4",                "name": "كافيه الزعيم"            },            {                "coordinates": [                    30.91444373130798,                    30.800897900782477                ],                "_id": "5e716d465797b823582277f5",                "name": "توكيل نيسان"            },            {                "coordinates": [                    30.9134566783905,                    30.801075300029833                ],                "_id": "5e716d465797b823582277f6",                "name": "قاعة كوين"            },            {                "coordinates": [                    30.897127389907837,                    30.80413711336287                ],                "_id": "5e716d465797b823582277f7",                "name": "دوران بسيون"            },            {                "coordinates": [                    30.882364511489868,                    30.807016833719178                ],                "_id": "5e716d465797b823582277f8",                "name": "قاعة ليجيند"            },            {                "coordinates": [                    30.875589251518246,                    30.808311527868497                ],                "_id": "5e716d465797b823582277f9",                "name": "كفر ديما"            },            {                "coordinates": [                    30.845730900764465,                    30.81412591779093                ],                "_id": "5e716d465797b823582277fa",                "name": "اول كوبرى الدلجمون"            },            {                "coordinates": [                    30.838620364665985,                    30.816106968684405                ],                "_id": "5e716d465797b823582277fb",                "name": "آخر كوبرى الدلجمون"            },            {                "coordinates": [                    30.83722829818726,                    30.817341649503806                ],                "_id": "5e716d465797b823582277fc",                "name": "سعفان ام محمد"            },            {                "coordinates": [                    30.83135962486267,                    30.818265346230806                ],                "_id": "5e716d465797b823582277fd",                "name": "المرور"            },            {                "coordinates": [                    30.825721621513367,                    30.817945163084502                ],                "_id": "5e716d465797b823582277fe",                "name": "الشركة"            },            {                "coordinates": [                    30.824562907218933,                    30.818161689933373                ],                "_id": "5e716d465797b823582277ff",                "name": "مساكن الشركة"            },            {                "coordinates": [                    30.819332599639893,                    30.819179820274442                ],                "_id": "5e716d465797b82358227800",                "name": "المطافى"            },            {                "coordinates": [                    30.816553831100464,                    30.81976489481794                ],                "_id": "5e716d465797b82358227801",                "name": "الاتوبيس"            },            {                "coordinates": [                    30.814263224601742,                    30.820686264825532                ],                "_id": "5e716d465797b82358227802",                "name": "الموقف"            },            {                "coordinates": [                    31.007977724075317,                    30.822616506333294                ],                "_id": "5e716d465797b82358227803",                "name": "موقف سبرباي"            },            {                "coordinates": [                    31.005976796150204,                    30.816231358888853                ],                "_id": "5e716d465797b82358227804",                "name": "كلية الشريعة والقانون"            }        ],        "_id": "5e716d485797b82358227805",        "from": "طنطا",        "to": "كفر الزيات",        "cost": 9    }]';
  List<Station> decodestations = [];
  List<Station> _ = json
      .decode(stations)
      .forEach((station) => decodestations.add(Station.fromJson(station)));
  return decodestations;
}
