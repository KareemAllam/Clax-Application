import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingButton extends StatefulWidget {
  final String label;

  final Function handleTap;
  const LoadingButton({Key key, @required this.handleTap, this.label})
      : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool sending = false;
  @override
  Widget build(BuildContext context) {
    return !sending
        ? Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2,
                vertical: 40),
            child: RaisedButton(
                elevation: 1,
                highlightElevation: 1,
                shape: StadiumBorder(),
                onPressed: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());

                  setState(() {
                    sending = true;
                  });
                  int result = await widget.handleTap();
                  if (result == 200)
                    Navigator.pop(context);
                  else {
                    setState(() {
                      sending = false;
                    });
                    if (result == 404)
                      Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "تعذر الوصول للإنترنت. تأكد من اتصالك بالإنترنت و حاول مره اخرى.",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.white))));
                  }
                },
                color: Theme.of(context).primaryColor,
                child: Text(
                  widget.label,
                  strutStyle: StrutStyle(forceStrutHeight: true),
                  style: Theme.of(context).textTheme.button.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
          )
        : Container(
            margin: EdgeInsets.only(top: 10),
            child: SpinKitThreeBounce(
              size: 20,
              color: Theme.of(context).primaryColor,
              duration: Duration(milliseconds: 2220),
            ));
  }
}
