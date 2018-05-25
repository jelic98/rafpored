import 'package:rafpored/model/event.dart';

class EventExtractor {

  List<EventType> eventTypes = List<EventType>();
  List<String> subjects = List<String>();
  List<String> professors = List<String>();
  List<String> classrooms = List<String>();
  List<String> groups = List<String>();

  EventExtractor(List<Event> events) {
    for(Event event in events) {
      if(!eventTypes.contains(event.type)) {
        eventTypes.add(event.type);
      }

      if(!subjects.contains(event.subject)) {
        subjects.add(event.subject);
      }

      if(!professors.contains(event.professor)) {
        professors.add(event.professor);
      }

      if(!classrooms.contains(event.classroom)) {
        classrooms.add(event.classroom);
      }

      for(String group in event.groups) {
        if(!groups.contains(group)) {
          groups.add(group);
        }
      }
    }
  }
}