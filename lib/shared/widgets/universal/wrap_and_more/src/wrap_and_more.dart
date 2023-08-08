part of wrap_and_more;

/// A custom widget that extends Flutter's StatelessWidget and provides
/// a wrapped layout with an option to show an "overflow" widget when the
/// number of children exceeds a certain limit (maxRow).
///
/// The `WrapAndMore` widget lays out its children in a Wrap widget and
/// displays the specified `overflowWidget` when the children exceed the
/// maximum number of rows specified by the `maxRow` parameter. The number
/// of children to display is automatically determined based on the available
/// space within the Wrap.
///
/// The `overflowWidget` parameter is a function that takes an integer as input,
/// representing the number of remaining children beyond the `maxRow`, and
/// returns a widget to display as the "overflow" representation.
///
/// The `spacing` and `runSpacing` parameters control the spacing between
/// children in the Wrap.
///
/// The `children` parameter is a list of widgets to display within the Wrap.
///
/// Example Usage:
///
/// ```dart
/// WrapAndMore(
///   maxRow: 2,
///   spacing: 8.0,
///   runSpacing: 8.0,
///   overflowWidget: (restChildrenCount) {
///     return Text(
///       '+ $restChildrenCount more',
///       style: TextStyle(color: Colors.grey),
///     );
///   },
///   children: [
///     // Add your widgets here
///   ],
/// )
/// ```
class WrapAndMore extends StatefulWidget with GetItStatefulWidgetMixin {
  /// The maximum number of rows to show within the Wrap.
  final int maxLine;

  /// The spacing between children in the Wrap.
  final double spacing;

  /// The run spacing between rows of children in the Wrap.
  final double runSpacing;

  /// A function that takes the number of remaining children beyond `maxRow`
  /// as input and returns a widget to represent the "overflow" children.
  final Widget Function(int restChildrenCount) overflowWidget;

  /// The list of widgets to display within the Wrap.
  final List<Widget> children;

  /// Direction
  final Axis direction;

  double? height;
  double width;

  /// Creates a WrapAndMore widget.
  ///
  /// The `maxRow` parameter specifies the maximum number of rows to display
  /// in the Wrap. The `spacing` and `runSpacing` parameters control the
  /// spacing between children in the Wrap.
  ///
  /// The `overflowWidget` parameter is a function that takes an integer as
  /// input, representing the number of remaining children beyond the `maxRow`,
  /// and returns a widget to display as the "overflow" representation.
  ///
  /// The `children` parameter is a list of widgets to display within the Wrap.
  WrapAndMore({
    Key? key,
    required this.maxLine, // this.maxRow
    this.spacing = 0.0,
    this.runSpacing = 0.0,
    required this.overflowWidget,
    required this.children,
    this.direction = Axis.horizontal,
    this.width = 100,
    this.height,
  }) : super(key: key);

  @override
  State<WrapAndMore> createState() => _WrapAndMoreState();
}

class _WrapAndMoreState extends State<WrapAndMore> with GetItStateMixin {
  final GlobalKey rowKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    serviceLocator<WrapAndMoreController>().initData(children: widget.children, key: rowKey, maxRow: widget.maxLine, spacing: widget.spacing);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      key: ObjectKey(widget.children),
      animation: serviceLocator<WrapAndMoreController>(),
      builder: (controller, child) {
        if (serviceLocator<WrapAndMoreController>().isCounted) {
          return MeasureSize(
            onChange: (size) {
              serviceLocator<WrapAndMoreController>().updateWrapArea(size);
              widget.overflowWidget(serviceLocator<WrapAndMoreController>().showChildCount);
            },
            child: SizedBox(
              height: (serviceLocator<WrapAndMoreController>().overflowSize.height * widget.maxLine) + (widget.runSpacing * (widget.maxLine - 1)),
              child: Wrap(
                direction: widget.direction,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                spacing: widget.spacing,
                runSpacing: widget.runSpacing,
                children: serviceLocator<WrapAndMoreController>().isRendered
                    ? [
                        ...widget.children.take(serviceLocator<WrapAndMoreController>().showChildCount).toList(),
                        if (widget.children.length - serviceLocator<WrapAndMoreController>().showChildCount > 0)
                          widget.overflowWidget(widget.children.length - serviceLocator<WrapAndMoreController>().showChildCount)
                      ]
                    : widget.children.toList(),
              ),
            ),
          );
        }
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: SingleChildScrollView(
            scrollDirection: widget.direction,
            child: Wrap(
              direction: widget.direction,
              key: rowKey,
              children: [
                ...widget.children
                    .asMap()
                    .map((index, Widget value) {
                      return MapEntry(
                          index,
                          MeasureSize(
                            onChange: (Size size) {
                              serviceLocator<WrapAndMoreController>().updateChildrenSize(index, size);
                            },
                            child: value,
                          ));
                    })
                    .values
                    .toList(),
                MeasureSize(
                  child: widget.overflowWidget(0),
                  onChange: (p0) {
                    serviceLocator<WrapAndMoreController>().updateOverflowSize(p0);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
