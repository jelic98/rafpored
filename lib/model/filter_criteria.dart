import 'package:rafpored/model/event.dart';

class FilterCriteria {

  EventType eventType;
  String subject;
  String professor;
  String classroom;
  String group;

  setEventType(EventType eventType, Function callback) {
    this.eventType = eventType;
    callback(this);
  }

  setSubject(String subject, Function callback) {
    this.subject = subject;
    callback(this);
  }

  setProfessor(String professor, Function callback) {
    this.professor = professor;
    callback(this);
  }

  setClassroom(String classroom, Function callback) {
    this.classroom = classroom;
    callback(this);
  }

  setGroup(String group, Function callback) {
    this.group = group;
    callback(this);
  }
}