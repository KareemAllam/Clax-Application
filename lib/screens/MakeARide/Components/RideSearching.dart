import 'package:flutter/material.dart';

class RideSearching extends StatefulWidget {
  static const titleName = 'ابحث عن سائق';
  @override
  _RideSearchingState createState() => _RideSearchingState();
}

class _RideSearchingState extends State<RideSearching>
    with SingleTickerProviderStateMixin {
  AnimationController forwardAnimation;

  @override
  void initState() {
    forwardAnimation =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..addListener(() {
            if (mounted) {
              setState(() {});
            }
          })
          ..repeat();
    super.initState();
  }

  @override
  bool get mounted => super.mounted;

  @override
  void dispose() {
    forwardAnimation.stop();
    forwardAnimation.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RotationTransition(
              turns: CurvedAnimation(
                  parent: Tween(begin: 0.0, end: 1.0).animate(forwardAnimation),
                  curve: Curves.easeInOutBack),
              child: Image(
                image: AssetImage('assets/images/logo.png'),
                height: 200,
              ),
            ),
            SizedBox(height: 10),
            Text("جاري البحث عن سائق",
                style: Theme.of(context).textTheme.headline6),
            Text(
              "قد يستغرق البحث بضع دقائق",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.grey),
            )
          ]),
    );
  }
}
