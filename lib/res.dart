import 'package:flutter/material.dart';

class Colors {
  
  const Colors();

  static const Color barTitle = const Color(0xFFFFFFFF);
  static const Color barIcon = const Color(0xFFFFFFFF);
  static const Color barGradientStart = const Color(0xFF0984E3);
  static const Color barGradientEnd = const Color(0xFF74B9FF);

  static const Color button = const Color(0xFF0984E3);

  static const Color eventExam = const Color(0xFFEB3B5A);
  static const Color eventColloquium = const Color(0xFFFA983A);
  static const Color eventLecture = const Color(0xFF6A89CC);

  static const Color pageBackground = const Color(0xFFFFFFFF);
  
  static const Color textFull = const Color(0xFFFFFFFF);
  static const Color textFullDark = const Color(0x99000000);
  static const Color textFaded = const Color(0x99FFFFFF);

  static const Color logoBorder = const Color(0xFFFFFFFF);

  static const Color inputFill = const Color(0x55FFFFFF);
  static const Color inputText = const Color(0xFF000000);
  static const Color inputHint = const Color(0x99000000);

  static const Color listPlaceholder = const Color(0x99000000);

  static const Color snackbar = const Color(0xFF0984E3);
  static const Color snackbarText = const Color(0xFFFFFFFF);

  static const Color calendarHeader = const Color(0xFFF1F2F6);
  static const Color calendarToday = const Color(0xFF74B9FF);

  static const Color smallIcon = const Color(0x99FFFFFF);
}

class Dimens {

  const Dimens();

  static const barHeight = 60.0;

  static const bgBlur = 4.0;

  static const elevation = 8.0;

  static const formPadding = 32.0;

  static const logoSize = 110.0;
  static const logoPadding = 5.0;

  static const inputRadius = 30.0;
  static const inputPadding = EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0);

  static const buttonRadius = 30.0;
  static const buttonPadding = EdgeInsets.all(10.0);

  static const listPadding = 8.0;

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

  static const TextStyle textFullDark = const TextStyle(
      color: Colors.textFullDark,
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

  static const TextStyle inputText = const TextStyle(
      color: Colors.inputText,
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

  static const TextStyle listPlaceholder = const TextStyle(
      color: Colors.listPlaceholder,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 18.0
  );

  static const TextStyle snackbar = const TextStyle(
      color: Colors.snackbarText,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 14.0
  );
}