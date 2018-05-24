import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rafpored/model/event.dart';
import 'package:rafpored/view/common/filter_listener.dart';
import 'package:rafpored/model/filter_criteria.dart';
import 'package:rafpored/view/common/fixed_dropdown.dart';

class Filter extends StatefulWidget {

  final FilterListener listener;

  List<EventType> eventTypes;
  List<String> subjects;
  List<String> professors;
  List<String> classrooms;
  List<String> groups;

  Filter(this.listener);

  @override
  _FilterState createState() => _FilterState(this);
}

class _FilterState extends State<Filter> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final Filter filter;

  FilterCriteria _criteria;

  _FilterState(this.filter) : _criteria = FilterCriteria();

  @override
  void initState() {
    super.initState();

    _prefs.then((prefs) => _loadFilters(prefs, _criteria));
  }

  @override
  Widget build(BuildContext context) =>
      Container(
        padding: EdgeInsets.only(left: Res.Dimens.filtersPadding, right: Res.Dimens.filtersPadding, bottom: Res.Dimens.filtersPadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FixedDropdownButton<EventType>(
              hint: Text(
                  Res.Strings.inputEventType,
                  style: Res.TextStyles.inputHint,
                  overflow: TextOverflow.ellipsis
              ),
              value: _criteria.eventType,
              items: filter.eventTypes.map((type) => DropdownMenuItem<EventType>(
                value: type,
                child: Text(
                    type.name,
                    style: Res.TextStyles.inputText,
                    overflow: TextOverflow.ellipsis
                ),
              )).toList(),
              onChanged: (type) => _criteria.setEventType(type, _filterList),
            ),
            FixedDropdownButton<String>(
              hint: Text(
                  Res.Strings.inputSubject,
                  style: Res.TextStyles.inputHint,
                  overflow: TextOverflow.ellipsis
              ),
              value: _criteria.subject,
              items: filter.subjects.map((subject) => DropdownMenuItem<String>(
                value: subject,
                child: Text(
                    subject,
                    style: Res.TextStyles.inputText,
                    overflow: TextOverflow.ellipsis
                ),
              )).toList(),
              onChanged: (subject) => _criteria.setSubject(subject, _filterList),
            ),
            FixedDropdownButton<String>(
              hint: Text(
                  Res.Strings.inputProfessor,
                  style: Res.TextStyles.inputHint,
                  overflow: TextOverflow.ellipsis
              ),
              value: _criteria.professor,
              items: filter.professors.map((professor) => DropdownMenuItem<String>(
                value: professor,
                child: Text(
                    professor,
                    style: Res.TextStyles.inputText,
                    overflow: TextOverflow.ellipsis
                ),
              )).toList(),
              onChanged: (professor) => _criteria.setProfessor(professor, _filterList),
            ),
            FixedDropdownButton<String>(
              hint: Text(
                  Res.Strings.inputClassroom,
                  style: Res.TextStyles.inputHint,
                  overflow: TextOverflow.ellipsis
              ),
              value: _criteria.classroom,
              items: filter.classrooms.map((classroom) => DropdownMenuItem<String>(
                value: classroom,
                child: Text(
                    classroom,
                    style: Res.TextStyles.inputText,
                    overflow: TextOverflow.ellipsis
                ),
              )).toList(),
              onChanged: (classroom) => _criteria.setClassroom(classroom, _filterList),
            ),
            FixedDropdownButton<String>(
              hint: Text(
                  Res.Strings.inputGroup,
                  style: Res.TextStyles.inputHint,
                  overflow: TextOverflow.ellipsis
              ),
              value: _criteria.group,
              items: filter.groups.map((group) => DropdownMenuItem<String>(
                value: group,
                child: Text(
                    group,
                    style: Res.TextStyles.inputText,
                    overflow: TextOverflow.ellipsis
                ),
              )).toList(),
              onChanged: (group) => _criteria.setGroup(group, _filterList),
            ),
            Container(
              alignment: Alignment.center,
              child: Material(
                borderRadius: BorderRadius.circular(Res.Dimens.buttonRadius),
                elevation: Res.Dimens.buttonElevation,
                child: MaterialButton(
                    onPressed: () => _resetFilters(),
                    color: Res.Colors.primaryDark,
                    child: Text(Res.Strings.actionReset, style: Res.TextStyles.textFull)
                ),
              ),
            ),
          ],
        ),
      );

  _resetFilters() {
    // todo dispose filter and create new one instead of popping
    Navigator.pop(context);

    _filterList(FilterCriteria());
  }

  _filterList(FilterCriteria criteria) {
    setState(() {
      _criteria = criteria;
    });

    _prefs.then((prefs) => _saveFilters(prefs, criteria));

    filter.listener.onFiltered(_criteria);
  }

  _loadFilters(SharedPreferences prefs, FilterCriteria criteria) {
    String savedType = prefs.getString("eventType");

    for(EventType type in [EventType.lecture, EventType.colloquium, EventType.exam]) {
      if(savedType == type.name) {
        criteria.eventType = type;
        break;
      }
    }

    criteria.subject = prefs.getString("subject") ?? null;
    criteria.professor = prefs.getString("professor") ?? null;
    criteria.classroom = prefs.getString("classroom") ?? null;
    criteria.group = prefs.getString("group") ?? null;

    setState(() => _criteria = criteria);
  }

  _saveFilters(SharedPreferences prefs, FilterCriteria criteria) {
    prefs.setString("eventType", criteria.eventType?.name);
    prefs.setString("subject", criteria.subject);
    prefs.setString("professor", criteria.professor);
    prefs.setString("classroom", criteria.classroom);
    prefs.setString("group", criteria.group);
  }
}