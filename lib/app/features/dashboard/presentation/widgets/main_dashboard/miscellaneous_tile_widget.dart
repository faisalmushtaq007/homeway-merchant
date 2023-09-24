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
    return InkWell(
      key: ObjectKey(miscellaneousTileInfo),
      onTap: miscellaneousTileInfo.onPressed,
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 12.0, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
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
                    style: context.titleMedium!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const AnimatedGap(4, duration: Duration(milliseconds: 100)),
              Wrap(
                children: [
                  Text(
                    miscellaneousTileInfo.subTitle,
                    style: context.labelMedium!.copyWith(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 100)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Wrap(
                    children: [
                      Text(
                        miscellaneousTileInfo.value.toString(),
                        style: context.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: const Color.fromRGBO(255, 90, 39, 1),
                        ),
                      ).translate(),
                    ],
                  ),
                  const AnimatedGap(4, duration: Duration(milliseconds: 100)),
                  Wrap(
                    children: [
                      Text(
                        miscellaneousTileInfo.message,
                        style: context.labelMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          //color: Color.fromRGBO(255, 125, 113, 1),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ).translate(),
                    ],
                  ),
                ],
              ),
              const AnimatedGap(4, duration: Duration(milliseconds: 100)),
            ],
          ),
        ),
      ),
    );
  }
}
