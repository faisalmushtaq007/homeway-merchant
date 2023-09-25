part of 'package:homemakers_merchant/app/features/dashboard/index.dart';

class PrimaryDashboardMenuCard extends StatelessWidget {
  const PrimaryDashboardMenuCard(
      {required this.primaryDashboardMenuEntity, super.key,this.hasGridViewParent=false,});

  final PrimaryDashboardEntity primaryDashboardMenuEntity;
  final bool hasGridViewParent;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: serviceLocator<LanguageController>().targetTextDirection,
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 300),
        crossFadeState: hasGridViewParent?CrossFadeState.showSecond:CrossFadeState.showFirst,
        secondChild: InkWell(
          onTap: () {
            primaryDashboardMenuEntity.onPressed();
            return;
          },
          child: Card(
            child: AspectRatio(
              aspectRatio: 1/1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: serviceLocator<LanguageController>().targetTextDirection,
                children: [
                  primaryDashboardMenuEntity.leading.copyWith(
                    color: context.colorScheme.primary,
                    size: 40,
                  ),
                  const AnimatedGap(6, duration: Duration(milliseconds: 500)),
                  Text(
                    primaryDashboardMenuEntity.title,
                    style: primaryDashboardMenuEntity.style ??
                        context.titleLarge!
                            .copyWith(fontSize: 18, fontWeight: FontWeight.w400,),
                    textDirection:
                    serviceLocator<LanguageController>().targetTextDirection,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ).translate(),
                ],
              ),
            ),
          ),
        ),
        firstChild: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          textDirection: serviceLocator<LanguageController>().targetTextDirection,
          children: [
            Card(
              key: ValueKey(primaryDashboardMenuEntity.titleID),
              margin: const EdgeInsetsDirectional.only(bottom: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10)),
              child: ListTile(
                //dense: true,
                leading: primaryDashboardMenuEntity.leading.copyWith(
                  color: context.colorScheme.primary,
                ),
                title: Text(
                  primaryDashboardMenuEntity.title,
                  style: primaryDashboardMenuEntity.style ??
                      context.titleMedium!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w500),
                  textDirection:
                      serviceLocator<LanguageController>().targetTextDirection,
                ).translate(),
                onTap: () {
                  primaryDashboardMenuEntity.onPressed();
                  return;
                },
                trailing: InkWell(
                  onTap: () {
                    primaryDashboardMenuEntity.onPressed();
                    return;
                  },
                  child: Directionality(
                    textDirection:
                        serviceLocator<LanguageController>().targetTextDirection,
                    child: primaryDashboardMenuEntity.trailing ??
                        Icon(
                          Icons.arrow_forward_ios,
                          color: context.colorScheme.primary,
                        ),
                  ),
                ),
              ),
            ),
            const AnimatedGap(
              8,
              duration: Duration(milliseconds: 500),
            ),
          ],
        ),
      ),
    );
  }
}
