import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

/// A controller class that manages the logic for the `WrapAndMore` widget.
/// The `WrapAndMoreController` extends GetX's GetxController to handle reactive state management.
class WrapAndMoreController extends ChangeNotifier {
  /// A flag to determine whether the count of children has been calculated.
  bool isCounted = false;

  /// A flag to determine whether the widget has been rendered.
  bool isRendered = false;

  /// The key associated with the row widget to measure its size.
  late GlobalKey rowKey;

  /// The size of a single child widget in the `Wrap`.
  Size _childSize = const Size(0, 0);

  /// A list that stores the area (width * height) of each child widget in the `Wrap`.
  List<double> _childrenArea = [];

  /// The total area of the `Wrap`.
  double areaWrap = 0.0;

  /// The number of child widgets to display within the `Wrap`.
  int showChildCount = 0;

  /// The maximum number of rows to show within the `Wrap`.
  int maxRowChild = 0;

  /// The spacing between children in the `Wrap`.
  double spacingChild = 0.0;

  /// The size of the overflow widget.
  Size overflowSize = const Size(0, 0);

  /// Setter for the child widget size.
  set childSize(Size? size) {
    if (size != null) {
      _childSize = size;
    }
  }

  /// Getter for the child widget size.
  Size get childSize => _childSize;

  /// Initializes the controller with necessary data for calculation.
  /// This method should be called before using the controller.
  void initData({
    required List<Widget> children,
    required GlobalKey key,
    required int maxRow,
    required double spacing,
  }) {
    rowKey = key;
    maxRowChild = maxRow;
    spacingChild = spacing;
    _childrenArea = List.generate(children.length, (index) => 0);
    //notifyListeners();
  }

  void onReady() {
    getSizeAndPosition();
    notifyListeners();
  }

  /// Retrieves the size and position of the row widget.
  /// This method is called when the widget is ready.
  void getSizeAndPosition() {
    isRendered = false;
    childSize = rowKey.currentContext?.size;
    isCounted = true;
    notifyListeners();
  }

  /// Updates the size of a child widget at a given index in the `Wrap`.
  void updateChildrenSize(int index, Size value) {
    _childrenArea.removeAt(index);
    _childrenArea.insert(index, (value.width + spacingChild) * value.height);
    notifyListeners();
  }

  /// Updates the size of the overflow widget.
  void updateOverflowSize(Size value) {
    overflowSize = value;
    notifyListeners();
  }

  /// Updates the total area of the `Wrap`.
  void updateWrapArea(Size size) {
    areaWrap = size.width * size.height;
    countChildWidgetShow();
    notifyListeners();
  }

  /// Calculates the number of child widgets to display within the `Wrap`.
  void countChildWidgetShow() {
    List<double> listOfTempArea = List.generate(maxRowChild, (index) => areaWrap / maxRowChild);

    int indexOfTempArea = 0;
    int showAreaCount = 0;

    List<double> listAreaOfLastChild = [];

    for (int i = 0; i < listOfTempArea.length; i++) {
      while (indexOfTempArea + 1 < _childrenArea.length) {
        listOfTempArea[i] = listOfTempArea[i] - _childrenArea[indexOfTempArea];
        if (i == listOfTempArea.length - 1) {
          listAreaOfLastChild.add(_childrenArea[indexOfTempArea]);
        }
        showAreaCount++;
        if (listOfTempArea[i] < _childrenArea[indexOfTempArea + 1]) {
          indexOfTempArea++;
          break;
        }
        indexOfTempArea++;
      }
    }

    double lastRowArea = listAreaOfLastChild.sum + (overflowSize.width * overflowSize.height);

    if (lastRowArea >= listOfTempArea.last) {
      showAreaCount--;
    }
    showChildCount = showAreaCount;
    isRendered = true;
    notifyListeners();
  }
}
