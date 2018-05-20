import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/core/routes.dart';
import 'package:rafpored/model/event.dart';

class DetailsBody extends StatefulWidget {

  final Event _event;

  DetailsBody(this._event);

  @override
  _DetailsBodyState createState() => _DetailsBodyState(_event);
}

class _DetailsBodyState extends State<DetailsBody> {

  final Event _event;

  _DetailsBodyState(this._event);

  @override
  Widget build(BuildContext context) =>
      Container(
        child: Container(
          margin: EdgeInsets.all(Res.Dimens.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(_event.subject, style: Res.TextStyles.textFull)),
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(_event.professor, style: Res.TextStyles.textFaded)),
              Container(height: Res.Dimens.dividerSmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: Res.Dimens.smallIconSize,
                        color: Res.Colors.smallIcon,
                      ),
                      Container(width: Res.Dimens.smallIconSpacing),
                      Text(
                          _event.getClassrooms(),
                          style: Res.TextStyles.textFaded
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                          Icons.calendar_today,
                          size: Res.Dimens.smallIconSize,
                          color: Res.Colors.smallIcon
                      ),
                      Container(width: Res.Dimens.smallIconSpacing),
                      Text(
                          _event.getDateFrom()["date"],
                          style: Res.TextStyles.textFaded
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                          Icons.access_time,
                          size: Res.Dimens.smallIconSize,
                          color: Res.Colors.smallIcon
                      ),
                      Container(width: Res.Dimens.smallIconSpacing),
                      Text(
                          _event.getDateFrom()["time"],
                          style: Res.TextStyles.textFaded
                      ),
                    ],
                  ),
                ],
              ),
              Container(height: Res.Dimens.dividerSmall),
              Text(
                  _event.notes,
                  style: Res.TextStyles.textFaded
              ),
            ],
          ),
        ),
      );
}