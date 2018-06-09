import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rafpored/view/common/calendar/src/data/all.dart';

import 'pager_position.dart';
import 'small_calendar_pager.dart';

/// A controller for [SmallCalendarPager].
class SmallCalendarPagerController {
  static const _default_initial_page = 100000;
  static const _default_numOf_pages_after_initial_page = 100000;

  /// Creates a small calendar pager controller.
  ///
  /// It converts all [DateTime]s to their internal representation ([Month]), and checks their validity.
  SmallCalendarPagerController._internal({
    @required DateTime initialMonth,
    DateTime minimumMonth,
    DateTime maximumMonth,
  })  : // Converts DateTime-s to Month-s
        _initMonth = new Month.fromDateTime(initialMonth),
        _minMonth = (minimumMonth != null)
            ? new Month.fromDateTime(minimumMonth)
            : null,
        _maxMonth = (maximumMonth != null)
            ? new Month.fromDateTime(maximumMonth)
            : null,
        // asserts
        assert(_initMonth != null) {
    // validates _minMonth
    if (_minMonth != null) {
      if (!(_minMonth.isBefore(_initMonth) || _minMonth == _initMonth)) {
        throw new ArgumentError(
          "Minimum month should be before or same month as initial month.",
        );
      }
    }

    // validates _maxMonth
    if (_maxMonth != null) {
      if (!(_maxMonth.isAfter(_initMonth) || _maxMonth == _initMonth)) {
        throw new ArgumentError(
          "Maximum month should be after or same month as initial month.",
        );
      }
    }
  }

  /// Creates a small calendar pager controller.
  ///
  /// If [initialMonth] is null, initial month will be the current month.
  /// [minimumMonth] and [maximumMonth] are inclusive.
  factory SmallCalendarPagerController({
    DateTime initialMonth,
    DateTime minimumMonth,
    DateTime maximumMonth,
  }) {
    initialMonth ??= new DateTime.now();

    return new SmallCalendarPagerController._internal(
      initialMonth: initialMonth,
      minimumMonth: minimumMonth,
      maximumMonth: maximumMonth,
    );
  }

  /// [PagerPosition] provided by [SmallCalendarPager] for controlling that pager.
  PagerPosition _pagerPosition;

  /// Internal representation of [initialMonth].
  final Month _initMonth;

  /// Internal representation of [minimumMonth].
  final Month _minMonth;

  /// Internal representation of [maximumMonth].
  final Month _maxMonth;

  /// Month that is displayed when the controlled [SmallCalendarPager] if first created.
  DateTime get initialMonth => _initMonth.toDateTime();

  /// Minimum month that the controlled [SmallCalendarPager] will be able to display (inclusive).
  ///
  /// If minimum month is null the [SmallCalendarPager] will be practically infinite (in months before initial month).
  DateTime get minimumMonth {
    if (_minMonth != null) {
      return _minMonth.toDateTime();
    }
    return null;
  }

  /// Maximum month that the controlled [SmallCalendarPager] will be able to display (inclusive).
  ///
  /// If maximum month is null the [SmallCalendarPager] will be practically infinite (in months after initial month).
  DateTime get maximumMonth {
    if (_maxMonth != null) {
      return _maxMonth.toDateTime();
    }
    return null;
  }

  /// The current displayed month in the controller [SmallCalendarPager].
  DateTime get displayedMonth {
    if (_pagerPosition == null) {
      return initialMonth;
    } else {
      return monthOf(_pagerPosition.getPage());
    }
  }

  /// Changes which month is displayed in the controlled [SmallCalendarPager].
  ///
  /// If [month] is outside bounds of the controller the highest/lowest month is displayed.
  void jumpToMonth(DateTime month) {
    assert(month != null);

    if (_pagerPosition == null) {
      print(
        "Cannot jump to month, becouse no SmallCallendarPagger is attached.",
      );
      return;
    }

    _pagerPosition.jumpToPage(
      pageOf(month),
    );
  }

  /// Animates the controlled [SmallCalendarPager] to the given [month].
  ///
  /// If [month] is outside bounds of the controller the highest/lowest month is animated to.
  void animateToMonth(
    DateTime month, {
    @required Duration duration,
    @required Curve curve,
  }) {
    assert(duration != null);
    assert(curve != null);

    if (_pagerPosition == null) {
      print(
        "Cannot animate to month, becouse no SmallCallendarPagger is attached.",
      );
      return;
    }

    _pagerPosition.animateToPage(
      pageOf(month),
      duration,
      curve,
    );
  }

  /// Registers the given [pagerPosition] with the controller.
  ///
  /// If a previous [pagerPosition] is registered, it is replaced with te new one.
  void attach(PagerPosition pagerPosition) {
    _pagerPosition = pagerPosition;
  }

  /// Unregisters the previously attached item.
  void detach() {
    _pagerPosition = null;
  }

  /// Index of the initial page that the controlled [SmallCalendarPager] should display.
  int get initialPage {
    if (minimumMonth == null) {
      return _default_initial_page;
    } else {
      return Month.getDifference(_minMonth, _initMonth);
    }
  }

  /// Number of pages that the controlled [SmallCalendarPager] should be able to display.
  int get numOfPages {
    int r = initialPage + 1;
    if (_maxMonth == null) {
      r += _default_numOf_pages_after_initial_page;
    } else {
      r += Month.getDifference(_initMonth, _maxMonth);
    }

    return r;
  }

  /// Returns a month that is displayed on the [page] (page index) of controlled [SmallCalendarPager].
  DateTime monthOf(int page) {
    if (minimumMonth == null) {
      int distanceFromInitialPage = page - initialPage;

      return _initMonth.add(distanceFromInitialPage).toDateTime();
    } else {
      return _minMonth.add(page).toDateTime();
    }
  }

  /// Returns index of the page that represents a specified [month] in the controlled [SmallCalendarPager].
  int pageOf(DateTime month) {
    int r;

    Month m = new Month.fromDateTime(month);
    if (m == _initMonth) {
      r = initialPage;
    } else if (minimumMonth == null) {
      r = initialPage + Month.getDifference(_initMonth, m);
    } else {
      r = Month.getDifference(_minMonth, m);
    }

    if (r < 0) {
      r = 0;
    } else if (r > numOfPages) {
      r = numOfPages - 1;
    }

    return r;
  }
}
