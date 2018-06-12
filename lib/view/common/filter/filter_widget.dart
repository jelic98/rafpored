import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/controller/filter/filter.dart';
import 'package:rafpored/model/event.dart';
import 'package:rafpored/model/filter_criteria.dart';
import 'package:rafpored/view/common/fixed_dropdown.dart';

class FilterWidget extends StatefulWidget {

  final _FilterWidgetState _state;

  FilterWidget(Filter filter) :
        _state = _FilterWidgetState(filter);

  @override
  _FilterWidgetState createState() => _state;
}

class _FilterWidgetState extends State<FilterWidget> {

  final Filter _filter;

  FilterCriteria _criteria;

  _FilterWidgetState(this._filter);

  @override
  void initState() {
    super.initState();
    _filter.loadCriteria(_criteria = FilterCriteria());
  }

  @override
  Widget build(BuildContext context) =>
      Container(
        padding: EdgeInsets.only(
            left: Res.Dimens.filtersPadding,
            right: Res.Dimens.filtersPadding,
        ),
        child: SingleChildScrollView(
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
                items: _filter.extractor.eventTypes.map((type) => DropdownMenuItem<EventType>(
                  value: type,
                  child: Text(
                      type.name,
                      style: Res.TextStyles.inputText,
                      overflow: TextOverflow.ellipsis
                  ),
                )).toList(),
                onChanged: (type) => _criteria.setEventType(type, _setCriteria),
              ),
              FixedDropdownButton<String>(
                hint: Text(
                    Res.Strings.inputSubject,
                    style: Res.TextStyles.inputHint,
                    overflow: TextOverflow.ellipsis
                ),
                value: _criteria.subject,
                items: _filter.extractor.subjects.map((subject) => DropdownMenuItem<String>(
                  value: subject,
                  child: Text(
                      subject,
                      style: Res.TextStyles.inputText,
                      overflow: TextOverflow.ellipsis
                  ),
                )).toList(),
                onChanged: (subject) => _criteria.setSubject(subject, _setCriteria),
              ),
              FixedDropdownButton<String>(
                hint: Text(
                    Res.Strings.inputProfessor,
                    style: Res.TextStyles.inputHint,
                    overflow: TextOverflow.ellipsis
                ),
                value: _criteria.professor,
                items: _filter.extractor.professors.map((professor) => DropdownMenuItem<String>(
                  value: professor,
                  child: Text(
                      professor,
                      style: Res.TextStyles.inputText,
                      overflow: TextOverflow.ellipsis
                  ),
                )).toList(),
                onChanged: (professor) => _criteria.setProfessor(professor, _setCriteria),
              ),
              FixedDropdownButton<String>(
                hint: Text(
                    Res.Strings.inputClassroom,
                    style: Res.TextStyles.inputHint,
                    overflow: TextOverflow.ellipsis
                ),
                value: _criteria.classroom,
                items: _filter.extractor.classrooms.map((classroom) => DropdownMenuItem<String>(
                  value: classroom,
                  child: Text(
                      classroom,
                      style: Res.TextStyles.inputText,
                      overflow: TextOverflow.ellipsis
                  ),
                )).toList(),
                onChanged: (classroom) => _criteria.setClassroom(classroom, _setCriteria),
              ),
              FixedDropdownButton<String>(
                hint: Text(
                    Res.Strings.inputGroup,
                    style: Res.TextStyles.inputHint,
                    overflow: TextOverflow.ellipsis
                ),
                value: _criteria.group,
                items: _filter.extractor.groups.map((group) => DropdownMenuItem<String>(
                  value: group,
                  child: Text(
                      group,
                      style: Res.TextStyles.inputText,
                      overflow: TextOverflow.ellipsis
                  ),
                )).toList(),
                onChanged: (group) => _criteria.setGroup(group, _setCriteria),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: Res.Dimens.filtersPadding,
                  bottom: Res.Dimens.filtersPadding,
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(Res.Dimens.buttonRadius),
                  elevation: Res.Dimens.buttonElevation,
                  child: MaterialButton(
                      onPressed: () => _filter.resetCriteria(context, true),
                      color: Res.Colors.primaryDark,
                      child: Text(Res.Strings.actionReset, style: Res.TextStyles.textFull)
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  _setCriteria(FilterCriteria criteria) {
    setState(() {
      _criteria = criteria;
    });

    _filter.saveCriteria(_criteria);
  }
}