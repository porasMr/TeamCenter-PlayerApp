import 'package:team_center/utils/cell_calender_package/src/components/days_row/measure_size.dart';
import 'package:flutter/cupertino.dart';

/// Controller to notify the height of cell gotten from [MeasureSize]
class CellHeightController extends ChangeNotifier {
  double? cellHeight;
  void onChanged(Size size) {
    if (cellHeight == null) {
      cellHeight = size.height;
      notifyListeners();
    }
  }
}
