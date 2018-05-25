import 'package:flutter/material.dart';

class Colors {

  const Colors();

  static const Color barTitle = const Color(0xFFFFFFFF);
  static const Color barIcon = const Color(0xFFFFFFFF);

  static const Color primaryLight = const Color(0xFF74B9FF);
  static const Color primaryDark = const Color(0xFF0984E3);

  static const Color eventExam = const Color(0xFFEB3B5A);
  static const Color eventColloquium = const Color(0xFFFA983A);
  static const Color eventLecture = const Color(0xFF2ED573);

  static const Color pageBackground = const Color(0xFFFFFFFF);

  static const Color textFull = const Color(0xFFFFFFFF);
  static const Color textFullDark = const Color(0x99000000);
  static const Color textFaded = const Color(0xBBFFFFFF);

  static const Color inputFill = const Color(0x55FFFFFF);
  static const Color inputText = const Color(0xFF000000);
  static const Color inputHint = const Color(0x66000000);

  static const Color listPlaceholder = const Color(0x99000000);

  static const Color snackbar = const Color(0xFF0984E3);
  static const Color snackbarText = const Color(0xFFFFFFFF);

  static const Color calendarHeader = const Color(0xFFF1F2F6);
  static const Color calendarToday = const Color(0xFF74B9FF);

  static const Color smallIcon = const Color(0x99FFFFFF);

  static const Color filterIcon = const Color(0xFF0984E3);
}

class Dimens {

  const Dimens();

  static const barHeight = 60.0;

  static const bgBlur = 4.0;

  static const barElevation = 10.0;
  static const cardElevation = 7.0;
  static const buttonElevation = 7.0;

  static const filtersPadding = 20.0;

  static const listPadding = 16.0;

  static const cardRadius = 8.0;
  static const cardPadding = 16.0;
  static const cardMargin = 16.0;

  static const buttonRadius = 8.0;

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
    fontSize: 14.0
  );

  static const TextStyle inputText = const TextStyle(
      color: Colors.inputText,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 16.0
  );

  static const TextStyle inputHint = const TextStyle(
      color: Colors.inputHint,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 16.0
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

class Strings {

  const Strings();

  static const String appName = "Rafpored";

  static const String inputEventType = "Tip";
  static const String inputSubject = "Predmet";
  static const String inputProfessor = "Profesor";
  static const String inputClassroom = "Učionica";
  static const String inputGroup = "Grupa";

  static const String actionReset = "Poništi";

  static const String alertWait = "Molimo sačekajte";
  static const String alertRequiredFields = "Popunite neophodna polja";
  static const String alertNoItems = "Nema stavki";
  static const String alertNoNotes = "Nema napomena";

  static const Map<String, String> months = {
    "01" : "Januar",
    "02" : "Februar",
    "03" : "Mart",
    "04" : "April",
    "05" : "Maj",
    "06" : "Jun",
    "07" : "Jul",
    "08" : "Avgust",
    "09" : "Septembar",
    "10" : "Oktobar",
    "11" : "Novembar",
    "12" : "Decembar",
  };

  static const Map<String, String> days = {
    "Mon" : "Pon",
    "Tue" : "Uto",
    "Wed" : "Sre",
    "Thu" : "Cet",
    "Fri" : "Pet",
    "Sat" : "Sub",
    "Sun" : "Ned",
  };
}