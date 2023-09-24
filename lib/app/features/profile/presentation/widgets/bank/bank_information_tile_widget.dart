part of 'package:homemakers_merchant/app/features/profile/index.dart';

class BankInformationTileWidget extends StatelessWidget {
  const BankInformationTileWidget({
    required this.bankInfoTile,
    super.key,
  });

  final BankInfoTile bankInfoTile;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: Padding(
        padding: EdgeInsetsDirectional.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          textDirection:
              serviceLocator<LanguageController>().targetTextDirection,
          children: [
            Wrap(
              children: [
                Text(
                  bankInfoTile.label,
                  style: context.labelLarge!.copyWith(
                    color: const Color.fromRGBO(165, 166, 168, 1),
                  ),
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Wrap(
              children: [
                Text(
                  bankInfoTile.content,
                  style: context.labelLarge!.copyWith(
                    color: context.colorScheme.onBackground,
                  ),
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
