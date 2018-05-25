import 'package:rafpored/view/common/filter_widget.dart';
import 'package:rafpored/model/filter_criteria.dart';

abstract class FilterListener {

  onFiltered(FilterCriteria criteria, Function setFilterVisible);
}