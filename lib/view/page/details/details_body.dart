import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
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
    Expanded(
      child: Container(
        margin: EdgeInsets.all(Res.Dimens.cardPadding),
        child: Hero(
          tag: "hero-event-" + _event.id,
          child: Material(
            color: _event.type.color,
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
                          _event.classroom,
                          style: Res.TextStyles.textFaded,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.event,
                          size: Res.Dimens.smallIconSize,
                          color: Res.Colors.smallIcon,
                        ),
                        Container(width: Res.Dimens.smallIconSpacing),
                        Text(
                          _event.getDate(),
                          style: Res.TextStyles.textFaded,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: Res.Dimens.smallIconSize,
                          color: Res.Colors.smallIcon,
                        ),
                        Container(width: Res.Dimens.smallIconSpacing),
                        Text(
                          _event.getTimeStart(),
                          style: Res.TextStyles.textFaded,
                        ),
                      ],
                    ),
                  ],
                ),
                Container(height: Res.Dimens.dividerSmall),
                Text(
                  _event.notes,
                  style: Res.TextStyles.textFaded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
}