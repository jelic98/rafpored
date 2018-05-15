import 'package:flutter/material.dart';
import 'package:rafroid/Theme.dart' as Theme;
import 'package:rafroid/model/Subject.dart';

class SubjectRow extends StatelessWidget {

  final Subject subject;

  SubjectRow(this.subject);

  @override
  Widget build(BuildContext context) {
    final card = new Container(
      decoration: new BoxDecoration(
        color: subject.getColor(),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(Theme.Dimens.cardRadius)
      ),
      child: new Container(
        margin: const EdgeInsets.all(Theme.Dimens.cardPadding),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new FittedBox(
              fit: BoxFit.scaleDown,
              child: new Text(subject.name, style: Theme.TextStyles.textFull)),
            new FittedBox(
              fit: BoxFit.scaleDown,
              child: new Text(subject.professor, style: Theme.TextStyles.textFaded)),
            new Container(
              color: Theme.Colors.divider,
              width: Theme.Dimens.dividerWidth,
              height: Theme.Dimens.dividerHeight,
              margin: const EdgeInsets.symmetric(vertical: Theme.Dimens.dividerSpacing)
            ),
            new Row(
			        mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
				        new Row(
              	  children: <Widget>[
              	    new Icon(
    	                Icons.location_on,
       	              size: Theme.Dimens.smallIconSize,
                      color: Theme.Colors.smallIcon,
                	  ),
					          new Container(width: Theme.Dimens.smallIconSpacing),
                    new Text(
                  	  subject.getClassrooms(),
                      style: Theme.TextStyles.textFaded
                    ),
				          ],
                ),
				        new Row(
              	  children: <Widget>[
            		    new Icon(
                        Icons.calendar_today,
                        size: Theme.Dimens.smallIconSize,
                        color: Theme.Colors.smallIcon
                    ),
                    new Container(width: Theme.Dimens.smallIconSpacing),
                    new Text(
                      subject.getDateFrom()["date"],
                      style: Theme.TextStyles.textFaded
                    ),
				          ],
                ),
				        new Row(
              	  children: <Widget>[
				            new Icon(
                        Icons.access_time,
                        size: Theme.Dimens.smallIconSize,
                        color: Theme.Colors.smallIcon
                    ),
                    new Container(width: Theme.Dimens.smallIconSpacing),
                    new Text(
                      subject.getDateFrom()["time"],
                      style: Theme.TextStyles.textFaded
                    ),
				          ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return new Container(
      margin: const EdgeInsets.only(top: Theme.Dimens.cardMargin, bottom: Theme.Dimens.cardMargin),
      child: new FlatButton(
        onPressed: null,
        child: card
      ),
    );
  }
 }
