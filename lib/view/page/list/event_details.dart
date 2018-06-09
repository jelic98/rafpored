import 'package:flutter/material.dart';
import 'package:rafpored/core/res.dart' as Res;
import 'package:rafpored/view/page/details/details_body.dart';

class EventDetails extends DetailsBodyState {
  
  EventDetails(item) : super(item);

  @override
  Widget build(BuildContext context) =>
      Expanded(
        child: Container(
          child: Hero(
            tag: "hero-event-" + item.id,
            child: Material(
              color: item.type.color,
              child: Padding(
                padding: EdgeInsets.all(Res.Dimens.cardPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(item.subject, style: Res.TextStyles.textFull),
                    ),
                    Text(item.professor, style: Res.TextStyles.textFaded),
                    Container(height: Res.Dimens.dividerSmall),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.flag,
                              size: Res.Dimens.smallIconSize,
                              color: Res.Colors.smallIcon,
                            ),
                            Container(width: Res.Dimens.smallIconSpacing),
                            Text(
                              item.type.name,
                              style: Res.TextStyles.textFaded,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: Res.Dimens.smallIconSize,
                              color: Res.Colors.smallIcon,
                            ),
                            Container(width: Res.Dimens.smallIconSpacing),
                            Text(
                              item.classroom,
                              style: Res.TextStyles.textFaded,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.event,
                              size: Res.Dimens.smallIconSize,
                              color: Res.Colors.smallIcon,
                            ),
                            Container(width: Res.Dimens.smallIconSpacing),
                            Text(
                              item.getDate(),
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
                              "${item.getTimeStart()} - ${item.getTimeEnd()}",
                              style: Res.TextStyles.textFaded,
                            ),
                          ],
                        ),
                      ],
                    ),
                    (item.getGroups().isNotEmpty) ?
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.group,
                          size: Res.Dimens.smallIconSize,
                          color: Res.Colors.smallIcon,
                        ),
                        Container(width: Res.Dimens.smallIconSpacing),
                        Text(
                          item.getGroups(),
                          style: Res.TextStyles.textFaded,
                        ),
                      ],
                    ) : Container(height: 0.0),
                    Container(height: Res.Dimens.dividerSmall),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(item.notes, style: Res.TextStyles.textFaded),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}