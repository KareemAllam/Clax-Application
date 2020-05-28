// Flutter's Material Components
import 'package:flutter/material.dart';
// Components
import 'package:clax/screens/Settings/Components/FamilyPreview1.dart';
import 'package:clax/screens/Settings/Components/FamilyPreview2.dart';
// Widgets
import 'package:clax/widgets/appBar.dart';

class Family extends StatefulWidget {
  static const routeName = '/Family';

  @override
  _FamilyState createState() => _FamilyState();
}

class _FamilyState extends State<Family> with SingleTickerProviderStateMixin {
  Widget _myAnimatedWidget;
  AnimationController _controller;
  Animation<Offset> _offsetFloat;

  @override
  void initState() {
    super.initState();
    _myAnimatedWidget = FamilyPreview1(changeWidget);
    // Animation Configuration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _offsetFloat = Tween<Offset>(begin: Offset(1, 0.0), end: Offset(0, 0.0))
        .animate(_controller);
    _offsetFloat.addListener(() {
      setState(() {});
    });
  }

  void changeWidget() {
    setState(() {
      _myAnimatedWidget =
          SlideTransition(position: _offsetFloat, child: FamilyPreview2());
    });
    _controller.forward();
  }

  void dispose() {
    super.dispose();
    _controller.stop();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'العائلة'),
      body: Container(
        color: Colors.white,
        child: _myAnimatedWidget,
      ),
    );
  }
}
