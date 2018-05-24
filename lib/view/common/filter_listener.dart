import 'package:rafpored/view/common/filter.dart';
import 'package:rafpored/model/filter_criteria.dart';

abstract class FilterListener {

  onFilterShown(Filter filter);
  onFiltered(FilterCriteria criteria);
}