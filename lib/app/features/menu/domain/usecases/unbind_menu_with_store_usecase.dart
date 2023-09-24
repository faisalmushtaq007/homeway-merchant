part of 'package:homemakers_merchant/app/features/menu/index.dart';

class UnBindMenuWithStoreUseCase extends BindingUseCase<List<MenuEntity>,
    List<StoreEntity>, DataSourceState<List<StoreEntity>>> {
  UnBindMenuWithStoreUseCase({
    required this.menuRepository,
  });

  final MenuRepository menuRepository;

  @override
  Future<DataSourceState<List<StoreEntity>>> call(
      {required List<MenuEntity> source,
      required List<StoreEntity> destination}) async {
    return menuRepository.unBindMenuWithStores(
        source: source, destination: destination);
  }
}
