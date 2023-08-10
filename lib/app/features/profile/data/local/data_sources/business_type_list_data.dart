part of 'package:homemakers_merchant/app/features/profile/index.dart';

List<BusinessTypeEntity> businessTypeList = [
  BusinessTypeEntity(
    businessTypeId: '0',
    businessTypeName: 'Restaurant',
    localAssetWidget: Assets.svg.restaurantType.svg(),
    localAssetPath: 'assets/svg/home_chef_type.svg',
  ),
  BusinessTypeEntity(
    businessTypeId: '1',
    businessTypeName: 'Home Chef',
    localAssetWidget: Assets.svg.homeChefType.svg(),
    localAssetPath: 'assets/svg/restaurant_type.svg',
  ),
];
