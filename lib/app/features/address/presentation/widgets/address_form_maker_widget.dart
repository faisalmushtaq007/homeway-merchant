part of 'package:homemakers_merchant/app/features/address/index.dart';

class AddressFormMakerWidget extends StatelessWidget {
  const AddressFormMakerWidget({
    super.key,
    this.title,
    required this.child,
    this.titleStyle,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.textDirection,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.gap = 16.0,
  });

  ///
  /// [title] is the title of the form field
  ///
  final String? title;
  final Widget child;

  ///
  /// [titleStyle] is the style of the title of the form field
  ///
  final TextStyle? titleStyle;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      textBaseline: textBaseline,
      verticalDirection: verticalDirection,
      children: [
        //
        /// check if the [title] is not null
        ///

        if (title != null)

          ///
          /// if the [title] is not null then add a [Padding] widget
          ///
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title!,
                    style:
                        titleStyle ?? Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),

        ///
        /// add a [TextFormField] or child widget
        ///
        child,

        ///
        /// add a [SizedBox] widget
        ///
        AnimatedGap(
          gap,
          duration: const Duration(milliseconds: 250),
        ),
      ],
    );
  }
}
