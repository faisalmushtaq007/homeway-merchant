part of 'package:homemakers_merchant/app/features/dashboard/index.dart';

class MiscellaneousTile extends StatelessWidget {
  const MiscellaneousTile({
    required this.index,
    required this.miscellaneousTileInfo,
    super.key,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  });

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;
  final MiscellaneousTileInfo miscellaneousTileInfo;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 8.0, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  miscellaneousTileInfo.icon,
                ],
              ),
              const AnimatedGap(4, duration: Duration(milliseconds: 100)),
              Wrap(
                children: [
                  Text(
                    miscellaneousTileInfo.title,
                    style: context.titleMedium!.copyWith(),
                  ),
                ],
              ),
              const AnimatedGap(4, duration: Duration(milliseconds: 100)),
              Wrap(
                children: [
                  Text(
                    miscellaneousTileInfo.subTitle,
                    style: context.bodySmall!.copyWith(),
                  ),
                ],
              ),
              const AnimatedGap(6, duration: Duration(milliseconds: 100)),
              Flexible(
                child: miscellaneousTileInfo.child,
              ),
              const AnimatedGap(4, duration: Duration(milliseconds: 100)),
            ],
          ),
        ),
      ),
    );
  }
}
