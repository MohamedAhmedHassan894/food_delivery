import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../ui_views/onboardinglayoutview.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: onBordingBody(),
    );
  }

  Widget onBordingBody() => Container(
    child: OnBoardingLayoutView(),
  );
}
