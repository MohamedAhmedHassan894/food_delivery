import 'package:flutter/cupertino.dart';
import '../data/constants.dart';

class Slider {
  final String sliderImageUrl;
  final String sliderHeading;
  final String sliderSubHeading;
  final String skipBtn;

  Slider(
      {@required this.sliderImageUrl,
        @required this.sliderHeading,
        @required this.sliderSubHeading,
        this.skipBtn});
}

final sliderArrayList = [
  Slider(
      sliderImageUrl: 'assets/images/slider_img_1.png',
      sliderHeading: Constants.SLIDER_HEADING_1,
      sliderSubHeading: Constants.SLIDER_DESC1,
      skipBtn: Constants.SKIP),
  Slider(
      sliderImageUrl: 'assets/images/slider_img_2.png',
      sliderHeading: Constants.SLIDER_HEADING_2,
      sliderSubHeading: Constants.SLIDER_DESC2,
      skipBtn: Constants.SKIP),
  Slider(
      sliderImageUrl: 'assets/images/slider_img_3.png',
      sliderHeading: Constants.SLIDER_HEADING_3,
      sliderSubHeading: Constants.SLIDER_DESC3,
      skipBtn: ""),
];
