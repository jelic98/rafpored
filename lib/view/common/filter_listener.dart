import 'package:rafpored/view/common/filter.dart';
import 'package:rafpored/model/filter_criteria.dart';

abstract class FilterListener {

  onFiltered(FilterCriteria criteria);
  onFilterShown(Filter filter);
}