import 'package:flutter/material.dart';

class Colors {
  
  const Colors();

  static const Color barTitle = const Color(0xFFFFFFFF);
  static const Color barIcon = const Color(0xFFF5F6FA);
  static const Color barGradientStart = const Color(0xFF0984E3);
  static const Color barGradientEnd = const Color(0xFF74B9FF);

  static const Color button = const Color(0xFF0984E3);

  static const Color cardExam = const Color(0xFFEB3B5A);	
  static const Color cardColloquium = const Color(0xFFFA983A);	
  static const Color cardDefault = const Color(0xFF6A89CC);
  
  static const Color pageBackground = const Color(0xFFF5F6FA);
  
  static const Color textFull = const Color(0xFFFFFFFF);
  static const Color textFaded = const Color(0x99FFFFFF);

  static const Color inputHint = const Color(0x66000000);

  static const Color smallIcon = const Color(0x99FFFFFF);
}

class Dimens {

  const Dimens();

  static const barHeight = 60.0;

  static const elevation = 5.0;

  static const logoRadius = 48.0;

  static const formPadding = 32.0;

  static const inputRadius = 30.0;
  static const inputPadding = EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0);

  static const buttonRadius = 30.0;
  static const buttonPadding = EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0);

  static const listPadding = 8.0;
  static const listItemExtent = 160.0;

  static const cardRadius = 8.0;
  static const cardPadding = 16.0;
  static const cardMargin = 8.0;

  static const smallIconSize = 14.0;
  static const smallIconSpacing = 4.0;

  static const dividerSmall = 16.0;
  static const dividerBig = 32.0;
  static const dividerLarge = 72.0;
}

class TextStyles {

  const TextStyles();

  static const TextStyle barTitle = const TextStyle(
    color: Colors.barTitle,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 32.0
  );

  static const TextStyle textFull = const TextStyle(
    color: Colors.textFull,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 24.0
  );

  static const TextStyle textFaded = const TextStyle(
    color: Colors.textFaded,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w300,
    fontSize: 12.0
  );

  static const TextStyle inputHint = const TextStyle(
      color: Colors.inputHint,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 12.0
  );
}