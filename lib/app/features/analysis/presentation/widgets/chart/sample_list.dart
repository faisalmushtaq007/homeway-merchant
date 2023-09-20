import 'package:flutter/foundation.dart';
import 'package:homemakers_merchant/app/features/analysis/presentation/widgets/chart/stacked_bar_100_chart.dart';
import 'package:homemakers_merchant/app/features/analysis/presentation/widgets/chart/stacked_column_100_chart.dart';



/// Contains the output widget of sample
/// appropriate key and output widget mapped
Map<String, Function> getSampleWidget() {
  return <String, Function>{
    // cartesian charts

    'stacked_bar_100_chart': (Key key) => StackedBar100Chart(key),
    'stacked_column_100_chart': (Key key) => StackedColumn100Chart(key),
  };
}
