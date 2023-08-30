part of 'package:homemakers_merchant/app/features/payment/index.dart';

class WalletUserInfoWidget extends StatefulWidget {
  const WalletUserInfoWidget({super.key});

  @override
  _WalletUserInfoWidgetController createState() => _WalletUserInfoWidgetController();
}

class _WalletUserInfoWidgetController extends State<WalletUserInfoWidget> {
  AppUserEntity? appUserEntity;
  BusinessProfileEntity? businessProfileEntity;

  @override
  void initState() {
    super.initState();
    businessProfileEntity = BusinessProfileEntity();
    context.read<BusinessProfileBloc>().add(GetAllBusinessProfile());
  }

  @override
  Widget build(BuildContext context) => BlocListener<BusinessProfileBloc, BusinessProfileState>(
        bloc: context.read<BusinessProfileBloc>(),
        key: const Key('wallet_user_info_bloc_listener'),
        listener: (context, businessProfileState) {
          if (businessProfileState is GetAllBusinessProfileState) {
            if (businessProfileState.businessProfileEntities.isNotNullOrEmpty) {
              businessProfileEntity = businessProfileState.businessProfileEntities.first;
            }
          } else if (businessProfileState is GetBusinessProfileState) {
            businessProfileEntity = businessProfileState.businessProfileEntity;
          }
        },
        child: _WalletUserInfoWidgetView(this),
      );
}

class _WalletUserInfoWidgetView extends WidgetView<WalletUserInfoWidget, _WalletUserInfoWidgetController> {
  const _WalletUserInfoWidgetView(super.state);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      margin: EdgeInsetsDirectional.zero,
      child: DecoratedBox(
        decoration: MatrixDecoration(
          radius: Radius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 12, end: 12, top: 12, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: serviceLocator<LanguageController>().targetTextDirection,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: ImageHelper(
                  image: getUserProfileImagePath(state.businessProfileEntity!),
                  filterQuality: FilterQuality.high,
                  borderRadius: BorderRadiusDirectional.circular(10),
                  imageType: findImageType(getUserProfileImagePath(state.businessProfileEntity!)),
                  imageShape: ImageShape.rectangle,
                  boxFit: BoxFit.cover,
                  defaultErrorBuilderColor: Colors.blueGrey,
                  errorBuilder: const Icon(
                    Icons.image_not_supported,
                    size: 10000,
                  ),
                  loaderBuilder: const CircularProgressIndicator(),
                  matchTextDirection: true,
                  placeholderText: state.businessProfileEntity?.userName ?? '',
                  placeholderTextStyle: context.labelLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              const AnimatedGap(12, duration: Duration(milliseconds: 200)),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning,',
                        style: context.headlineSmall!.copyWith(fontSize: 15),
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ).translate(),
                      const AnimatedGap(2, duration: Duration(milliseconds: 200)),
                      Text(
                        'Prasant Kumar', //'${state.businessProfileEntity?.userName ?? 'User'},',
                        style: context.headlineSmall!.copyWith(fontSize: 17, fontWeight: FontWeight.w500),
                        textDirection: serviceLocator<LanguageController>().targetTextDirection,
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ).translate(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String getUserProfileImagePath(BusinessProfileEntity businessProfileEntity) {
  String defaultAssetPath = 'assets/svg/user_avatar.svg';
  BusinessDocumentUploadedEntity? businessDocumentUploadedEntity = businessProfileEntity.businessDocumentUploadedEntity;
  if (businessDocumentUploadedEntity.isNotNull) {
    appLog.d('Wallet user ${businessDocumentUploadedEntity?.toMap()}');
    if (businessDocumentUploadedEntity!.documentType == DocumentType.selfie) {
      return businessDocumentUploadedEntity.documentFrontAssets?.assetUrl ?? businessDocumentUploadedEntity.documentFrontAssets?.assetPath ?? defaultAssetPath;
    } else {
      return defaultAssetPath;
    }
  }
  return defaultAssetPath;
}
