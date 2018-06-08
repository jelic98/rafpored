import 'package:intl/intl.dart';
import 'package:rafpored/core/res.dart' as Res;

class News {

  static DateFormat _dateFormat = DateFormat("dd.MM");

  final String id;
  final String title;
  final String text;
  final int update;
  final DateTime date;

  News({
	  this.id,
	  this.title,
	  this.text,
    this.update,
	  this.date,
  });

  factory News.fromJson(Map<String, dynamic> response) =>
      News(
        id: response["id"],
        title: response["title"],
        text: response["text"],
        update: response["update"],
        date: DateTime.parse(response["date"]),
      );

  String getDate() => "${Res.Strings.days[DateFormat("E").format(date)]} ${_dateFormat.format(date)}";
}