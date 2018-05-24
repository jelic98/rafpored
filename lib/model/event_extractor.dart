import 'package:rafpored/model/event.dart';

class EventExtractor {

  List<Event> _events;

  EventExtractor(this._events);

  List<String> getGroups() {
    List<String> groups = List<String>();

    for(Event event in _events) {
      for(String group in event.groups) {
        if(!groups.contains(group)) {
          groups.add(group);
        }
      }
    }

    return groups;
  }

  List<String> getClassrooms() {
    List<String> classrooms = List<String>();

    for(Event event in _events) {
      if(!classrooms.contains(event.classroom)) {
        classrooms.add(event.classroom);
      }
    }

    return classrooms;
  }

  List<String> getProfessors() {
    List<String> professors = List<String>();

    for(Event event in _events) {
      if(!professors.contains(event.professor)) {
        professors.add(event.professor);
      }
    }

    return professors;
  }

  List<String> getSubjects() {
    List<String> subjects = List<String>();

    for(Event event in _events) {
      if(!subjects.contains(event.subject)) {
        subjects.add(event.subject);
      }
    }

    return subjects;
  }

  List<EventType> getEventTypes() {
    List<EventType> types = List<EventType>();

    for(Event event in _events) {
      if(!types.contains(event.type)) {
        types.add(event.type);
      }
    }

    return types;
  }
}