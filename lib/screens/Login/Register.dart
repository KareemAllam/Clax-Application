// Dart & Other Packages
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
// Flutter's Material Components
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Services
import 'package:clax/services/Backend.dart';
// Providers
import 'package:clax/providers/Auth.dart';
// Static Data
import 'package:clax/governments.dart';

class RegisterForm extends StatefulWidget {
  static const routeName = '/register';
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
  final _formKey = GlobalKey<FormState>();
  final RegExp phone = RegExp(r'^[0-9]+$');
  final RegExp phoneEgypt = RegExp(r'^01[0125][0-9]{8}$');
  final RegExp email = RegExp(
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
  bool _nameFocused = false;
  bool _nameError = false;
  bool _hiddenPassword = true;
  bool _termsChecked = false;
  bool _loading = false;
  Widget _eulaCondition = SizedBox(height: 0);
  List<String> goverments = staticGoverments;
  String selectedGovernment;
  String password;
  TextEditingController _firstName = TextEditingController();
  FocusNode _firstNameNode = FocusNode();
  TextEditingController _lastName = TextEditingController();
  FocusNode _lastNameNode = FocusNode();
  TextEditingController _email = TextEditingController();
  FocusNode _emailNode = FocusNode();
  TextEditingController _phone = TextEditingController();
  FocusNode _phoneNode = FocusNode();
  TextEditingController _password = TextEditingController();
  FocusNode _passwordNode = FocusNode();
  TextEditingController _confirmPassword = TextEditingController();
  FocusNode _confirmPasswordNode = FocusNode();

  Future<dynamic> register(firebaseToken) async {
    // Check For Validation Conditions
    _formKey.currentState.validate();
    bool result = _formKey.currentState.validate();

    // If Conditions aren't met or EULA isn't checks
    if (!_termsChecked | !result) {
      if (!_termsChecked)
        // Show EULA not Checked Error
        setState(() {
          _eulaCondition = Text("يجب ان توافق علي الشروط و الأحكام",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.red));
        });
      // Remove EULA not Checked Error
      else
        setState(() {
          _eulaCondition = SizedBox(height: 0);
        });
      return 0;
    }
    // Input Data passed the required Conditions
    else {
      // Remove EULA not Checked Error
      setState(() {
        _eulaCondition = SizedBox(height: 0);
      });
      Map<String, String> body = {
        'firstName': _firstName.text,
        'lastName': _lastName.text,
        'phone': _phone.text,
        'mail': _email.text,
        'pass': _password.text,
        'fireBaseId': firebaseToken,
        'govern': selectedGovernment
      };
      // Disable Register Button
      setState(() {
        _loading = true;
      });

      // Register The User from on Server
      Response result = await Api.post("signing/passengers/register", body);
      // If User's info is correct
      if (result.statusCode == 200) {
        Provider.of<AuthProvider>(context, listen: false)
            .logIn(result.headers['x-login-token']);
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/homescreen');
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
    _firstName.dispose();
    _firstNameNode.dispose();
    _lastName.dispose();
    _lastNameNode.dispose();
    _email.dispose();
    _emailNode.dispose();
    _phone.dispose();
    _phoneNode.dispose();
    _password.dispose();
    _passwordNode.dispose();
    _confirmPasswordNode.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // الشروط والقوانين
    ThemeData theme = Theme.of(context);
    Color purple = theme.primaryColor;
    TextTheme textTheme = theme.textTheme;
    final String firebaseToken =
        Provider.of<AuthProvider>(context, listen: false).fbToken;
    TapGestureRecognizer tapRecognizer = TapGestureRecognizer()
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
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          setState(() {
            _nameFocused = false;
          });
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  'assets/images/register.png',
                  colorBlendMode: BlendMode.overlay,
                  // color: purple,
                ),

                Stack(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // First Name
                          Expanded(
                            child: TextFormField(
                              onEditingComplete: () {
                                _firstNameNode.unfocus();
                                FocusScope.of(context)
                                    .requestFocus(_lastNameNode);
                              },
                              onChanged: (value) {
                                if (value.endsWith(" ")) {
                                  _firstNameNode.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(_lastNameNode);
                                }
                              },
                              focusNode: _firstNameNode,
                              keyboardType: TextInputType.text,
                              controller: _firstName,
                              scrollPadding: EdgeInsets.all(0),
                              inputFormatters: [
                                WhitelistingTextInputFormatter(
                                    RegExp('[أ-ي \\-أ-ي]+\$')),
                                LengthLimitingTextInputFormatter(10)
                              ],
                              validator: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    _nameError = true;
                                  });
                                  return 'رجاءً، ادخل اسمك الاول.';
                                }
                                setState(() {
                                  _nameError = false;
                                });
                                return null;
                                // if(value.)
                              },
                              cursorColor: purple,
                              onTap: () => setState(() {
                                _nameFocused = true;
                              }),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                prefixIcon: Icon(Icons.account_circle),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                labelStyle: theme.textTheme.bodyText1
                                    .copyWith(color: Colors.grey),
                                labelText: 'الأسم الأول',
                              ),
                            ),
                          ),

                          SizedBox(height: 10),

                          //Last Name
                          Expanded(
                            child: TextFormField(
                              onEditingComplete: () {
                                _lastNameNode.unfocus();
                                FocusScope.of(context).requestFocus(_phoneNode);
                              },
                              keyboardType: TextInputType.text,
                              controller: _lastName,
                              focusNode: _lastNameNode,
                              inputFormatters: [
                                WhitelistingTextInputFormatter(
                                    RegExp('[أ-ي\\-أ-ي]+\$')),
                                LengthLimitingTextInputFormatter(10)
                              ],
                              cursorColor: purple,
                              onTap: () => setState(() {
                                _nameFocused = true;
                              }),
                              validator: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    _nameError = true;
                                  });
                                  return 'رجاءً، ادخل اسمك الاخير.';
                                }
                                if (value.length < 3) {
                                  setState(() {
                                    _nameError = true;
                                  });
                                  return 'ادخل اسمك بشكل صحيح';
                                }

                                setState(() {
                                  _nameError = false;
                                });
                                return null;
                                // if(value.)
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                labelStyle: theme.textTheme.bodyText1
                                    .copyWith(color: Colors.grey),
                                labelText: 'الأسم الأخير',
                              ),
                            ),
                          ),
                        ]),
                    Container(
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: _nameError
                                      ? Colors.red
                                      : _nameFocused
                                          ? purple
                                          : Colors.black26)),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),

                // Phone
                TextFormField(
                  onEditingComplete: () {
                    _phoneNode.unfocus();
                    FocusScope.of(context).requestFocus(_emailNode);
                  },
                  keyboardType: TextInputType.phone,
                  controller: _phone,
                  focusNode: _phoneNode,
                  scrollPadding: EdgeInsets.all(0),
                  inputFormatters: [
                    BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                    WhitelistingTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11)
                  ],
                  validator: (value) {
                    if (phone.hasMatch(value)) {
                      // Wrong number of numbers.
                      if (value.length != 11)
                        return 'تأكد من ادخال رقمك بشكل صحيح.';
                      // Everything is good
                      if (phoneEgypt.hasMatch(value)) return null;
                      // Wrong Phone Number Format
                      return 'هذه الشركه غير مسجلة لدينا.';
                    }
                    return 'تأكد من ادخال رقمك بشكل صحيح.';
                  },
                  onTap: () => setState(() {
                    _nameFocused = false;
                  }),
                  cursorColor: purple,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: Icon(
                      Icons.phone,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(width: 1.5, color: purple)),
                    labelStyle:
                        theme.textTheme.bodyText1.copyWith(color: Colors.grey),
                    labelText: 'رقم الهاتف',
                  ),
                ),

                SizedBox(height: 10),

                // Email
                TextFormField(
                  onEditingComplete: () {
                    _emailNode.unfocus();
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  focusNode: _emailNode,
                  scrollPadding: EdgeInsets.all(0),
                  onTap: () => setState(() {
                    _nameFocused = false;
                  }),
                  validator: (value) {
                    if (!email.hasMatch(value)) {
                      return "تأكد من ادخال بياناتك بشكل صحيح";
                    }
                    // User Entered a valid mail
                    else {
                      return null;
                    }
                  },
                  inputFormatters: [
                    BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                  ],
                  cursorColor: purple,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: Icon(
                      Icons.mail,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(width: 1.5, color: purple)),
                    labelStyle:
                        theme.textTheme.bodyText1.copyWith(color: Colors.grey),
                    labelText: 'البريد الالكتروني',
                  ),
                ),

                SizedBox(height: 10),

                // Password
                TextFormField(
                  onEditingComplete: () {
                    _passwordNode.unfocus();
                    FocusScope.of(context).requestFocus(_confirmPasswordNode);
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: _password,
                  focusNode: _passwordNode,
                  scrollPadding: EdgeInsets.all(0),
                  onTap: () => setState(() {
                    _nameFocused = false;
                  }),
                  inputFormatters: [
                    BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                    LengthLimitingTextInputFormatter(16)
                  ],
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'ادخل كلمة المرور';
                    }
                    if (value.length > 18 || value.length < 8)
                      return "تاكد من ادخالك كلمة المرور بشكل صحيح";
                    password = value;
                    return null;
                  },
                  obscureText: _hiddenPassword,
                  cursorColor: purple,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(
                            _hiddenPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black26),
                        onPressed: () => setState(() {
                              _hiddenPassword = !_hiddenPassword;
                            })),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(width: 1.5, color: purple)),
                    labelStyle:
                        theme.textTheme.bodyText1.copyWith(color: Colors.grey),
                    labelText: 'كلمة المرور',
                  ),
                ),

                SizedBox(height: 10),

                // Password
                TextFormField(
                  onEditingComplete: () {
                    _confirmPasswordNode.unfocus();
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: _confirmPassword,
                  onTap: () => setState(() {
                    _nameFocused = false;
                  }),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'ادخل كلمة المرور';
                    }
                    if (value.length > 18 || value.length < 8)
                      return "تاكد من ادخالك كلمة المرور بشكل صحيح";
                    if (value != password)
                      return "تأكد من ادخالك نفس كلمة المرور";
                    return null;
                  },
                  focusNode: _confirmPasswordNode,
                  scrollPadding: EdgeInsets.all(0),
                  inputFormatters: [
                    BlacklistingTextInputFormatter(RegExp('[\\-|\\ ]')),
                    LengthLimitingTextInputFormatter(16)
                  ],
                  cursorColor: purple,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: Icon(
                      Icons.lock,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(width: 1.5, color: purple)),
                    labelStyle:
                        theme.textTheme.bodyText1.copyWith(color: Colors.grey),
                    labelText: 'تأكيد كلمة المرور',
                  ),
                ),
                SizedBox(height: 10),

                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.black26,
                      )),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: DropdownButton(
                    underline: SizedBox(),
                    hint: Row(
                      children: <Widget>[
                        Icon(Icons.location_city, color: Colors.grey),
                        SizedBox(width: 8),
                        Text("اختار محافظتك",
                            style: TextStyle(color: Colors.grey))
                      ],
                    ),
                    value: selectedGovernment,
                    items: goverments
                        .map((element) => DropdownMenuItem(
                            value: element,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.location_city, color: Colors.grey),
                                SizedBox(width: 8),
                                Text(element)
                              ],
                            )))
                        .toList(),
                    onChanged: (_) => setState(() => selectedGovernment = _),
                    isExpanded: true,
                  ),
                ),

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
                            text: "اوافق على جميع ",
                            style: textTheme.subtitle2
                                .copyWith(color: Colors.black54)),
                        TextSpan(
                            recognizer: tapRecognizer,
                            text: "الشروط و القوانين",
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
                              var result = await register(firebaseToken);
                              if (result == 2)
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("تعذر الوصول للانترنت.")));
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 5),
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
      ),
    );
  }
}
