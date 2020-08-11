// Dart & Other Packages
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// Flutter's Material Components
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// Services
import 'package:clax/services/Backend.dart';
// Providers
import 'package:clax/providers/Auth.dart';
// Widgets
import 'package:clax/widgets/Alerts.dart';

class RegisterForm2 extends StatefulWidget {
  static const routeName = '/register2';
  @override
  _RegisterForm2State createState() => _RegisterForm2State();
}

class _RegisterForm2State extends State<RegisterForm2> {
  List<String> titles = [
    "العلاقة التعاقدية:",
    'الخدمات:',
    'استخدامك للخدمات:',
    'الدفع:',
    'التعويض:',
    'القانون الحاكم:'
  ];
  List<String> details = [
    'تحكم شروط الاستخدام هذه ("الشروط") وصول أو استخدام الأفراد من أي دولة في العالم (باستثناء الولايات المتحدة وأراضيها وممتلكاتها وبر الصين الرئيسي) للتطبيقات والمواقع الإلكترونية والمحتويات والمنتجات والخدمات ("الخدمات") التي توفرها شركة أوبر بي.في، وهي شركة خاصة ذات مسؤولية محدودة تأسست في هولندا ويقع مقرها الرئيسي في Mr. Treublaan 7, 1097 DP, Amsterdam, The Netherlands، ومسجلة لدى غرفة التجارة بأمستردام تحت رقم: 56317441 ("أوبر").\nيُرجى قراءة هذه الشروط بعناية قبل الحصول على الخدمات أو استخدامها.\nإن وصولك إلى الخدمات واستخدامها يعتبر موافقة منك على الالتزام بهذه الشروط، مما يُنشئ علاقة تعاقدية بينك وبين أوبر. وفي حالة عدم موافقتك على هذه الشروط، لا يجوز لك الحصول على الخدمات أو استخدامها. وتحل هذه الشروط تحديداً محل أي اتفاقات أو ترتيبات سابقة أبرمت معك. ويجوز لشركة أوبر إنهاء هذه الشروط أو أي من الخدمات التي تخصك على الفور أو بشكل عام إيقاف عرض الخدمات أو منع الوصول إليها أو إلى أي جزء منها في أي وقت ولأي سبب كان.\nوقد تنطبق بعض الشروط التكميلية على خدمات معينة، كالسياسات الخاصة بحدث أو نشاط أو حملة ترويجية معينة، وسيتم الإفصاح لك عن هذه الشروط التكميلية المتعلقة بالخدمات المقدمة. تُضاف الشروط التكميلية إلى الشروط لأغراض الخدمات المقدمة كما وتعتبر جزءاً منها. وتسود الشروط التكميلية على هذه الشروط في حالة التعارض فيما يتعلق بالخدمات المقدمة.',
    'تُشكل الخدمات منصة تقنية تمكّن مستخدمي تطبيقات الجوال أو المواقع الإلكترونية الخاصة بشركة أوبر والمتاحة كجزء من الخدمات (يُشار إلى كل منها بـ "التطبيق") لترتيب وجدولة خدمات النقل و/أو الخدمات اللوجستية مع الأطراف الخارجية المستقلة المقدمة لهذه الخدمات، بما في ذلك مقدمي خدمات النقل الخارجيين المستقلين ومقدمي الخدمات اللوجستية الخارجيين المستقلين بموجب الاتفاق مع أوبر أو بعض شركاتها الفرعية ("مقدمو الخدمات الخارجيون"). يتم توفير الخدمات لاستخداماتك الشخصية غير التجارية فقط إلا إذا وافقت أوبر على خلاف ذلك في اتفاقية كتابية منفصلة معك. وتقر من جانبك بأن أوبر لا تقدم خدمات النقل أو الخدمات اللوجستية أو تعمل بوصفها شركة نقل وأن جميع خدمات النقل أو الخدمات اللوجستية تقدم بواسطة مقاولين خارجيين مستقلين لا يعملون لدى أوبر أو أي من شركاتها الفرعية.',
    'من أجل استخدام معظم جوانب الخدمات، يجب أن تقوم بالتسجيل من أجل الحصول على حساب شخصي فعّال لخدمات المستخدم والمحافظة عليه ("الحساب"). ويجب أن يكون عمرك 18 عاماً على الأقل أو تكون في سن الرشد القانونية في ولايتك القضائية (إن كان مختلفاً عن 18 عاماً) حتى يتسنى لك الحصول على حساب. ويتطلب تسجيل الحساب تقديم معلومات شخصية معينة إلى أوبر كاسمك وعنوانك ورقم هاتفك الجوال وعمرك، إضافة إلى طريقة دفع واحدة صحيحة على الأقل (إما بطاقة ائتمانية أو شريك دفع مقبول). وتوافق من جانبك على تدوين معلومات دقيقة وكاملة وحديثه في حسابك الخاص والمحافظة عليها. وقد يؤدي عدم محافظتك على وجود معلومات دقيقة وكاملة وحديثه في حسابك، بما في ذلك تعيين طريقة دفع غير صالحة أو منتهية الصلاحية، إلى عدم قدرتك على الوصول إلى الخدمات أو استخدامك لها أو إنهاء أوبر لهذه الشروط معك. تتحمل أنت المسؤولية عن جميع الأنشطة التي تُجرى باسم حسابك، كما توافق على الحفاظ على أمان وسرية اسم المستخدم وكلمة المرور الخاصين بحسابك طوال الوقت. لا يحق لك امتلاك أكثر من حساب واحد ما لم تسمح لك أوبر كتابةً بخلاف ذلك.',
    'تتفهم من جانبك أن استخدام الخدمات قد يؤدي إلى فرض رسوم عليك في مقابل الخدمات أو السلع التي تحصل عليها من مقدم خدمات خارجي ("الرسوم"). وبعد أن تتلقى الخدمات أو السلع المتحصل عليها من خلال استخدامك للخدمة، ستسهل عليك شركة أوبر دفع الرسوم المطبقة نيابة عن مقدم الخدمات الخارجي بصفتها وكيل تحصيل المدفوعات المحدود التابع لمقدم الخدمات الخارجي. ويعتبر دفع الرسوم على هذا النحو فعالاً كما لو أُجري الدفع مباشرة من جانبك إلى مقدم الخدمات الخارجي. وستشمل الرسوم الضرائب المعمول بها بحسب ما ينص عليه القانون. وتكون جميع الرسوم التي تدفعها نهائية وغير قابلة للاسترداد، ما لم تحدد أوبر خلاف ذلك. وتحتفظ من جانبك بالحق في طلب تخفيض الرسوم من مقدم خدمات خارجي مقابل الخدمات والسلع التي تلقيتها منه وقت تلقيك هذه الخدمات والسلع. وبناءً عليه، سوف تستجيب أوبر لأي طلب من أي مقدم خدمات خارجي لتعديل الرسوم الخاصة بخدمة أو سلعة معينة.',
    'تُقدَّم الخدمات "على حالتها" و"بحسب توافرها". تُخلي أوبر مسؤوليتها عن جميع الإقرارات والتعهدات صريحة كانت أم ضمنية أم تشريعية والتي لم يُنص عليها صراحة في هذه الشروط بما فيها الإقرارات الضمنية الخاصة بقابلية التسويق والملائمة لغرض معين وعدم المخالفة. إضافة إلى ذلك، لا تقدم أوبر أي إقرارات أو تعهدات أو ضمانات بخصوص موثوقية أو دقة مواعيد أو جودة أو ملاءمة أو توافر الخدمات أو أي منها أو السلع المطلوبة أثناء استخدام هذه الخدمات أو بخصوص عدم انقطاع الخدمات أو خلوها من الأخطاء. ولا تضمن أوبر جودة مقدمي الخدمات الخارجيين أو ملاءمتهم أو سلامتهم أو قدرتهم. توافق من جانبك على أن المخاطر الكاملة التي تنشأ عن استخدامك للخدمات أو أي من الخدمات أو السلع المطلوبة فيما يتعلق بهذا الاستخدام تبقى متعلقة بك وحدك إلى الحد الأقصى المسموح به بموجب القانون المعمول به.',
    'باستثناء ما تنص عليه هذه الشروط، تخضع هذه الشروط للقوانين الهولندية وحدها دون غيرها وتفسر وفقًا لها، باستثناء قواعدها المتعلقة بتعارض القوانين. لا تنطبق اتفاقية فيينا بشأن عقود البيع الدولي للبضائع لعام 1980 (CISG) على هذه الشروط. إن أي منازعات أو خلافات أو دعاوى أو خصومات تنشأ عن هذه الخدمات أو هذه الشروط أو تتعلق بها، بما في ذلك ما يتعلق بسريانها وتفسيرها وإنفاذها (أي "نزاع") يجب أن تُحل في البداية بصورة إلزامية من خلال إجراءات التسوية بموجب قواعد الوساطة لغرفة التجارة الدولية ("قواعد الوساطة لغرفة التجارة الدولية"). وإذا لم تتم تسوية النزاع المذكور خلال ستين (60) يوماً من تقديم طلب لتسوية النزاع بموجب قواعد الوساطة لغرفة التجارة الدولية المذكورة، فإنه يجب إحالة هذا النزاع إلى التحكيم وحله نهائياً وحصرياً بموجب قواعد التحكيم الخاصة بغرفة التجارة الدولية (قواعد التحكيم الخاصة بغرفة التجارة الدولية). وتُستثنى أحكام محكَّم الطوارئ في قواعد غرفة التجارة الدولية. ويجب حل النزاع بتعيين محكّم واحد (1) بما يتفق مع قواعد غرفة التجارة الدولية. ويكون مقر كل من الوساطة والتحكيم هو أمستردام في دولة هولندا مع عدم الإخلال بأي حقوق واجبة لك بموجب المادة 18 من لائحة بروكسل الأولى مكررة (OJ EU 2012 L351/1) و/أو المادة 6:236n من القانون المدني الهولندي. وتكون اللغة الإنجليزية هي لغة الوساطة و/أو التحكيم، ما لم تكن من غير الناطقين بالإنجليزية، وفي مثل هذه الحالة يتم إجراء الوساطة و/أو التحكيم باللغة الإنجليزية ولغتك الأصلية. ويجب أن تظل حقيقة وجود ومضمون إجراءات الوساطة والتحكيم، بما في ذلك المستندات ومذكرات الدعوى المقدمة من قبل الطرفين، والمراسلات من غرفة التجارة الدولية وإليها، والمراسلات من الوسيط، والمراسلات والأوامر والقرارات الصادرة عن المحكم الوحيد، سرية للغاية ولا يُفصح عنها إلى أي طرف خارجي دون موافقة كتابية صريحة من الطرف الآخر ما لم: (1) يكن الإفصاح إلى الطرف الخارجي مطلوباً على نحو معقول في سياق تنفيذ إجراءات الوساطة أو التحكيم؛ و(2) يوافق الطرف الخارجي كتابياً دون شرط على التقيد بالتزامات السرية المنصوص عليها في هذه الشروط.',
  ];
  bool _termsChecked = false;
  bool _loading = false;
  bool p1Error = false;
  bool p2Error = false;
  bool p3Error = false;
  Widget _eulaCondition = SizedBox(height: 0);

  /// Profile Licence CarPapers
  Map<String, dynamic> pictures = {
    "Profile": Map(),
    "Licence": Map(),
    "CarPapers": Map(),
  };

  void getPicture(context2, label) {
    showModalBottomSheet<int>(
      context: context2,
      elevation: 1,
      builder: (context) => Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Row(children: <Widget>[
                Icon(FontAwesomeIcons.image, color: Colors.white),
                SizedBox(width: 16),
                Text(
                  "حدد مكان الصورة",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(color: Colors.white),
                )
              ]),
            ),
            GestureDetector(
              onTap: () async {
                PickedFile file = await ImagePicker()
                    .getImage(source: ImageSource.gallery, maxHeight: 1000);

                String imageName = file.path.split("/").last;
                Uint8List image = await file.readAsBytes();
                String encodedImage = base64Encode(image.toList());
                setState(() {
                  pictures[label] = {'name': imageName, "image": encodedImage};
                });
                Navigator.of(context).pop();
              },
              child: Container(
                  padding: EdgeInsets.only(right: 16, top: 8, bottom: 4),
                  child: Row(children: <Widget>[
                    Icon(Icons.image, color: Theme.of(context).primaryColor),
                    SizedBox(width: 16),
                    Text("صورة من المعرض",
                        style: Theme.of(context).textTheme.subtitle2),
                  ])),
            ),
            GestureDetector(
              onTap: () async {
                PickedFile file = await ImagePicker()
                    .getImage(source: ImageSource.camera, maxHeight: 1000);
                String imageName = file.path.split("/").last;
                Uint8List image = await file.readAsBytes();
                String encodedImage = base64Encode(image.toList());
                setState(() {
                  pictures[label] = {'name': imageName, "image": encodedImage};
                });
                Navigator.of(context).pop();
              },
              child: Container(
                  padding: EdgeInsets.only(right: 16, bottom: 16, top: 8),
                  child: Row(children: <Widget>[
                    Icon(Icons.camera_alt,
                        color: Theme.of(context).primaryColor),
                    SizedBox(width: 16),
                    Text("صورة من الكاميرا",
                        style: Theme.of(context).textTheme.subtitle2),
                  ])),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> register() async {
    bool error = false;
    // If Conditions aren't met or EULA isn't checks
    if (!_termsChecked) {
      // Show EULA not Checked Error
      setState(() {
        _eulaCondition = Text("يجب ان توافق علي الشروط و الأحكام",
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.red));
      });
      error = true;
    }
    // Remove EULA not Checked Error
    else
      setState(() {
        _eulaCondition = SizedBox(height: 0);
      });

    p1Error = false;
    p2Error = false;
    p3Error = false;

    // Input Data passed the required Conditions
    if (pictures['Profile'].length == 0) {
      error = true;
      p1Error = true;
    }
    if (pictures['Licence'].length == 0) {
      error = true;
      p2Error = true;
    }
    if (pictures['CarPapers'].length == 0) {
      p3Error = true;
      error = true;
    }

    if (error == true)
      return 0;
    else {
      // Remove EULA not Checked Error
      setState(() {
        _eulaCondition = SizedBox(height: 0);
      });

      // get previous data
      // "name", Done
      // "pass", Done
      // "passLength", Done
      // "phone", Done
      // "stripeId", Done
      // "fireBaseId", Done
      // "profilePic",
      // "govern",  Done

      Map<String, dynamic> args =
          Map<String, dynamic>.from(ModalRoute.of(context).settings.arguments);

      /// 'firstName': _firstName.text,
      /// 'lastName': _lastName.text,
      /// 'phone': _phone.text,
      /// 'mail': _email.text,
      /// 'pass': _password.text,
      /// 'fireBaseId': firebaseToken,
      /// 'govern': selectedGovernment
      Map<String, dynamic> body = args['data'];
      body['passLength'] = (body['pass'] as String).length;
      body['profilePic'] = {"data": pictures['Profile']['image']};
      body['license'] = {"data": pictures['Licence']['image']};
      body['criminalRecord'] = {"data": pictures['CarPapers']['image']};

      // Disable Register Button
      setState(() {
        _loading = true;
      });

      // Register The User from on Server
      Response result = await Api.post("drivers/register", json.encode(body),
          stringDynamic: true);
      // If User's info is correct
      if (result.statusCode == 200) {
        Provider.of<AuthProvider>(context, listen: false)
            .logIn(result.headers['x-login-token']);
        Navigator.pop(context);
        Navigator.pop(context);
        oneButtonAlertDialoge(
          context,
          title: "شكرا لتسجيلك معانا في كلاكس",
          description: "سنقوم بالاتصال بك في اقرب وقت لإتمام عملية التسجيل",
        );

        // Enable Register Button
        setState(() {
          _loading = true;
        });
        return 0;
      }

      // If User's info is incorrect
      else if (result.statusCode == 409) {
        // Enable Register Button
        setState(() {
          _loading = false;
        });
        return result.body;
      }

      // If There is no Internet Connection
      else {
        // Enable Register Button
        setState(() {
          _loading = false;
        });
        return 2;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    // الشروط والقوانين
    ThemeData theme = Theme.of(context);
    Color purple = theme.primaryColor;
    TextTheme textTheme = theme.textTheme;

    TapGestureRecognizer showEULA = TapGestureRecognizer()
      ..onTap = () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: titles.length,
                    itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: <Widget>[
                                Text((index + 1).toString() + ". ",
                                    style: textTheme.bodyText1),
                                Text(
                                  titles[index],
                                  style: textTheme.bodyText1
                                      .copyWith(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          Text(
                            details[index],
                            style: textTheme.bodyText2
                                .copyWith(color: Colors.grey),
                          )
                        ]),
                  ),
                ),
              );
            });
      };
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('حساب جديد',
            style: textTheme.bodyText1.copyWith(color: Colors.white)),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                'assets/images/register.png',
                colorBlendMode: BlendMode.overlay,
              ),
              SizedBox(height: 10),
              // Profile Picture
              Builder(
                builder: (context) => GestureDetector(
                  onTap: () => getPicture(context, "Profile"),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: p1Error ? Colors.red : Colors.grey[350])),
                    child: Row(children: <Widget>[
                      Icon(Icons.account_box,
                          color: Theme.of(context).primaryColor),
                      SizedBox(width: 16),
                      pictures["Profile"]['image'] == null
                          ? Text("الصورة الشخصيه",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.grey))
                          : Text(pictures["Profile"]['name'].substring(1, 32)),
                    ]),
                  ),
                ),
              ),
              SizedBox(height: 8),
              // Licence
              Builder(
                builder: (context) => GestureDetector(
                  onTap: () => getPicture(context, "Licence"),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: p2Error ? Colors.red : Colors.grey[350])),
                    child: Row(children: <Widget>[
                      Icon(FontAwesomeIcons.addressCard,
                          color: Theme.of(context).primaryColor),
                      SizedBox(width: 16),
                      pictures["Licence"]['image'] == null
                          ? Text("رخصه القيادة",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.grey))
                          : Text(pictures["Licence"]['name'].substring(1, 32)),
                      Spacer()
                    ]),
                  ),
                ),
              ),
              SizedBox(height: 8),
              // Car Permission
              Builder(
                builder: (context) => GestureDetector(
                  onTap: () => getPicture(context, "CarPapers"),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: p3Error ? Colors.red : Colors.grey[350])),
                    child: Row(children: <Widget>[
                      Icon(Icons.insert_drive_file,
                          color: Theme.of(context).primaryColor),
                      SizedBox(width: 8),
                      pictures["CarPapers"]['image'] == null
                          ? Text("الفيش والتشبيه",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.grey))
                          : Text(
                              pictures["CarPapers"]['name'].substring(1, 32)),
                    ]),
                  ),
                ),
              ),
              // Terms and Cibdutuibs
              Row(mainAxisSize: MainAxisSize.min, children: [
                Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: _termsChecked,
                  activeColor: purple,
                  onChanged: (value) => setState(() {
                    _termsChecked = value;
                  }),
                ),
                RichText(
                    textScaleFactor: 1,
                    strutStyle: StrutStyle(forceStrutHeight: true),
                    text: TextSpan(children: [
                      TextSpan(
                          text: "اوافق على جميع",
                          style: textTheme.subtitle2
                              .copyWith(color: Colors.black54)),
                      TextSpan(
                          recognizer: showEULA,
                          text: " الشروط و القوانين",
                          style: textTheme.subtitle2.copyWith(color: purple))
                    ])),
              ]),
              Padding(
                child: _eulaCondition,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              ),
              // Register Button
              Builder(
                builder: (context) => Container(
                  width: double.infinity,
                  child: _loading
                      ? Padding(
                          child: SpinKitCircle(color: purple, size: 30),
                          padding: EdgeInsets.only(top: 15),
                        )
                      : RaisedButton(
                          elevation: 0,
                          highlightElevation: 0,
                          onPressed: () async {
                            var result = await register();
                            if (result == 2)
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "تعذر الوصول للانترنت.",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(color: Colors.white),
                                  ),
                                ),
                              );
                            else if (result != 0)
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                "$result",
                                style: textTheme.bodyText2
                                    .copyWith(color: Colors.white),
                              )));
                          },
                          shape: StadiumBorder(),
                          color: purple,
                          padding:
                              EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                          child: Text(
                            "تسجيل",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
