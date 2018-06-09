import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'small_calendar_pager.dart';
import 'small_calendar_pager_controller.dart';

typedef void JumpToPageCallback(int index);

typedef void AnimateToPageCallback(int index, Duration duration, Curve curve);

typedef int GetPageCallback();

/// This object if for communication between [SmallCalendarPager] and [SmallCalendarPagerController].
@immutable
class PagerPosition {
  PagerPosition({
    @required this.jumpToPage,
    @required this.animateToPage,
    @required this.getPage,
  })  : assert(jumpToPage != null),
        assert(animateToPage != null),
        assert(getPage != null);

  /// Tells [SmallCalendarPager] to jump to a specified page.
  final JumpToPageCallback jumpToPage;

  /// Tells [SmallCalendarPager] to animate to a specified page.
  final AnimateToPageCallback animateToPage;

  /// Request the current page from the [SmallCalendarPager].
  final GetPageCallback getPage;
}
